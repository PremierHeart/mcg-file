#!/usr/bin/env ruby
# :title: Mpa::SignalAnalysis::SignalSample
=begin rdoc
=SignalSample Library
<i>(c) Copyright 2017 Premier Heart, LLC</i>

SignalSample is an in-memory representation of data acquired from a
signal. It may contain one or more leads, each of which consists of a
one or more fixed-size blocks.
=end

=begin rdoc
MPA product
=end
module Mpa

=begin rdoc
MPA Signal Analysis Framework
=end
  module SignalAnalysis

    module Sample

=begin rdoc
+Signal+ is a source of data: it has a name, an element size, a block size,
and a gain (i.e. a data multiplier). The default signals for 2-lead ECG
analysis are lead *II* and the *V5* lead.

Note that +Signal+ is a _descriptor_ object: it exists only to provide
information about a source of data. All data which has been sampled from
a signal is stored in a +SignalSample+ object.
=end
      class Signal
        attr_reader :name, :elem_size, :block_size, :gain

        def initialize( name, elem_size, block_size, gain )
          @name = name
          @elem_size = elem_size
          @block_size = block_size
          @gain = gain
        end

        def to_s
          "Signal '#{@name}'"
        end

        def to_h
          { :name => @name,
            :elem_size => @elem_size,
            :block_size => @block_size,
            :gain => @gain
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( h[:name], h[:elem_size], h[:block_size], h[:gain] )
        end

        def inspect
          self.to_s + 
               ": 1 block = #{@block_size} x #{@elem_size} bytes, gain #{@gain}"
        end

      end

=begin rdoc
A +SignalSample+ is a recording or _sample_ of data from a +Signal+.
=end
      class SignalSample
        attr_reader :signal, :num_blocks, :checksum, :timestamp, :data

        def initialize( signal, data=nil, ts=nil )
          @signal = signal
          clear
          append(data) if data
          @timestamp = ts if ts
        end

        def clear
          @data = []
          @num_blocks = 0
          @checksum = 0
          @timestamp = 0
        end

        def append( data )
          @data += data
          @num_blocks = @data.length / @signal.block_size
          # TODO: calculate checksum
          @timestamp = Time::now()
        end

        def length
          @data.length
        end

        def [](elem)
          @data[elem]
        end

        def <<(stuff)
          (stuff.kind_of? Array) ? stuff.each {|x| @data << x} : @data << stuff
        end

        def each(&block)
          @data.each { |i| yield i }
        end

        def to_s
          "Sample from #{@signal}"
        end

        def to_h
          { :signal => @signal.to_h, 
            :num_blocks => @num_blocks, 
            :checksum => @checksum, 
            :timestamp => @timestamp, 
            :data => @data
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( Signal.from_h(h[:signal]), h[:data], h[:timestamp] )
        end

        def inspect
          self.to_s + "\nData (#{@num_blocks} blocks = #{length} bytes):\n" +
                      @data.inspect
        end
      end

=begin rdoc
A +SignalPair+ is a pair of +Signal+ objects: a dominant signal ('a') and a
subordinate signal ('b') with a ratio of the signals a to b.
=end
      class SignalPair
        attr_reader :signals, :ratio

        def initialize( lead_a, lead_b, ratio )
          @signals = { 'a' => lead_a, 'b' => lead_b }
          @ratio = ratio
        end

        def name
          "(#{@signals['a'].name},#{@signals['b'].name})"
        end

        def to_s
          name
        end

        def to_h
          { :a => @signals['a'].to_h,
            :b => @signals['b'].to_h,
            :ratio => @ratio
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( Signal.from_h(h[:a]), Signal.from_h(h[:b]), h[:ratio] )
        end

        def inspect
          "Pair #{name}: Ratio #{@ratio}"; 
        end

      end

=begin rdoc
A complete sample of data from a device. A Sample object consists of a
collection of +SignalSample+ objects (the recorded data) and a collection 
of +SignalPair+ objects (signals to be paired for analysis).
=end
      class Sample
        attr_reader :signals, :pairs

        def initialize( config, samples=[] )
          @pairs = config.pairs.clone

          @signals = {}

          samples.each do |s|
            @signals[s.signal.name] = s
          end

          config.signals.each do |s|
            @signals[s.name] = SignalSample.new(s) if not @signals[s.name]
          end
        end

        def [](name)
          @signals[name]
        end

        def to_s
          ts = Time.at(@signals.first[1].timestamp).to_s
          "Data sample from #{ts}\n"
        end

        def to_h
          cfg = Config.new( @signals.values.collect { |s| s.signal }, 
                            @pairs )
          { :config => cfg.to_h, 
            :samples => @signals.values.collect { |s| s.to_h }
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          samps = (h[:samples] || []).map { |s| SignalSample.from_h(s) }
          self.new( Config.from_h(h[:config]), samps )
        end

        def inspect
          descr = self.to_s + "\n"
          @pairs.each { |p| descr += p.inspect + "\n" }
          @signals.each { |key, s| descr += s.inspect + "\n" }
          return descr
        end

      end

=begin rdoc
The configuration for a device. A +SampleConfig+ consists of a collection of
+Signal+ objects, to define the data sources, and a collection of
+SignalPair+ objects, to define pairs of signals for analysis. A 
+SignalConfig+ object is used to initialize a +Sample+ object.
=end
      class Config
        attr_reader :signals, :pairs

        def initialize( signals, pairs )
          @signals = signals.clone
          @pairs = pairs.clone
        end

        def to_s
          "Sample config of signals " + @signals.each { |s| s.name }.join(',')
        end

        def to_h
          { :signals => @signals.collect { |s| s.to_h },
            :pairs => @pairs.collect { |p| p.to_h }
          }
        end

        def self.from_h(hash)
          # convert string keys to symbols (JSON hack)
          h = (hash || {}).inject({}) { |h, (k,v)| h[k.to_sym] = v; h }
          self.new( (h[:signals] || []).map { |s| Signal.from_h(s) },
                    (h[:pairs] || []).map { |p| SignalPair.from_h(p) } )
        end

        def inspect
          descr = "SampleConfig:\n"
          @signals.each { |s| descr += s.inspect + "\n" }
          @pairs.each { |p| descr += p.inspect + "\n" }
          return descr
        end

      end

    end

  end

end


if __FILE__ == $0 then
  sig_v5 = Mpa::SignalAnalysis::Sample::Signal.new( "V5", 2, 512, 1.0 )
  sig_ii = Mpa::SignalAnalysis::Sample::Signal.new( "II", 2, 512, 1.0 )

  pair = Mpa::SignalAnalysis::Sample::SignalPair.new( sig_v5, sig_ii, 1.3 )
  if pair.signals['a'].name != sig_v5.name or
     pair.signals['b'].name != sig_ii.name or
     pair.ratio != 1.3  then

    puts "SignalPair Error"
    exit 1
  end

  cfg = Mpa::SignalAnalysis::Sample::Config.new( [sig_v5, sig_ii], [pair] )
  if cfg.signals[0].name != sig_v5.name or
     cfg.signals[1].name != sig_ii.name or
     cfg.pairs[0] != pair or
     cfg.signals.length != 2 or cfg.pairs.length != 1 then

    puts "SignalConfig error"
    exit 2
  end

  samp = Mpa::SignalAnalysis::Sample::Sample.new( cfg )
  if samp.signals['V5'].signal != cfg.signals[0] or
     samp.signals['II'].signal != cfg.signals[1] or
     samp.signals.length != cfg.signals.length or
     samp.pairs[0] != cfg.pairs[0] or
     samp.pairs.length != cfg.pairs.length then

    puts "Sample error"
    exit 3
  end

  data = [0, 1] * 1024
  samp.signals['V5'].append data
  samp.signals['II'].append data

  if samp.signals['V5'].length != samp.signals['II'].length or
     samp.signals['V5'].length != data.length then
    puts "SignalSample length error"
    exit 4
  end

  if samp.signals['V5'].num_blocks != samp.signals['II'].num_blocks or
     samp.signals['V5'].num_blocks != 4 then
    puts "SignalSample num blocks error"
    exit 5
  end

  if samp.signals['V5'].signal != sig_v5 or 
     samp.signals['II'].signal != sig_ii then
    puts "SignalSample signal error"
    exit 6
  end

  samp.signals['V5'].append data
  samp.signals['II'].append data

  if samp.signals['V5'].length != samp.signals['II'].length or
     samp.signals['V5'].length != (data.length * 2) then
    puts "SignalSample 2x length error"
    exit 7
  end

  if samp.signals['V5'].num_blocks != samp.signals['II'].num_blocks or
     samp.signals['V5'].num_blocks != 8 then
    puts "SignalSample 2x num blocks error"
    exit 8
  end

  samp.signals['V5'].clear
  samp.signals['II'].clear

  if samp.signals['V5'].length != samp.signals['II'].length or
     samp.signals['V5'].length > 0 then
    puts "SignalSample 0 length error"
    exit 9
  end

  if samp.signals['V5'].num_blocks != samp.signals['II'].num_blocks or
     samp.signals['V5'].num_blocks > 0 then
    puts "SignalSample 0 num blocks error"
    exit 10 
  end

end
