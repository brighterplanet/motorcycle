require 'characterizable'

module BrighterPlanet
  module Motorcycle
    module Characterization
      def self.included(base)
        base.send :include, Characterizable
        base.characterize do
          has :fuel_efficiency, :measures => :length_per_volume
          has :annual_distance_estimate, :measures => :length, :trumps => :weekly_distance_estimate
          has :weekly_distance_estimate, :measures => :length, :trumps => :annual_distance_estimate
          has :acquisition
          has :retirement
        end
        base.add_implicit_characteristics
      end
    end
  end
end
