module BrighterPlanet
  module Motorcycle
    module Data
      def self.included(base)
        base.col :fuel_efficiency, :type => :float
        base.col :annual_distance_estimate, :type => :float
        base.col :weekly_distance_estimate, :type => :float
        base.col :acquisition, :type => :date
        base.col :retirement, :type => :date
      end
    end
  end
end