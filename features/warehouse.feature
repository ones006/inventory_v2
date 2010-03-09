@warehouse
Feature: warehouse management
    In order to manage warehouses
    As an admin
    I want to create and manage warehouse

    Background:
        Given user "admin" is signed in on "monsterinc"
        And I have no warehouses
        And I am on the warehouse page

    Scenario Outline: create warehouse with various attributes missing
        When I follow "Create new warehouse"
        And I fill in "code" with "<code>"
        And I fill in "name" with "<name>"
        And I press "Save warehouse"
        Then I should see "<action>"

    Examples:
        | code | name        | action              |
        |      | Warehouse 1 | code can't be blank |
        | WH#1 |             | name can't be blank |

    Scenario: create new warehouse
        When I follow "Create new warehouse"
        And I fill in "code" with "WH#1"
        And I fill in "name" with "Warehouse 1"
        And I fill in "address" with "Address warehouse 1"
        And I press "Save warehouse"
        Then I should be redirected
        And I should see "WH#1"
        And I should see "Warehouse 1"
        And I should see "Address warehouse 1"

    Scenario: create warehouse with same code
        Given warehouse "WH#1" belongs to company "monsterinc"
        When I follow "Create new warehouse"
        And I fill in "code" with "WH#1"
        And I fill in "name" with "Warehouse 1"
        And I press "Save warehouse"
        Then I should see "code has already been taken"
        And I should have 1 warehouse

    Scenario: warehouse with same code but different company
        Given warehouse "WH#1" belongs to company "enormicon"
        When I follow "Create new warehouse"
        And I fill in "code" with "WH#1"
        And I fill in "name" with "Warehouse 1"
        And I press "Save warehouse"
        Then I should be redirected
        And I should see "WH#1"
        And I should have 2 warehouse
