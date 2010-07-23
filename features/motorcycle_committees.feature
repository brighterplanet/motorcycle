Feature: Motorcycle Committee Calculations
  The motorcycle model should generate correct committee calculations

  Scenario Outline: Fuel consumption committee
    Given a motorcycle has "annual_distance_estimate" of "<distance>"
    When emissions are calculated
    Then the fuel_consumed committee should be close to <fuel_consumption>, +/-1
    Examples:
      | distance | fuel_consumption |
      |     1001 |               38 |
