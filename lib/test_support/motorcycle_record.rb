require 'motorcycle'

class MotorcycleRecord < ActiveRecord::Base
  include Sniff::Emitter
  include BrighterPlanet::Motorcycle
end
