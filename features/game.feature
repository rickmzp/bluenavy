Feature: Starting a game

  Scenario: Player creates a game
    When I create a game
    Then I start waiting for an opponent to join

  Scenario: Opponent joins game
    Given I have created a game
    When an opponent joins the game
    Then the game begins

  Scenario: Player places their ships
    Given the game has begun
    When I deploy my navy
    And declare I am ready for war
    Then I get to attack first

  Scenario: The enemy placed thier ships before player
    Given the game has begun
    And the enemy has deployed their navy
    When I deploy my navy
    And declare I am ready for war
    Then the enemy gets to attack first

Feature: Turns

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

Feature: Ending a game

  Scenario: Player wins game
    Given the enemy's navy is at their last stand
    And it is my turn to attack
    When I fire a missle at their last remaining offensive
    Then I am declared the winner

  Scenario: Player loses game
    Given my navy is at their last stand
    And it is the enemy's turn to attack
    When the enemy fires a missle at my last remaining offensive
    Then I am declared the loser
