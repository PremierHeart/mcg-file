#!/usr/bin/env ruby
# DGO file format support
# (c) Copyright 2017 Premier Heart, LLC

require 'mpa/diagnosis/dgo'

module Mpa
  module Diagnosis
    module Dgo

      class Value
        def pack_str
          TYPE_SIZES[TYPES.index(@type)] == 0 ? 
                    "#{@type}#{@data.length}" : @type
        end
      end

      class Ref
        @@uformat = "iA64A64A64f"
        @@pformat = "ia64a64a64f"
        @@format_size = 200

        def to_file( f )
          buf = [TYPES.index(@type), @source, @component, @item, 
                 @weight].pack(@@pformat)
          f.write(buf)
        end

        def Ref.from_file( f )
          buf = f.read(@@format_size)
          type_idx, source, component, item, weight = buf.unpack(@@uformat)
          type = TYPES[type_idx]
          new(type, source, component, item, weight)
        end

      end

      class Diagnosis
        @@uformat = "A64A8iiII"
        @@pformat = "a64a8iiII"
        @@format_size = 88

        def to_file( f )
          buf = [@name, @sym, (@positive ? 1 : 0), @value.binary_datatype,
                 @value.data_size, @refs.count()].pack(@@pformat)
          f.write(buf)
          buf = [@value.data].pack(@value.pack_str)
          rv = f.write(buf)
          @refs.each { |r| r.to_file(f) }
        end

        def Diagnosis.from_file( f )
          buf = f.read(@@format_size)
          name, sym, positive, vtype, vsize, num_refs = buf.unpack(@@uformat)
          positive = (positive == 0) ? false : true
          dtype = Mpa::Diagnosis::Dgo::Value::TYPES[vtype]
          buf = f.read(vsize)
          udtype = (dtype == 'a') ? "A#{vsize}" : dtype
          value = Mpa::Diagnosis::Dgo::Value.new( dtype, buf.unpack(udtype)[0] )
          diag = new(name, sym, positive, value)
          num_refs.times do
            diag.refs << Mpa::Diagnosis::Dgo::Ref.from_file(f) 
          end

          return diag
        end

      end

      class Algorithm
        @@uformat = "A64A8I"
        @@pformat = "a64a8I"
        @@format_size = 76

        def to_file( f )
          buf = [@name, @sym, @diagnoses.count()].pack(@@pformat)
          f.write(buf)
          @diagnoses.each { |d| d.to_file(f) }
        end

        def Algorithm.from_file( f )
          buf = f.read(@@format_size)
          name, sym, num_diags = buf.unpack(@@uformat)
          algo = new(name, sym)
          num_diags.times do
            algo.diagnoses << Mpa::Diagnosis::Dgo::Diagnosis.from_file(f) 
          end

          return algo
        end

      end

      class Dgo
        MFORMAT = "A4f"     # (magic and version) char[4], float
        MFORMAT_SIZE = 8
        UFORMAT_V1 = "LI"   # (v1) uint32_t, uint32_t
        FORMAT_V1_SIZE = 8
        UFORMAT_V2 = "QI"   # (v2) uint64_t, uint32_t
        FORMAT_V2_SIZE = 12
        PFORMAT = "a4fQI"
        MAGIC = "DGOl"
        VERSION = 1.1

        def to_file( f )
          buf = [MAGIC, VERSION, @timestamp, 
                 @algorithms.length()].pack(PFORMAT)
          f.write(buf)

          algorithms.each do |a|
            a.to_file(f)
          end
        end

        def Dgo.from_file( f )
          # read magic and version
          buf = f.read( MFORMAT_SIZE )
          raise "EMPTY FILE" if (! buf)

          magic, version = buf.unpack(MFORMAT)

          raise "File magic '%s' does not match DGO magic '%s'" % 
                [magic, MAGIC] if magic != MAGIC

          # read rest of file header
          size = FORMAT_V2_SIZE
          fmt = UFORMAT_V2
          if (version - 1.0).abs <= -0.1
            size = FORMAT_V1_SIZE
            fmt = UFORMAT_V1
          end
          buf = f.read( size )
          timestamp, num_algos = buf.unpack(fmt)

          dgo = new(timestamp)
          num_algos.times do
            dgo.algorithms << Mpa::Diagnosis::Dgo::Algorithm.from_file(f)
          end 

          return dgo
        end

      end

    end
  end
end

if __FILE__ == $0 

  ARGV.each do |arg|
    print "DGO File #{arg}\n"
    begin
      File.open(arg) do |f|
        d = Mpa::Diagnosis::Dgo::Dgo.from_file(f)
        puts d.inspect
      end
    rescue SystemCallError => err
      print "Error opening '#{arg}': #{err}\n"
    end
  end
end
