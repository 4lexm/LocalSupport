Feature: Orphans UI
  As the site owner
  So that I look up orphan orgs and email prospective users
  I want a UI that shows me orphan orgs and allows me to generate user accounts for them

  Background:
    Given the following organizations exist:
      | name               | address        | email             |
      | The Organization   | 83 pinner road | no_owner@org.org  |
      | The Same Email Org | 84 pinner road | no_owner@org.org  |
      | Crazy Email Org    | 30 pinner road | sahjkgdsfsajnfds  |
      | My Organization    | 30 pinner road | admin@myorg.com   |
      | Yet Another Org    | 30 pinner road | admin@another.org |
    And the following users are registered:
      | email                 | password       | admin | confirmed_at        | organization    | pending_organization |
      | nonadmin@myorg.com    | mypassword1234 | false | 2008-01-01 00:00:00 |                 |                      |
      | admin@myorg.com       | adminpass0987  | true  | 2008-01-01 00:00:00 | My Organization |                      |
      | pending@myorg.com     | password123    | false | 2008-01-01 00:00:00 |                 | My Organization      |
      | invited-admin@org.org | password123    | false | 2008-01-01 00:00:00 |                 |                      |
    And cookies are approved
    And the admin made a preapproved user for "Yet Another Org"

  @javascript
  Scenario: Admin can generate link but only for unique email
    Given I am signed in as an admin
    And I visit the without users page
    And I check the box for "The Organization"
    And I check the box for "The Same Email Org"
    When I click id "generate_users"
    Then a token should be in the response field for "The Organization"
    Then I should see "Error: Email has already been taken" in the response field for "The Same Email Org"

  @javascript
  Scenario: Select All button toggles all checkboxes
    Given I am signed in as an admin
    And I visit the without users page
    And I press "Select All"
    Then all the checkboxes should be checked
    When I press "Select All"
    Then all the checkboxes should be unchecked

  @javascript
  Scenario: Admin should be notified when email is invalid
    Given I am signed in as an admin
    And I visit the without users page
    And I check the box for "Crazy Email Org"
    When I click id "generate_users"
    Then I should see "Error: Email is invalid" in the response field for "Crazy Email Org"

  Scenario: As a non-admin trying to access orphans index
    Given I am signed in as a non-admin
    And I visit the without users page
    Then I should be on the home page
    And I should see "You must be signed in as an admin to perform this action!"

  Scenario: Pre-approved user clicking through on email
    Given I click on the retrieve password link in the email to "admin@another.org"
    Then I should be on the password reset page
    And I fill in "user_password" with "12345678" within the main body
    And I fill in "user_password_confirmation" with "12345678" within the main body
    And I press "Change my password"
    Then I should be on the charity page for "Yet Another Org"

  @javascript
  Scenario: Table columns should be sortable
    Given I am signed in as an admin
    And I visit the without users page
    And I click tableheader "Name"
    Then I should see "Crazy Email Org" before "Yet Another Org"
    When I click tableheader "Name"
    Then I should see "Yet Another Org" before "Crazy Email Org"