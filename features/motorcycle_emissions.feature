Feature: Motorcycle Emissions Calculations
  The motorcycle model should generate correct emission calculations

  Scenario Outline: Standard Calculations for motorcycle
    Given a motorcycle has "annual_distance_estimate" of "<distance>"
    When emissions are calculated
    Then the emission value should be within "0.1" kgs of "<emission>"
    Examples:
      | distance | emission |
      |     1019 |     97.2 |
