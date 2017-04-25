#!/usr/bin/env ruby
# DSP file format support
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/signal_analysis/dsp'
require 'mpa/signal_analysis/dsp_ops'

module Mpa
  
  module SignalAnalysis

    module Dsp

      class Op
        UFORMAT = "A64IA32A8A64A32A64A64II"
        PFORMAT = "a64Ia32a8a64a32a64a64II"
        FORMAT_SIZE = 340

        # Assumes file has been seeked to correct offset.
        def Op.from_file( f )
          buf = f.read(FORMAT_SIZE)
          source, src_type, name, sym, label, domain, x, y,
                  num_elem, elem_size = buf.unpack(UFORMAT)

          buf = f.read(elem_size * num_elem)
          # NOTE: currently DSP only supports signed short elements.
          #       in the future, the DSP struct will encode a data type attr.
          data = buf.unpack("s#{num_elem}")

          new(source, Op::SOURCE_TYPES[src_type], name, sym, label, domain, 
              x, y, data)
        end

        # Pack contents to binary and write to file
        def to_file( f )
          # NOTE: data element size is hard-coded to 2. See above NOTE.
          buf = [@source, Op::SOURCE_TYPES.index(@src_type), @name, @sym, 
                 @label, @domain, @x_axis, @y_axis, 
                 @data.length(), 2].pack(PFORMAT)
          f.write(buf)

          # NOTE: again, element is hard-coded to a signed short.
          buf = data.pack("s#{@data.length()}")
          f.write(buf)
        end
      end

      class Dsp
        MFORMAT = "A4f"     # (magic and version) char[4], float
        MFORMAT_SIZE = 8
        UFORMAT_V1 = "LI"   # (v1) uint32_t, uint32_t
        FORMAT_V1_SIZE = 8
        UFORMAT_V2 = "QI"   # (v2) uint64_t, uint32_t
        FORMAT_V2_SIZE = 12
        PFORMAT = "a4fQI"
        MAGIC = "DSPl"
        VERSION = 2.2
        P56_SIZE = 5652
        P56_ALT_SIZE = 5689
        P56_DATA_OFFSET = 256
        K52_SIZE = 5290

        # Create a DSP object from a File object.
        # Assumes file has been seeked to correct offset.
        def self.from_file( f )
          # read magic and version
          buf = f.read( MFORMAT_SIZE )
          raise "EMPTY FILE" if (! buf)
          magic, version = buf.unpack(MFORMAT)

          if magic != MAGIC
            f.seek(-MFORMAT_SIZE, IO::SEEK_CUR)
            pos = f.pos
            f.seek(0, IO::SEEK_END)
            size = f.pos - pos
            f.seek(pos, IO::SEEK_SET)

            if size == P56_SIZE or size == P56_ALT_SIZE
              return from_p56(f)
            elsif size == K52_SIZE
              return from_k52(f)
            else
              raise "File magic '%s' does not match DSP magic '%s'" % 
                     [magic, MAGIC]
            end
          end

          # read rest of file header
          size = FORMAT_V2_SIZE
          fmt = UFORMAT_V2
          if (version - 2.1).abs <= 0.1
            size = FORMAT_V1_SIZE
            fmt = UFORMAT_V1
          end
          buf = f.read( size )
          timestamp, num_ops = buf.unpack(fmt)

          ops = []
          num_ops.times { ops << Op.from_file(f) }

          new(timestamp, ops)
        end

        def self.from_p56( f )
          f.seek(P56_DATA_OFFSET, IO::SEEK_CUR)
          from_k52(f)
        end

        def self.from_k52( f )
          sig_a = 'V5'
          sig_b = 'II'
          dsp = new()
          dsp.create_std_ops( sig_a, sig_b )
          # read all legacy opts
          dsp.operation(Op::APS_NAME, sig_a).data = data_from_k52(f, 128)
          dsp.operation(Op::APS_NAME, sig_b).data = data_from_k52(f, 128)
          dsp.operation(Op::COH_NAME).data = data_from_k52(f, 128)
          dsp.operation(Op::XAR_NAME).data = data_from_k52(f, 128)
          dsp.operation(Op::PSA_NAME).data = data_from_k52(f, 128)
          dsp.operation(Op::IMR_NAME).data = data_from_k52(f, 256)
          dsp.operation(Op::CCR_NAME).data = data_from_k52(f, 512)
          dsp.operation(Op::AMP_NAME, sig_a).data = data_from_k52(f, 100)
          dsp.operation(Op::AMP_NAME, sig_b).data = data_from_k52(f, 100)
          dsp.operation(Op::QRS_NAME, sig_a).data = data_from_k52(f, 512)
          dsp.operation(Op::QRS_NAME, sig_b).data = data_from_k52(f, 512)
          return dsp
        end

        def self.data_from_k52(f, size)
          buf = f.read(size * 2)
          buf.unpack("s#{size}")
        end

        # Pack contents to binary and write to file
        def to_file( f )
          buf = [MAGIC, VERSION, @timestamp, @operations.length()
                ].pack(PFORMAT)
          f.write(buf)

          @operations.each { |o| o.to_file(f) }
        end
      end

    end
  end
end

if __FILE__ == $0 

  ARGV.each do |arg|
    print "DSP File #{arg}\n"
    begin
      File.open(arg) do |f|
        d = Mpa::SignalAnalysis::Dsp::Dsp.from_file(f)
        puts d.inspect
      end
    rescue SystemCallError => err
      print "Error opening '#{arg}': #{err}\n"
    end
  end
end
