Feature: Export CSV
  As a registered user
  I want to be able to save the results of my search
  so that I can manipulate them or view them later.

  Background:
    Given I'm logged in as a user
    Given I'm on search page
    Given There are 3 papers in DB$

@javascript
  Scenario: User can export the result of search
    When I type specific keywords and click search button
    Then I should get specific results
    Then I can click 'Export'
    Then I should get a response with content-type "text/csv"