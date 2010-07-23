module BrighterPlanet
  module Motorcycle
    extend self

    def included(base)
      require 'cohort_scope'
      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'

      require 'motorcycle/carbon_model'
      require 'motorcycle/characterization'
      require 'motorcycle/data'
      require 'motorcycle/summarization'

      base.send :include, BrighterPlanet::Motorcycle::CarbonModel
      base.send :include, BrighterPlanet::Motorcycle::Characterization
      base.send :include, BrighterPlanet::Motorcycle::Data
      base.send :include, BrighterPlanet::Motorcycle::Summarization
    end
    def motorcycle_model
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
