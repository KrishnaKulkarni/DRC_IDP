@javascript
Feature: Managing IDP Trajectories
  In order to manage registrations of IDP trajectories 
  As a surveyor-user
  I want to be able to cancel trajectory forms and delete trajectory records

  Background:
    Given I have a user with username "Andrew"
    And I sign in as "Andrew" on "Computer 1" at location "Training"
    And I complete and submit an example identity registration 
    And I click on the link "Proceed to Long Form"

  Scenario: Cancelling a trajectory form
    Given I complete an example trajectory registration for stop 0
    When I click the link "Cancel"
    Then I should on the Successful Registration page
    And there should be a notice saying "Successfully registered John Doe"
    When I click the link "Proceed to Long Form"
    And I complete and submit an example trajectory registration for stop 0
    And I click on the link "Register Another Trajectory"
    And I complete an example trajectory registration for stop 1
    When I click the link "Cancel"
    Then I should on the Successfully Registered page
    And there should be a notice saying "Successfully registered John Doe"

  Scenario: Deleting trajectory records
    Given I complete and submit an example trajectory registration for stop 0
    And I click on the link "Register Another Trajectory"
    And I click on the link "Stop 0"
    When I click the button "Delete"
    Then I should be on the Trajectory Registration Page
    And there should be a notice saying "Stop 0 Trajectory Deleted"
    And the input "Stop Number" should be set to the value "0"
