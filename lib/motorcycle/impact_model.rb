# Copyright © 2010 Brighter Planet.
# See LICENSE for details.
# Contact Brighter Planet for dual-license arrangements.

require 'earth/automobile/automobile_fuel'

module BrighterPlanet
  module Motorcycle
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          committee :carbon do # kg CO2
            quorum 'from fuel use and co2 emission factor', :needs => [:fuel_use, :co2_emission_factor] do |characteristics|
              characteristics[:fuel_use] * characteristics[:co2_emission_factor]
            end
          end
          
          committee :co2_emission_factor do # kg CO2 per various
            quorum 'from fuel', :needs => :fuel do |characteristics|
              characteristics[:fuel].co2_emission_factor
            end
          end
          
          committee :energy do # MJ
            quorum 'from fuel use and fuel', :needs => [:fuel_use, :fuel] do |characteristics|
              characteristics[:fuel_use] * characteristics[:fuel].energy_content
            end
          end
          
          committee :fuel_use do # various
            quorum 'from distance, fuel efficiency, and fuel', :needs => [:distance, :fuel_efficiency, :fuel] do |characteristics|
              if characteristics[:fuel].non_liquid?
                characteristics[:distance] / characteristics[:fuel_efficiency] * AutomobileFuel.find('gasoline').energy_content / characteristics[:fuel].energy_content
              else
                characteristics[:distance] / characteristics[:fuel_efficiency]
              end
            end
          end
          
          committee :distance do # km
            quorum 'from annual distance, active subtimeframe, and timeframe', :needs => [:annual_distance, :active_subtimeframe] do |characteristics, timeframe|
              characteristics[:annual_distance] * (characteristics[:active_subtimeframe] / timeframe.year)
            end
          end
          
          committee :fuel_efficiency do # km per litre
            quorum 'default' do
              base.fallback.fuel_efficiency
            end
          end
          
          committee :fuel do
            quorum 'default' do
              AutomobileFuel.find_by_code 'R'
            end
          end
          
          committee :annual_distance do # kilometres
            quorum 'from annual distance estimate', :needs => :annual_distance_estimate do |characteristics|
              characteristics[:annual_distance_estimate]
            end
            
            quorum 'from weekly distance estimate', :needs => :weekly_distance_estimate do |characteristics, timeframe|
              (characteristics[:weekly_distance_estimate] / 7 ) * timeframe.year.days
            end
            
            quorum 'default' do
              base.fallback.annual_distance_estimate
            end
          end
          
          committee :active_subtimeframe do
            quorum 'from acquisition and retirement', :needs => [:acquisition, :retirement] do |characteristics, timeframe|
              if characteristics[:acquisition].value <= characteristics[:retirement].value
                Timeframe.constrained_new characteristics[:acquisition].to_date, characteristics[:retirement].to_date, timeframe
              else
                Timeframe.constrained_new characteristics[:retirement].to_date, characteristics[:retirement].to_date, timeframe
              end
            end
          end
          
          committee :acquisition do
            quorum 'from timeframe', :appreciates => :retirement do |characteristics, timeframe|
              [ timeframe.from, characteristics[:retirement] ].compact.min
            end
          end
          
          committee :retirement do
            quorum 'from timeframe', :appreciates => :acquisition do |characteristics, timeframe|
              [ timeframe.to, characteristics[:acquisition] ].compact.max
            end
          end
        end
      end
    end
  end
end
