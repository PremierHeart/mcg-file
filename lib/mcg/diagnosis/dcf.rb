#!/usr/bin/env ruby
# :title: Mpa::Diagnosis::Dcf
=begin rdoc
=Dcf Library
<i>(c) Copyright 2017 Premier Heart, LLC</i>

Patient Disease Control Factors (DCF) are used during statistical analysis
to weight the diagnoses based on patient weight, age, etc.
=end

require 'delegate'

module Mpa
  
  module Diagnosis

    module Dcf
      # Standard DCFs
      GENDER_NAME = "gender"
      GENDER_SYM = "Sex"
      GENDER_TYPE = "c"
      GENDER_MALE = "M"
      GENDER_FEMALE = "F"

      AGE_NAME = "age"
      AGE_SYM = "Age"
      AGE_TYPE = "C"

=begin rdoc
  Dcf.Value :
=end
      class Value
        attr_reader :type
        attr_accessor :data
        TYPES = ['o','c','C','a1', 'i','I','f','d']
        TYPE_SIZES = [0,1,1,1, 4,4,4,8]

        def initialize( type, data=0 )
          @type = type
          @data = data
        end

        def binary_datatype
          return TYPES.index(@type)
        end

        def type_size
          TYPE_SIZES[TYPES.index(@type) || 0]
        end

        def data_size
          size = type_size
          if size == 0
            size = @data.length()
          end
          return size
        end

        def to_s
          if @type == 'c'
            return @data[0]
          elsif type_size == 0
            return "[Array]"
          else
            return @data.to_s
          end
        end

        def inspect
          "(#{TYPES[@type]}) #{@data.to_s}"
        end

      end

=begin rdoc
  Dcf.Dcf :
=end
      class Dcf
        attr_reader :name, :sym
        attr_accessor :value

        def initialize( name, sym, value )
          @name = name
          @sym = sym 
          @value = value
        end

        def to_s
          "#{@name} (#{@sym})"
        end

        def inspect
          "%s:%s" % [self.to_s, @value.to_s()]
        end

        def to_h
          { :name => @name,
            :sym => @sym,
            :value => { :type => value.type, :data => value.data }
          }
        end

        def self.from_h(hash)
          hash ||= {}
          h = hash.inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          return nil if (! h[:value])
          val = Value.new(h[:value][:type], h[:value][:data])
          self.new(h[:name], h[:sym], val)
        end

      end

=begin rdoc
  Dcf.List
=end
      class List < DelegateClass(Array)
        attr_accessor :timestamp

        def initialize( timestamp=Time.now.to_i(), arr=[] )
          @timestamp = timestamp
          super(arr)
        end

        def to_h
          { :timestamp => @timestamp,
            :dcf => map { |item| item.to_h }
          }
        end

        def self.from_h(hash)
          hash ||= {}
          h = hash.inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          obj = self.new( h[:timestamp] )
          (h[:dcf] || []).each { |dcf| obj << Dcf.from_h(dcf) }
          obj
        end

      end

    end
  end
end


if __FILE__ == $0 
  dcf_list = Mpa::Diagnosis::Dcf::List.new()

  dcf_list << Mpa::Diagnosis::Dcf::Dcf.new('float dcf', 'fdcf', 
                              Mpa::Diagnosis::Dcf::Value.new('f', 1.0) )
  dcf_list << Mpa::Diagnosis::Dcf::Dcf.new('char dcf', 'cdcf', 
                              Mpa::Diagnosis::Dcf::Value.new('c', 'X') )
  dcf_list << Mpa::Diagnosis::Dcf::Dcf.new('int dcf', 'idcf', 
                              Mpa::Diagnosis::Dcf::Value.new('i', -1) )
  dcf_list << Mpa::Diagnosis::Dcf::Dcf.new('gender', 'Sex', 
                              Mpa::Diagnosis::Dcf::Value.new('c', 'M') )
  dcf_list << Mpa::Diagnosis::Dcf::Dcf.new('age', 'Age', 
                              Mpa::Diagnosis::Dcf::Value.new('C', 42) )
  puts dcf_list
end
