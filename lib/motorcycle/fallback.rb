module BrighterPlanet
  module Motorcycle
    module Fallback
      def self.included(base)
        base.falls_back_on :fuel_efficiency => 61.1.miles_per_gallon.to(:kilometres_per_litre), # https://brighterplanet.sifterapp.com/projects/30/issues/818/comments
                           :annual_distance_estimate => 1613.miles.to(:kilometres) # https://brighterplanet.sifterapp.com/projects/30/issues/818/comments
      end
    end
  end
end
