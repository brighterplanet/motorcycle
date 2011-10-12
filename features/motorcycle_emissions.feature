Feature: Motorcycle Emissions Calculations
  The motorcycle model should generate correct emission calculations

  Background:
    Given a motorcycle

  Scenario Outline: Standard Calculations for motorcycle
    Given it has "annual_distance_estimate" of "<distance>"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" kgs of "<emission>"
    Examples:
      | distance | emission |
      |     1019 |     97.2 |
