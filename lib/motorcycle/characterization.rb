module BrighterPlanet
  module Motorcycle
    module Characterization
      def self.included(base)
        base.characterize do
          has :fuel_efficiency, :measures => Measurement::BigLengthPerVolume
          has :annual_distance_estimate, :measures => Measurement::BigLength
          has :weekly_distance_estimate, :measures => Measurement::BigLength
          has :acquisition
          has :retirement
        end
      end
    end
  end
end
