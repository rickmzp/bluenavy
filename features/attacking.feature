Feature: Attacking

  Scenario: Player launches an attack against the enemy
    Given it is my turn to attack
    When I fire a missile at a grid point
    Then a missle explodes at that grid point
    And I receive a report on the attack's result
    And it is the enemy's turn to attack

  Scenario: Player is hit by the enemy's attack
    Given it is the enemy's turn to attack
    When the enemy fires a missile at a grid point occupied by my navy
    Then I receive a report of their attack's success
    And it is my turn to attack

  Scenario: Player is missed by the enemy's attack
    Given it is the enemy's turn to attack
    When the enemy fires a missile at an empty grid point
    Then I receive a report of their attack's failure
    And it is my turn to attack
