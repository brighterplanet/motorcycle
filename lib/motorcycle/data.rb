require 'data_miner'

module BrighterPlanet
  module Motorcycle
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            string   'name'
            date     'date' # ?
            float    'fuel_efficiency'
            float    'annual_distance_estimate'
            float    'weekly_distance_estimate'
            date     'acquisition'
            date     'retirement'
          end
        end
      end
    end
  end
end
