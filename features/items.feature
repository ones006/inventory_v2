@items
Feature: Items management
    In order to manage items
    As an admin
    I want to create and manage items

    Background:
        Given user "admin" is signed in on "monsterinc"
        And category "Cat 1" exists
        And I have no items
        And I am on the items page

    Scenario Outline: create item with missing attribute 
        When I follow "Create New Item"
        And I fill in "code" with "<code>"
        And I fill in "name" with "<name>"
        And I fill in "category code" with "<category>"
        And I press "Save Item"
        Then I should see "<action>"
        And I should have 0 item

    Examples:
        | code   | name   | category | action                  |
        |        | Item 1 | Cat 1    | code can't be blank     |
        | Item#1 |        | Cat 1    | name can't be blank     |
        | Item#1 | Item 1 |          | category can't be blank |

    Scenario: admin create item that already exists
        Given item "Item#1" exists & belongs to company "monsterinc"
        When I follow "Create New Item"
        And I fill in "code" with "Item#1"
        And I fill in "name" with "Item 1"
        And I fill in "category code" with "Cat 1"
        And I press "Save Item"
        Then I should see "code has already been taken"
        And I should have 1 item

    Scenario: admin create new item
        When I follow "Create New Item"
        And I fill in "code" with "Item#1"
        And I fill in "item_name" with "Item 1"
        And I fill in "category code" with "Cat 1"
        And I press "Save Item"
        Then I should see "Item#1"
        And I should see "Item 1"
        And I should see "Cat 1"
        And "Item#1" should belongs to company "monsterinc"
        And I should have 1 item

