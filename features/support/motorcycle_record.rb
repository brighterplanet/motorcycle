require 'motorcycle'

class MotorcycleRecord < ActiveRecord::Base
  include BrighterPlanet::Emitter
  include BrighterPlanet::Motorcycle
end
