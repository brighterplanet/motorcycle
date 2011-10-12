Feature: Motorcycle Committee Calculations
  The motorcycle model should generate correct committee calculations

  Scenario Outline: Fuel consumed committee
    Given a characteristic "distance" of "<distance>"
    And a characteristic "fuel_efficiency" of "<fuel_efficiency>"
    When the "fuel_consumed" committee reports
    Then the conclusion of the committee should be "<fuel_consumption>"
    Examples:
      | distance | fuel_efficiency | fuel_consumption |
      |     1001 |            22.1 |               45 |
