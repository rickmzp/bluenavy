Feature: Starting a game

  Scenario: Player creates a game
    When I create a game
    Then I start waiting for an opponent to join

  Scenario: Player joins a game
    Given a player has created a game
    When I join the game
    Then the game begins
    And the enemy gets to attack first
