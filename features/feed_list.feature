Feature: Show list of feeds
  As a user
  I need to see a list of available feeds on the site

  Scenario: Showing feeds
    Given I have the feeds
      | Name         |
      | A Cool Feed  |
      | Another Feed |
    And I am on the feeds list page
    Then I should see "A Cool Feed"
    And I should see "Another Feed"
