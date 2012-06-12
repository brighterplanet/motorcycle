Feature: Motorcycle Emissions Calculations
  The motorcycle model should generate correct emission calculations

  Background:
    Given a motorcycle

  Scenario Outline: Standard Calculations for motorcycle
    Given it has "annual_distance_estimate" of "<ann_dist>"
    And it has "weekly_distance_estimate" of "<weekly_dist>"
    And it has "fuel_efficiency" of "<fe>"
    And it is the year "2010"
    When impacts are calculated
    Then the amount of "energy" should be within "0.1" of "<energy>"
    Then the amount of "carbon" should be within "0.1" of "<carbon>"
    Examples:
      | ann_dist | weekly_dist | fe | energy   | carbon |
      |          |             |    |  3497.63 | 229.84 |
      | 10000    | 189         |    | 13473.83 | 885.42 |
      |          | 189         |    | 13278.46 | 872.58 |
      | 10000    |             | 25 | 14000.0  | 920.0  |
