@supplier
Feature: Supplier management
    In order to manage supplier
    As an admin
    I want to create and manage suppliers

    Background:
        Given user "admin" is signed in on "monsterinc"
        And I have no suppliers
        And I am on the list of suppliers

    Scenario Outline: creating supplier with various attributes missing
        When I follow "Create new supplier"
        And I fill in "code" with "<code>"
        And I fill in "name" with "<name>"
        And I fill in "description" with "<description>"
        And I press "Save supplier"
        Then I should <action>
        And I should have <number> supplier

    Examples:
        | code  | name       | description                 | action          | number |
        | Supp1 | Supplier 1 | A description of supplier 1 | be redirected   | 1      |
        |       | Supplier 1 | A description of supplier 1 | not see "Supp1" | 0      |
        | Supp1 |            | A description of supplier 1 | not see "Supp1" | 0      |
        | Supp1 | Supplier 1 |                             | be redirected   | 1      |
