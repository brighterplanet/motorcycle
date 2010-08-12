require 'emitter'

module BrighterPlanet
  module Motorcycle
    extend BrighterPlanet::Emitter
    
    def self.motorcycle_model
      if Object.const_defined? 'Motorcycle'
        ::Motorcycle
      elsif Object.const_defined? 'MotorcycleRecord'
        MotorcycleRecord
      else
        raise 'There is no motorcycle model'
      end
    end
  end
end
