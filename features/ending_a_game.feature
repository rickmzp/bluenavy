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
