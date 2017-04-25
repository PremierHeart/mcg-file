#!/usr/bin/env ruby
# :title: Mpa::SignalAnalysis::Sar
=begin rdoc
=SAR Library
<i>(c) Copyright 2017 Premier Heart, LLC</i>

SAR (Signal Analysis Reults) is an in-memory representation of the 
data produced by signal analyses. Each analysis produces intermediate data, 
such as a list of apexes, and output scores, i.e. indexes of signal 
characteristics.
=end

module Mpa
  
  module SignalAnalysis

    module Sar

=begin rdoc
A reference from an IntData object to its source data. This is used to 
provide context for IntData objects.
=end
      class Ref
        attr_reader :role, :type, :name
        TYPES = [ 'DSP', 'Signal', 'Intermediate Data', 'Index', 'Misc' ]
        ROLES = [ 'x axis', 'y axis', 'z axis', 'ratio', 'count', 'score' ]

        def initialize( type, role, name )
          @type = type
          @role = role
          @name = name
        end

        def binary_type
          TYPES.index(@type)
        end

        def binary_role
          ROLES.index(@role)
        end

        def to_h
          { :type => @type, :role => @role, :name => @name }
        end

        def to_s
          "(#{@type} #{@role}) '#{@name}'"
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( h[:type].to_s, h[:role].to_s, h[:name].to_s )
        end

        def inspect
          self.to_s
        end

      end

=begin rdoc
Arbitrary data generated during the feature-generation stage of analysis.

IntData objects contain a reference to the data from which they were
computed. This may be a reference to raw SignalSample data, DSP data, 
another IntData object, or an Index object.
=end
      class IntData
        attr_reader :name, :type
        attr_accessor :data, :ref
        # NOTE: capital means unsigned
        TYPES = ['a','c','C','s','S','i','I','l','L','f','d','a','a']
        TYPE_SIZES = ['1',1,1,2,2,4,4,4,4,4,8,1,1]

        # NOTE: 'data' is an array of at least 1 element
        def initialize( name, type, ref, data=[] )
          @name = name
          @type = type
          @ref = ref
          @data = data
        end

        def binary_datatype
          TYPES.index(@type)
        end

        def data_size
          @data.length() * TYPE_SIZES[@type]
        end

        def to_h
          { :name => @name , :type => @type, 
            :ref => @ref ? @ref.to_h : nil, :data => @data }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          ref = h[:ref] ?  Ref.from_h(h[:ref]) : nil
          self.new( h[:name].to_s, h[:type].to_s, ref, h[:data] )
        end

        def to_s
          "#{@name} (#{@ref.to_s})"
        end

        def inspect
          "(%s) %s: %s" % [@type, self.to_s, @data.join(',')]
        end

      end

=begin rdoc
A feature generated during analysis. This is usually a boolean value (is
feature present? true or false), but in some cases a numeric value is
stored.

Index objects are intended to be used in statistical analysis (e.g. machine
learning); arbitrary data generated during analysis should be stored in
IntData objects instead of Index objects.
=end
      class Index
        attr_reader :name, :sym
        attr_accessor :value

        POSITIVE = 1.0
        NEGATIVE = 0.0

        def initialize( name, sym, value=0.0 )
          @sym = sym
          @name = name
          @value = value
        end

=begin rdoc
Return true is index is set or "positive". This is the moral equivalent of
testing if the index greater than 0.0.

Note that there are three types of values typically stored in indexes:
Boolean (0 or 1),  Integer (0, 1, 2, or higher), and "Integer-and-a-half"
(0, 0.5, 1, 1.5, 2, 2.5). This final category is used in severity indexes
and is likely to be eliminated when severity calculation is modernized.

Statistical calculations used to weight indexes may result in values between
0.0 and 0.5. These should be treated as zero for the purposes of is_set?().
=end
        def is_set?
          (@value - NEGATIVE) >= 0.5
        end

        def not_set?
          (! is_set?)
        end

        def to_h
          { :name => @name , :sym => @sym, :value => @value }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( h[:name].to_s, h[:sym].to_s, h[:value] )
        end

        def to_s
          "%s (%s) : %0.1f" % [@name, @sym, @value]
        end

      end

=begin rdoc
A Null object for indexes which do not exist.
The purpose of this is to allow the return value of Analysis#index to be
referenced like an Index object, even when the specified index was not found.

To test for a missing index:
  idx = op.index( idx_name )
  raise "Missing '#{idx_name}' if idx.is_a? Mpa::SignalAnalysis::Sar::NullIndex
=end
      class NullIndex
        attr_reader :name, :sym
        attr_accessor :value

        def initialize( name, sym )
          @name = name
          @sym = name
          @value = Index::NEGATIVE
        end

        def is_set?
          return false
        end

        # act like a nil, when asked
        def nil?
          return true
        end

        def to_s
          "NullIndex (#{@name})"
        end
      end

=begin rdoc
An analysis module which contains Index and IntData objects. This is usually
the result of performing feature generation on DSP data, but can also 
contain intermediate data used in feature generation.
The Index and IntData objects are stored in an Array, not a Hash, so they do
not *have* to be uniquely-named, but they should be. Note that methods like
Analysis#index return the first matching object.
=end
      class Analysis
        attr_accessor :indexes, :idata
        attr_reader :source, :name, :sym

        def initialize( source, name, sym, indexes=[], idata=[] )
          @source = source
          @name = name
          @sym = sym
          @indexes = indexes
          @idata = idata
        end

=begin rdoc
Return the complete name (name + source) for the analysis. This is used to
disambiguate analyses for multiple leads. If skip_pair is true, then
analyses for lead pairs will not include the source component. The name and 
source components are separated by ' ' unless the user provides sep.
=end
        def fullname(sep=' ', skip_pair=false)
          (skip_pair and @source.start_with? '(') ? @name :
                                                    "#{@name}#{sep}#{@source}"
        end

=begin rdoc
See fullname. This uses sym instead of name.
=end
        def fullsym(sep=' ', skip_pair=false)
          (skip_pair and @source.start_with? '(') ? @sym : 
                                                    "#{@sym}#{sep}#{@source}"
        end


        def index( name )
          idx = @indexes.collect { |i| i.name == name ? i : nil }.compact.at(0)
          idx = NullIndex.new(name, name) if not idx
          return idx
        end

        def index_sym( sym )
          idx = @indexes.collect { |i| i.sym == sym ? i : nil }.compact.at(0)
          idx = NullIndex.new(sym, sym) if not idx
          return idx
        end

        def include?( name )
          @indexes.each { |i| return true if i.name == name }
          false
        end

        def data( name )
          @idata.collect { |i| i.name == name ? i : nil }.compact.at(0)
        end

        def add_index(name, sym, value)
          indexes << Mpa::SignalAnalysis::Sar::Index.new(name, sym, value)
        end

        def add_idata(name, type, data, ref=nil)
          idata << Mpa::SignalAnalysis::Sar::IntData.new( name, type, ref,
                                                          [data].flatten )
        end

        def add_idata_i(name, data, ref=nil)
          add_idata(name, 'i', data, ref)
        end

        def add_idata_ui(name, data, ref=nil)
          add_idata(name, 'I', data, ref)
        end

        def add_idata_f(name, data, ref=nil)
          add_idata(name, 'f', data, ref)
        end

        def add_idata_d(name, data, ref=nil)
          add_idata(name, 'd', data, ref)
        end

        def add_idata_s(name, data, ref=nil)
          add_idata(name, 'a', data, ref)
        end

        # Sum the values of all positive indexes
        def sum_indexes( indexes=nil )
          if not indexes
            indexes = @indexes.map{ |x| x.name }
          end
          sum = 0
          indexes.each do |name| 
            idx = index(name)
            sum += ((idx.is_set?) ? idx.value : 0)
          end
          return sum
        end

        # Count the number of indexes that are positive
        def count_indexes( indexes=nil )
          if not indexes
            indexes = @indexes.map{ |x| x.name }
          end
          sum = 0
          indexes.each do |idx| 
            sum += ((index(idx).is_set?) ? 1 : 0)
          end
          return sum
        end

        # Return list of true/false values determining whether each index is set
        def indexes_to_bool( indexes=nil )
          if not indexes
            indexes = @indexes.map{ |x| x.name }
          end
          indexes.map { |idx| index(idx).is_set? }
        end

        def to_h
          { :source => @source, :name => @name, :sym => @sym, 
            :indexes => indexes.map { |idx| idx.to_h },
            :intdata => idata.map { |idata| idata.to_h } 
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          indexes = (h[:indexes] || []).map { |idx| Index.from_h(idx) }
          idata = (h[:intdata] || []).map { |idata| IntData.from_h(idata) }
          self.new( h[:source].to_s, h[:name].to_s, h[:sym].to_s,
                    indexes, idata )
        end

        def to_s
          "#{@source} #{@name} (#{@sym})"
        end

        def inspect
          str = "\t#{self.to_s}\n\tIndexes:\n"
          @indexes.each { |i| str << "\t\t" << i.inspect() << "\n" }
          str << "\tIntermediate Data:\n"
          @idata.each { |i| str << "\t\t" << i.inspect() << "\n" }
          str << "\n"
        end

      end

=begin rdoc
SAR (Signal Analysis Results) object. Originally the in-memory representation
of a SAR file, this represents the output of the feature detection (AKA
"index generation") stage of the analysis.

A Sar consists of components called analyses (sometimes referred to in
shorthand as "ops"). Each analysis is named after, and therefore associated
with, a data source, such as "Auto Power Spectrum V5" or "Cross Correlation
(V5,II)". An Analysis object contains collections of Index and IntData
objects. Each Index is a "feature" and should generally (but not always, due to
legacy design decisions) be a value between 0 (false) and 1 (true). An
IntData object is used to store arbitrary, non-index data.

Note that Analysis objects are stored in an Array, not a Hash.
=end
      class Sar
        attr_accessor :analyses
        attr_reader :timestamp

        def initialize( timestamp=Time.now.to_i(), ops=[] )
          @analyses = ops
          @timestamp = timestamp
        end

        def analysis( name, source=nil )
          a = @analyses.select { |x| 
                x.name == name and (! source or x.source==source)
              }.first
          if not a
            $stderr.puts "SAR Analysis %s %s not found" % [ name, 
                                                         source ? source : '' ]
          end

          return a
        end

        def analysis_sym( sym, source=nil )
          a = @analyses.select { |x| 
                x.sym == sym and (! source or x.source==source)
              }.first
          if not a
            $stderr.puts "SAR Analysis %s %s not found" % [ sym, 
                                                         source ? source : '' ]
          end

          return a
        end


        def get_or_create_analysis(name, sym, source)
          a = @analyses.select { |x| 
                x.name == name and (! source or x.source==source)
              }.first
          if ! a
            a = Analysis.new( source, name, sym )
            @analyses << a
          end

          a
        end

        # Return name of the lead pair for this SAR
        def lead_pair_name
          name = @analyses.detect{ |a| a.source =~ /\([^,]+,[^)]+\)/ }.source
          name = '' if not name
          return name
        end

        # Return name of the primary lead in the lead pair for this SAR
        def primary_lead_name
          (lead_pair_name =~ /\(([^,]+),[^)]+\)/) ? $1 : ''
        end

        # Return name of the secondary lead in the lead pair for this SAR
        def secondary_lead_name
          (lead_pair_name =~ /\([^,]+,([^)]+)\)/) ? $1 : ''
        end

        def to_h
          { :timestamp => @timestamp, 
            :analyses => @analyses.map { |op| op.to_h } }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          ops = (h[:analyses] || []).map { |op| Analysis.from_h(op) }
          self.new( h[:timestamp], ops )
        end

        # ASCII representation of SAR contents
        def to_s
          "SAR (Signal Analysis Results) from %s\n" % Time.at(@timestamp).to_s
        end

        def inspect
          str = self.to_s

          str << "-------------------------------------------------------\n"
          str << "Analyses:\n"
          @analyses.each do |a|
            str << a.inspect
          end

          return str
        end

      end

    end
  end
end

if __FILE__ == $0 
  s = Mpa::SignalAnalysis::Sar::Sar.new()

  v5_aps = Mpa::SignalAnalysis::Sar::Analysis.new( 'V5', 'auto power', 'aps' )
  v5_amp = Mpa::SignalAnalysis::Sar::Analysis.new( 'V5', 'amplitude', 'amp' )
  s.analyses << v5_aps << v5_amp

  ii_aps = Mpa::SignalAnalysis::Sar::Analysis.new( 'II', 'auto power', 'aps' )
  ii_amp = Mpa::SignalAnalysis::Sar::Analysis.new( 'II', 'amp', 'amp' )
  s.analyses << ii_aps << ii_amp

  ccr = Mpa::SignalAnalysis::Sar::Analysis.new( '(V5,II)', 'cross correl','ccr')
  pas = Mpa::SignalAnalysis::Sar::Analysis.new( '(V5,II)', 'phase angle','pas')
  imr = Mpa::SignalAnalysis::Sar::Analysis.new( '(V5,II)', 'impulse resp','imr')
  xar = Mpa::SignalAnalysis::Sar::Analysis.new( '(V5,II)', 'transfer fn','xar')
  coh = Mpa::SignalAnalysis::Sar::Analysis.new( '(V5,II)', 'coherence', 'coh' )
  s.analyses << ccr << pas << imr << xar << coh

  v5_aps.indexes << Mpa::SignalAnalysis::Sar::Index.new('omega', 'O')
  ii_aps.indexes << Mpa::SignalAnalysis::Sar::Index.new('omega', 'O')
  v5_amp.indexes << Mpa::SignalAnalysis::Sar::Index.new('hyper', 'V+')
  ii_amp.indexes << Mpa::SignalAnalysis::Sar::Index.new('hyper', '2+')

  ccr.indexes << Mpa::SignalAnalysis::Sar::Index.new('p idx', 'P', 1.0)
  pas.indexes << Mpa::SignalAnalysis::Sar::Index.new('q idx', 'Q')
  pas.idata << Mpa::SignalAnalysis::Sar::IntData.new( 'Z', 'S', 
            Mpa::SignalAnalysis::Sar::Ref.new( 'Misc', 'score', 'z point'),
                                                        [76] )
  imr.indexes << Mpa::SignalAnalysis::Sar::Index.new('r idx', 'R')
  imr.idata << Mpa::SignalAnalysis::Sar::IntData.new( 'X', 'f', 
            Mpa::SignalAnalysis::Sar::Ref.new( 'DSP', 'x axis', 'x axis peaks'),
                                                        [1.0,2.5,3.5] )
  xar.indexes << Mpa::SignalAnalysis::Sar::Index.new('t idx', 'T', 1.0)
  coh.indexes << Mpa::SignalAnalysis::Sar::Index.new('quarter 1', 'Q1')

  puts s
end
