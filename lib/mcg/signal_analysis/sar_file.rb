#!/usr/bin/env ruby
# SAR file format support
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/signal_analysis/sar'

module Mpa
  module SignalAnalysis
    module Sar

      class IntData
        UFORMAT = "A32iiA64iII" # char [32], int * 2, char[64], enum, size_t * 2
        PFORMAT = "a32iia64iII"
        FORMAT_SIZE = 116

        # Assumes file has been seeked to correct offset.
        def IntData.from_file( f )
          buf = f.read(FORMAT_SIZE)
          name, ref_role, ref_type, ref_name, type, elem_size, 
                num_elem = buf.unpack(UFORMAT)

          ref = Ref.new( Ref::TYPES[ref_type], Ref::ROLES[ref_role], ref_name )
          buf = f.read(elem_size * num_elem)
          fmt_str = "%s%d" % [TYPES[type], num_elem]
          data = buf.unpack(fmt_str)

          new( name, type, ref, data )
        end

        # Pack contents to binary and write to file
        def to_file( f )
          buf = [@name, @ref.binary_role(), @ref.binary_type(), @ref.name,
                 @type, TYPE_SIZES[@type], 
                 @data.length()].pack(PFORMAT)
          f.write(buf)

          fmt_str = "%s%d" % [TYPES[@type], data.length]
          buf = data.pack(fmt_str)
          f.write(buf)
        end
      end

      class Index
        UFORMAT = "A32A8f" # char[32], char[8], float
        PFORMAT = "a32a8f"
        FORMAT_SIZE = 44

        # Assumes file has been seeked to correct offset.
        def Index.from_file( f )
          buf = f.read(FORMAT_SIZE)
          name, sym, value = buf.unpack(UFORMAT)
          new(name, sym, value)
        end

        # Pack contents to binary and write to file
        def to_file( f )
          buf = [@name, @sym, @value].pack(PFORMAT)
          f.write(buf)
        end
      end

      class Analysis
        UFORMAT = "A64A48A8III" # char [64], char [48], char [8], size_t * 3
        PFORMAT = "a64a48a8III"
        FORMAT_SIZE = 132

        # Assumes file has been seeked to correct offset.
        def Analysis.from_file( f )
          buf = f.read(FORMAT_SIZE)
          source, name, sym, num_indexes, num_idata, size = 
                  buf.unpack(UFORMAT)

          indexes = []
          num_indexes.times { indexes << Index.from_file(f) }

          idata = []
          num_idata.times { idata << IntData.from_file(f) }

          new(source, name, sym, indexes, idata)
        end

        # Pack contents to binary and write to file
        def to_file( f )
          size = 0
          @indexes.each { size += Index::FORMAT_SIZE }
          @idata.each do |i| 
            size += IntData::FORMAT_SIZE
            size += i.data_size
          end

          buf = [@source, @name, @sym, @indexes.length(), @idata.length(), 
                 size].pack(PFORMAT)
          f.write(buf)
          @indexes.each { |i| i.to_file(f) }
          @idata.each { |i| i.to_file(f) }
        end
      end

      class Sar
        MFORMAT = "A4f"     # (magic and version) char[4], float
        MFORMAT_SIZE = 8
        UFORMAT_V1 = "LI"   # (v1) uint32_t, uint32_t
        FORMAT_V1_SIZE = 8
        UFORMAT_V2 = "QI"   # (v2) uint64_t, uint32_t
        FORMAT_V2_SIZE = 12
        PFORMAT = "a4fQI"
        MAGIC = "SARl"
        VERSION = 1.2

        # Create a SAR object from a File object.
        # Assumes file has been seeked to correct offset.
        def Sar.from_file( f )
          # read magic and version
          buf = f.read( MFORMAT_SIZE )
          raise "EMPTY FILE" if (! buf)
          magic, version = buf.unpack(MFORMAT)

          raise "File magic '%s' does not match SAR magic '%s'" % 
                [magic, MAGIC] if magic != MAGIC

          # read rest of file header
          size = FORMAT_V2_SIZE
          fmt = UFORMAT_V2
          if (version - 1.1).abs < 0.1
            size = FORMAT_V1_SIZE
            fmt = UFORMAT_V1
          end
          buf = f.read( size )
          timestamp, num_analyses = buf.unpack(fmt)

          analyses = []
          num_analyses.times { analyses << Analysis.from_file(f) }

          new(timestamp, analyses)
        end

        # Pack contents to binary and write to file
        def to_file( f )
          buf = [ MAGIC, VERSION, @timestamp.to_i, @analyses.length() 
                ].pack(PFORMAT)
          f.write(buf)

          @analyses.each do |a|
            a.to_file(f)
          end
        end

      end

    end
  end
end

if __FILE__ == $0 

  ARGV.each do |arg|
    print "SAR File #{arg}\n"
    begin
      File.open(arg) do |f|
        s = Mpa::SignalAnalysis::Sar::Sar.from_file(f)
        puts s.inspect
      end
    rescue SystemCallError => err
      print "Error opening '#{arg}': #{err}\n"
    end
  end
end
