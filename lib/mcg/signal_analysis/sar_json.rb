#!/usr/bin/env ruby
# Serialization of SAR objects to JSON
# (c) Copyright 2017 Premier Heart, LLC

require "rubygems"
require 'json/ext'

require 'mpa/signal_analysis/sar'


module Mpa
  module SignalAnalysis
    module Sar

      class Sar
=begin rdoc
Convert Sar to JSON.
=end
        def json
          begin
            JSON.fast_generate(self)
          rescue Exception => e
            nil
          end
        end

=begin rdoc
JSON callback (invoked by JSON.generate).
Creates a Hash representing the JSON object.
=end
        def to_json(*a)
          {
            'json_class' => self.class.name,
            'data' => self.to_h
          }.to_json(*a)
        end

=begin rdoc
JSON callback (invoked by JSON.parse).
Creates an object from the JSON Hash.
=end
        def self.json_create(o)
          self.from_h(o['data'].inject({}) { |h,(k,v)| h[k.to_sym] = v; h })
        end

=begin rdoc
Create a Sar object from a JSON string.
=end
        def self.from_json(str)
          begin
            JSON.parse(str)
          rescue Exception => e
            nil
          end
        end
      end

    end
  end
end
