#!/usr/bin/env ruby
# ECG file format support
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/signal_analysis/signal_sample'

module Mpa
  
  module SignalAnalysis

    module Sample

      class SignalSample
        UFORMAT = "A16fI"
        PFORMAT = "a16fI"
        FORMAT_SIZE = 24
        DTYPE = [ 'c', 'c', 's', 's', 'i' ]

        def self.from_file( f, timestamp, elem_size, block_size, num_blocks )
          buf = f.read(FORMAT_SIZE)
          name, gain, checksum = buf.unpack(UFORMAT)

          count = block_size * num_blocks
          buf = f.read(elem_size * count)
          data = buf.unpack("#{DTYPE[elem_size]}#{count}")

          signal = Signal.new(name, elem_size, block_size, gain)
          new(signal, data, timestamp)
        end

        def to_file(f)
          buf = [@signal.name ,@signal.gain, @checksum].pack(PFORMAT)
          f.write(buf)

          # truncate data to a segment boundary
          dat = @data[0, (@num_blocks * @signal.block_size)]

          buf = dat.pack("#{DTYPE[@signal.elem_size]}#{dat.length()}")
          f.write(buf)
        end
      end

      # Note: Signals in SignalPair are stored by name on-disk.
      class SignalPair
        UFORMAT = "A16A16f"
        PFORMAT = "a16a16f"
        FORMAT_SIZE = 36

        def self.from_file( f, sigs )
          buf = f.read(FORMAT_SIZE)

          name_a, name_b, ratio = buf.unpack(UFORMAT)
          lead_a = sigs.select { |x| x.name == name_a } .first
          lead_b = sigs.select { |x| x.name == name_b } .first

          new(lead_a, lead_b, ratio)
        end

        def to_file(f)
          buf = [@signals['a'].name, @signals['b'].name, @ratio].pack(PFORMAT) 
          f.write(buf)
        end
      end

      class Sample
        MFORMAT = "A4f"                  # (magic and version) char[4], float
        MFORMAT_SIZE = 8
        UFORMAT_V2 = "IIIIIIA16IIIIII"   # (v2) 6 x uint32_t, db_header
        FORMAT_V2_SIZE = 64
        UFORMAT_V3 = "QIIIII"            # (v3) uint64_t, 5 x uint32_t
        FORMAT_V3_SIZE = 28 
        PFORMAT = "a4fQIIIII"
        MAGIC = "ECG:"
        VERSION = 3.0
        K32_SIZE = 33032
        K32_DATA_OFFSET = 256
        V1_SIZE = 32776
        
        # Create a Sample object from a File object.
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

            if size == K32_SIZE
              return from_k32(f) 
            elsif size == K32_SIZE
              return from_v1(f) 
            else
              raise "File magic '%s' does not match ECG magic '%s'" % 
                    [magic, MAGIC] 
            end
          end

          # read rest of file header
          size = FORMAT_V3_SIZE
          fmt = UFORMAT_V3
          if (version - 2.0).abs <= 0.1
            size = FORMAT_V2_SIZE
            fmt = UFORMAT_V2
          end
          buf = f.read( size )
          timestamp, num_pairs, num_leads, num_segs, num_elem, elem_size = 
            buf.unpack(fmt)
          # If V2, elem size will contain all DB header fields
          elem_size = elem_size.first if elem_size.is_a? Array

          leads = []
          num_leads.times do
            leads << SignalSample.from_file(f, timestamp, elem_size, num_elem,
                                            num_segs) 
          end

          sigs = []
          sigs = leads.inject([]) { |sigs, lead| sigs << lead.signal }

          pairs = []
          num_pairs.times { pairs << SignalPair.from_file(f, sigs) }

          new(Config.new(sigs, pairs), leads)
        end

        def self.from_k32(f)
          f.seek(K32_DATA_OFFSET, IO::SEEK_CUR)
          from_v1(f)
        end

        V1_GAIN_FORMAT = 'ff'
        V1_GAIN_SIZE = 8
        V1_LEAD_A = 'V5'
        V1_LEAD_B = 'II'
        V1_RATIO = 1.3
        V1_ELEM_SIZE = 2
        V1_BLOCK_SIZE = 512
        V1_NUM_BLOCKS = 16

        def self.from_v1(f)
          # read gains
          buf = f.read(V1_GAIN_SIZE)
          gain_a, gain_b = buf.unpack(V1_GAIN_FORMAT)

          # read data
          count = V1_BLOCK_SIZE * V1_NUM_BLOCKS
          buf = f.read(V1_ELEM_SIZE * count)
          data_a = buf.unpack("s#{count}")
          buf = f.read(V1_ELEM_SIZE * count)
          data_b = buf.unpack("s#{count}")

          sigs = [ Signal.new(V1_LEAD_A, V1_ELEM_SIZE, V1_BLOCK_SIZE, gain_a),
                   Signal.new(V1_LEAD_B, V1_ELEM_SIZE, V1_BLOCK_SIZE, gain_b) ]
          pairs = [ SignalPair.new(sigs[0], sigs[1], V1_RATIO) ]
          leads = [ SignalSample.new(sigs[0], data_a),
                    SignalSample.new(sigs[1], data_b) ]
          new(Config.new(sigs, pairs), leads)
        end
        
        # Pack contents to binary and write to file
        def to_file( f )
          num_segments = @signals.first[1].num_blocks
          num_elements = @signals.first[1].signal.block_size
          elem_size = @signals.first[1].signal.elem_size
          ts = @signals.first[1].timestamp
          buf = [MAGIC, VERSION, ts.to_i, @pairs.length, @signals.length,
                 num_segments, num_elements, elem_size
                ].pack(PFORMAT)
          f.write(buf)

          @signals.values.each { |s| s.to_file(f) }
          @pairs.each { |p| p.to_file(f) }
        end
      end

    end
  end
end

if __FILE__ == $0 

  ARGV.each do |arg|
    print "ECG File #{arg}\n"
    begin
      File.open(arg) do |f|
        s = Mpa::SignalAnalysis::Sample::Sample.from_file(f)
        puts s.inspect
      end
    rescue SystemCallError => err
      print "Error opening '#{arg}': #{err}\n"
    end
  end
end
