@login
Feature: user login
    In order to use the application
    As a registered user
    I want to login and use the application

    Scenario: registered user login
        Given I have the following user records
            | username | password | email |
            | admin | secret | admin@example.com |
        And I have tho following company records
            | name | subdomain |
            | Monster Inc | monsterinc |
        And the company "Monster Inc" have user "admin"
        When I visit subdomain "monsterinc"
        And I go to the root page
        And I fill in "Username" with "admin"
        And I fill in "Password" with "secret"
        And I press "Sign In"
        Then I should redirected to the root page
        And I should see "Monster Inc"
        And I should see "Welcome admin"
