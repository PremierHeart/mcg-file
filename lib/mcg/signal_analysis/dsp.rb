#!/usr/bin/env ruby
# :title: Mpa::SignalAnalysis::Dsp
=begin rdoc
=Dsp Library
<i>(c) Copyright 2017 Premier Heart, LLC</i>

DSP is an in-memory representation of the output of DSP operations
applied to a pair of signals. It consists of two sets of signal-specific
operations, and one set of signal-pair operations.

Note that the DSP data structure only contains the output from the
processing; all subsequent analysis generates SAR (Signal Analysis Results)
data.
=end

module Mpa
  
  module SignalAnalysis

    module Dsp

=begin rdoc
    DSP operation
=end
      # FIXME: This needs a data-type method of some sort. We are no longer
      #        limited to 1-D arrays of 16-bit values.
      class Op
        attr_reader :source, :src_type, :name, :sym
        attr_reader :label, :domain, :x_axis, :y_axis
        attr_accessor :data
        SOURCE_UNK = 'Unknown'
        SOURCE_SIG = 'Signal'
        SOURCE_PAIR = 'SigPair'
        SOURCE_OP = 'DspOp'
        SOURCE_TYPES = [ SOURCE_UNK, SOURCE_SIG, SOURCE_PAIR, SOURCE_OP ]

        def initialize( source, src_type, name, sym, label, domain, 
                        x_label, y_label, data=[] )
          @source = source
          @src_type = src_type
          raise 'Invalid source type' if not SOURCE_TYPES.include? src_type
          @name = name
          @sym = sym
          @label = label
          @domain = domain
          @x_axis = x_label
          @y_axis = y_label
          @data = data
        end

        def binary_src_type
          SOURCE_TYPES.index(@src_type)
        end

=begin rdoc
Return the complete name (name + source) for the operation. This is used to
disambiguate operations for multiple leads. If skip_pair is true, then
operations for lead pairs will not include the source component. The name and 
source components are separated by ' ' unless the user provides sep.
=end
        def fullname(sep=' ', skip_pair=false)
          (skip_pair and @source.start_with? '(') ? @name : 
                                                    "#{@name}#{sep}#{@source}"
        end

=begin rdoc
See fullname. This uses sym instead of name (e.g. for graph labels).
=end
        def fullsym(sep=' ', skip_pair=false)
          (skip_pair and @source.start_with? '(') ? @sym : 
                                                    "#{@sym}#{sep}#{@source}"
        end



        def to_s
          "%s %s %s (%s)" % [ @src_type, @source, @name, @sym ]
        end

        def to_h
          { :source => @source, :src_type => @src_type, :name => @name,
            :sym => @sym, :label => @label, :domain => @domain,
            :x_axis => @x_axis, :y_axis => @y_axis, :data => @data
          }
        end

        def self.from_h(hash)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( h[:source], h[:src_type], h[:name], h[:sym], h[:label],
                    h[:domain], h[:x_label], h[:y_label], h[:data] )
        end

        def inspect
          str = self.to_s
          str << "\nLabel: %s (%s)\n" % [ @label, @domain ]
          str << "X Axis Label: #{@x_axis}\n"
          str << "Y Axis Label: #{@y_axis}\n"
          str << "X Axis Label: #{@x_axis}\n"
          str << "Data: " << @data.to_s << "\n"
          return str
        end

      end

=begin rdoc
    DSP
=end
      class Dsp
        attr_accessor :operations
        attr_reader :timestamp

        def initialize( timestamp=Time.now.to_i(), ops=[] )
          @timestamp = timestamp
          @operations = ops
        end

        def operation( name, source=nil )
          @operations.collect { |x| (x.name == name && 
                      (!source || x.source==source)) ? x : nil }.compact.at(0)
        end

        def operation_sym( sym, source=nil )
          @operations.collect { |x| (x.sym == sym && 
                      (!source || x.source==source)) ? x : nil }.compact.at(0)
        end

=begin rdoc
Find Operation by fullname, fullsym, name, or sym. Returns all possible results.
=end
        def find(str, sep=' ')
          fn_results = []
          fs_results = []
          n_results = []
          s_results = []
          @operations.each do |op|
            if op.fullname(sep) == str
              fn_results << op
            elsif op.fullsym(sep) == str
              fs_results << op
            elsif op.name == str
              n_results << op
            elsif op.sym == str
              s_results << op
            end
          end

          fn_results + fs_results + n_results + s_results
        end

        def sources()
          @operations.inject([]){ |a,op| a << op.source }.sort
        end

        def signals()
          @operations.collect() { |op| op.src_type == Op::SOURCE_SIG ? 
                                         op.source : nil }.compact.uniq
        end

        def to_s
          "DSP data from #{Time.at(@timestamp).to_s}"
        end

        def to_h
          { :timestamp => @timestamp,
            :operations => @operations.collect { |op| op.to_h }
          }
        end

        def self.from_h(hash)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          ops = (h[:operations] || []).map { |o| Op.from_h(o) }
          self.new( h[:timestamp], ops )
        end

        def inspect
          str = self.to_s
          str << "\n-------------------------------------------------------\n"

          str << "Operations:\n"
          @operations.each do |o|
            str << o.to_s() << "\n"
          end
          return str
        end
      end

    end
  end
end

if __FILE__ == $0 
  d = Mpa::SignalAnalysis::Dsp::Dsp.new

  d.operations << Mpa::SignalAnalysis::Dsp::Op.new( 'V5', 'Signal',
                        'auto power', 'aps', 'power peaks', 'frequency',
                        'frequency in Hz', 'power in watts', [0,0,0,0,0] )
  d.operations << Mpa::SignalAnalysis::Dsp::Op.new( 'II', 'Signal',
                        'auto power', 'aps', 'power peaks', 'frequency',
                        'frequency in Hz', 'power in watts', [0,1,9,0,0] )
  d.operations << Mpa::SignalAnalysis::Dsp::Op.new( '(V5,II)', 'SigPair',
                        'cross power', 'cps', 'power peaks', 'frequency',
                        'frequency in Hz', 'power in watts', [0,1,2,0,0] )
  d.operations << Mpa::SignalAnalysis::Dsp::Op.new( '(V5,II)', 'SigPair',
                        'phase angle', 'psa', 'sync', 'transfer',
                        'frequency in Hz', 'phase shift in deg', [2,0,0] )
  puts d
end
