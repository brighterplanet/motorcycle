Feature: Motorcycle Committee Calculations
  The motorcycle model should generate correct committee calculations

  Background:
    Given a motorcycle

  Scenario Outline: Retirement committee
    Given a characteristic "timeframe" of "2010-01-01/2011-01-01"
    And a characteristic "acquisition" of "<acquisition>"
    When the "retirement" committee reports
    Then the committee should have used quorum "from timeframe"
    And the conclusion of the committee should be "<retirement>"
    Examples:
      | acquisition | retirement | notes |
      |             | 2011-01-01 | unknown acq use last day of timeframe |
      | 2009-01-01  | 2011-01-01 | acq before timeframe use last day of timeframe |
      | 2010-07-01  | 2011-01-01 | acq during timeframe use last day of timeframe |
      | 2012-01-01  | 2012-01-01 | acq after timeframe use acq |

  Scenario Outline: Acquisition committee
    Given a characteristic "timeframe" of "2010-01-01/2011-01-01"
    And a characteristic "retirement" of "<retirement>"
    When the "acquisition" committee reports
    Then the committee should have used quorum "<quorum>"
    And the conclusion of the committee should be "<acquisition>"
    Examples:
      | retirement | acquisition | quorum         | notes |
      | 2009-01-01 | 2009-01-01  | from timeframe | retired before timeframe use retirement |
      | 2010-07-01 | 2010-01-01  | from timeframe | retired during timeframe use first day of timeframe |
      | 2012-01-01 | 2010-01-01  | from timeframe | retired after timeframe first day of timeframe |

  Scenario Outline: Active subtimeframe committee
    Given a characteristic "acquisition" of "<acquisition>"
    And a characteristic "retirement" of "<retirement>"
    And a characteristic "timeframe" of "2010-01-01/2011-01-01"
    When the "active_subtimeframe" committee reports
    Then the committee should have used quorum "from acquisition and retirement"
    And the conclusion of the committee should be timeframe "<active_subtimeframe>"
    Examples:
      | acquisition | retirement | active_subtimeframe   | notes |
      | 2009-04-21  | 2009-09-01 | 2010-01-01/2010-01-01 | both before -> 0 days |
      | 2009-04-21  | 2010-09-01 | 2010-01-01/2010-09-01 | acq before retire during -> start of timeframe to retire |
      | 2010-04-21  | 2010-09-01 | 2010-04-21/2010-09-01 | both during -> acq to retire |
      | 2010-04-21  | 2011-09-01 | 2010-04-21/2011-01-01 | acq during retire after -> acq to end of timeframe |
      | 2011-04-21  | 2011-09-01 | 2010-01-01/2010-01-01 | both after -> 0 days |
      | 2009-04-21  | 2011-09-01 | 2010-01-01/2011-01-01 | acq before retire after -> timeframe |
      | 2010-09-01  | 2010-04-21 | 2010-04-21/2010-04-21 | acq after retire -> 0 days |

  Scenario Outline: Annual distance committee
    Given a characteristic "annual_distance_estimate" of "<annual>"
    And a characteristic "weekly_distance_estimate" of "<weekly>"
    And a characteristic "timeframe" of "2010-01-01/2011-01-01"
    When the "annual_distance" committee reports
    Then the committee should have used quorum "<quorum>"
    And the conclusion of the committee should be "<distance>"
    Examples:
      | annual | weekly | distance    | quorum                        |
      | 10000  | 189    | 10000       | from annual distance estimate |
      |        | 189    |  9855       | from weekly distance estimate |
      |        |        |  2595.87187 | default                       |

  Scenario: Fuel committee
    When the "fuel" committee reports
    Then the committee should have used quorum "default"
    And the conclusion of the committee should have "name" of "regular gasoline"

  Scenario: Fuel efficiency committee
    When the "fuel_efficiency" committee reports
    Then the committee should have used quorum "default"
    And the conclusion of the committee should be "25.97628"

  Scenario Outline: Distance committee
    Given a characteristic "annual_distance" of "10000"
    And a characteristic "active_subtimeframe" of "<active_subtimeframe>"
    And a characteristic "timeframe" of "2010-01-01/2011-01-01"
    When the "distance" committee reports
    Then the committee should have used quorum "from annual distance, active subtimeframe, and timeframe"
    And the conclusion of the committee should be "<distance>"
    Examples:
      | active_subtimeframe   | distance  | notes |
      | 2010-01-01/2011-01-01 | 10000.0   | active same as timeframe -> 100% |
      | 2010-01-01/2010-02-01 | 849.31507 | active within timeframe -> portion of timeframe |
      | 2010-01-01/2010-01-01 |     0.0   | active 0 days -> 0% |

  Scenario: Fuel use committee
    Given a characteristic "distance" of "10000"
    And a characteristic "fuel_efficiency" of "10"
    When the "fuel" committee reports
    And the "fuel_use" committee reports
    Then the committee should have used quorum "from distance, fuel efficiency, and fuel"
    And the conclusion of the committee should be "1000"

  Scenario: Energy committee
    Given a characteristic "fuel_use" of "1000"
    When the "fuel" committee reports
    And the "energy" committee reports
    Then the committee should have used quorum "from fuel use and fuel"
    And the conclusion of the committee should be "35000"

  Scenario: CO2 emission factor committee
    When the "fuel" committee reports
    And the "co2_emission_factor" committee reports
    Then the committee should have used quorum "from fuel"
    And the conclusion of the committee should be "2.3"

  Scenario: Carbon committee
    Given a characteristic "fuel_use" of "1000"
    And a characteristic "co2_emission_factor" of "2.3"
    When the "carbon" committee reports
    Then the committee should have used quorum "from fuel use and co2 emission factor"
    Then the conclusion of the committee should be "2300"
