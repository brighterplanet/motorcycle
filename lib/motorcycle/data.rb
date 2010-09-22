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
          
          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
