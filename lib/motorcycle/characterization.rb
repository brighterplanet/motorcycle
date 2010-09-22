module BrighterPlanet
  module Motorcycle
    module Characterization
      def self.included(base)
        base.characterize do
          has :fuel_efficiency, :measures => :length_per_volume
          has :annual_distance_estimate, :measures => :length, :trumps => :weekly_distance_estimate
          has :weekly_distance_estimate, :measures => :length, :trumps => :annual_distance_estimate
          has :acquisition
          has :retirement
        end
      end
    end
  end
end
