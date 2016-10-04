Feature: Share Search Results
        As a registered user 
        I want to be able to share the results of my search by email or facebook 
        so that I can inform collaborators

  Background:
    Given I'm logged in as a user 
    Given I'm on search page
    Given There are 3 papers in DB$ 

  @javascript
  Scenario: User can share search results by email
    When I type specific keywords and click search button
    Then I should get specific results
    Then I click 'Share Results' button
    Then I input the email address and click 'Share' button
    Then The search results should be shared by email
    
