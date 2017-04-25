#!/usr/bin/env ruby
# :title: Mpa::Diagnosis::Dcf
=begin rdoc
=Dcf Library
<i>(c) Copyright 2017 Premier Heart, LLC</i>
DCF (disease control factor) file handing methods.
=end

require 'mpa/diagnosis/dcf'

module Mpa
  
  module Diagnosis

    module Dcf

=begin rdoc
  Dcf.Dcf :
=end
      class Dcf
        UFORMAT = "A64A8i"
        PFORMAT = "a64a8i"
        FORMAT_SIZE = 76

        def to_file( f )
          buf = [@name, @sym, @value.binary_datatype,
                 @value.data_size].pack(PFORMAT)
          f.write(buf)
          data = (@value.type == 'c') ? @value.data.bytes.first : @value.data
          data ||= 0
          buf = [data].pack(@value.type)
          f.write(buf)
        end

        def Dcf.from_file( f )

          buf = f.read(FORMAT_SIZE)
          raise "EMPTY FILE" if (! buf)
          name, sym, vtype = buf.unpack(UFORMAT)
          dtype = Mpa::Diagnosis::Dcf::Value::TYPES[vtype]
          vsize =  Mpa::Diagnosis::Dcf::Value::TYPE_SIZES[vtype]
          buf = f.read(vsize)
          dtype = (dtype == 'c') ? 'a1' : dtype
          value = Mpa::Diagnosis::Dcf::Value.new( dtype, buf.unpack(dtype)[0] )
          dcf = new(name, sym, value)

          return dcf
        end

      end

=begin rdoc
  Dcf.List
=end
      class List
        MFORMAT = "A4f"     # (magic and version) char[4], float
        MFORMAT_SIZE = 8
        UFORMAT_V1 = "LI"   # (v1) uint32_t, uint32_t
        FORMAT_V1_SIZE = 8
        UFORMAT_V2 = "QI"   # (v2) uint64_t, uint32_t
        FORMAT_V2_SIZE = 12
        PFORMAT = "a4fQI"
        MAGIC = "DCFl"
        VERSION = 1.1

        def to_file( f )
          buf = [MAGIC, VERSION, @timestamp.to_i, length()].pack(PFORMAT)
          f.write(buf)

          each do |d|
            d.to_file(f)
          end
        end

        def List.from_file( f )
          # read magic and version
          buf = f.read( MFORMAT_SIZE )
          magic, version = buf.unpack(MFORMAT)

          raise "File magic '%s' does not match DCF magic '%s'" % 
                [magic, MAGIC] if magic != MAGIC

          # read rest of file header
          size = FORMAT_V2_SIZE
          fmt = UFORMAT_V2
          if (version - 1.0).abs <= 0.1
            size = FORMAT_V1_SIZE
            fmt = UFORMAT_V1
          end
          buf = f.read( size )
          timestamp, num_dcfs = buf.unpack(fmt)

          list = new(timestamp)
          num_dcfs.times do
            list << Mpa::Diagnosis::Dcf::Dcf.from_file(f)
          end 

          return list
        end

      end

    end
  end
end


if __FILE__ == $0 

  ARGV.each do |arg|
    print "DCF File #{arg}\n"
    begin
      File.open(arg) do |f|
        d = Mpa::Diagnosis::Dcf::List.from_file(f)
        puts d.inspect
      end
    rescue SystemCallError => err
      print "Error opening '#{arg}': #{err}\n"
    end
  end
end
