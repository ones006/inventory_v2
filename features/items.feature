@items
Feature: Items management
    In order to manage items
    As an admin
    I want to create and manage items

    Background: 
        Given user "admin" is signed in on "monsterinc"

    Scenario: admin create new item
        Given I have no items
        And I am on the items page
        When I follow "Create New Item"
        And I fill in "code" with "Item#1"
        And I fill in "name" with "Item 1"
        And I press "Save Item"
        Then I should be redirected
        And I should see "Item#1"
        And I should see "Item 1"
        And "Item#1" should belongs to company "monsterinc"
        And I should have 1 item

    Scenario: admin create item without code
        Given I have no items
        And I am on the items page
        When I follow "Create New Item"
        And I fill in "name" with "Item 1"
        And I press "Save Item"
        Then I should see "code can't be blank"
        And I should have 0 item

    Scenario: admin create item without name
        Given I have no items
        And I am on the items page
        When I follow "Create New Item"
        And I fill in "code" with "Item#1"
        And I press "Save Item"
        Then I should see "name can't be blank"
        And I should have 0 item
