require 'summary_judgement'

module BrighterPlanet
  module Motorcycle
    module Summarization
      def self.included(base)
        base.extend SummaryJudgement
        base.summarize do |has|
          has.identity
          has.verb :own
        end
      end
    end
  end
end
