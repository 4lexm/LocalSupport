Feature:  Tool tip instructions for fields on edit form
  As a charity owner
  So that I can fill out the edit form correctly
  I want to be able to have detailed tool tip instructions for edit form

  Tracker story ID: https://www.pivotaltracker.com/story/show/55198634

  Background:
    Given the following organizations exist:
      | name                            | description                      | address        | postcode | website       |
      | Harrow Bereavement Counselling  | Harrow Bereavement Counselling   | 34 pinner road | HA1 4HZ  | http://a.com/ |

    Given the following users are registered:
      | email                         | password | organization                    | confirmed_at |
      | registered_user-3@example.com | pppppppp | Harrow Bereavement Counselling  | 2007-01-01  10:00:00 |
    And cookies are approved

  Scenario: Display tooltip for each label on the edit form
    Given I am signed in as a charity worker related to "Harrow Bereavement Counselling"
    And I am on the edit charity page for "Harrow Bereavement Counselling"
    #Then I should see "Name" < tagged > with "first tooltip"
    Then the "Name" label should display "Enter a unique name" as a tooltip
    Then the following tooltips should exist: 
      | label                                                |  tooltip        |
      | Name                                                 |  Enter a unique name |
      | Address                                              |  Enter a complete address  |
      | Postcode                                             |  Make sure post code is accurate  |
      | Email                                                |  Make sure email is correct  |
      | Description                                          |  Enter a full description here. When an individual searching this database all words in this description will be searched. |
      | Website                                              |  Make sure url is correct  |
      | Telephone                                            |  Make sure phone number is correct  |
      | Add an additional organisation administrator email   |  Please enter the details of individuals from your organisation you would like to give permission to update your entry. E-mail addresses entered here will not be made public.  |
      | Donation                                             |  Please enter a website here either to the fundraising page on your website or to an online donation site.  |
      | Publish email                                        |  To make your email address visible to the public check this box |
      | Publish address                                      |  To make your full address visible to the public check this box |
      | Publish phone                                        |  To make your telephone number visible to the public check this box |

