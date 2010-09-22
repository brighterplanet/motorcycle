module BrighterPlanet
  module Motorcycle
    module Summarization
      def self.included(base)
        base.summarize do |has|
          has.identity
          has.verb :own
        end
      end
    end
  end
end
