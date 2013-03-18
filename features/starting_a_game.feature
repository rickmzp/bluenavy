Feature: Starting a game

  Scenario: Player creates a game
    When I create a game
    Then I start waiting for an opponent to join

  Scenario: Player joins a game
    Given a player has created a game
    When I join the game
    Then the game begins

  Scenario: Player places their ships
    Given the game has begun
    When I deploy my navy
    And declare I am ready for war
    Then I get to attack first

  # TODO: very low-risk test, worth pushing down
  Scenario: The enemy placed thier ships before player
    Given the game has begun
    And the enemy has deployed their navy
    When I deploy my navy
    And declare I am ready for war
    Then the enemy gets to attack first
