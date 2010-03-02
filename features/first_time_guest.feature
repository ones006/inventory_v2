Feature: First time guest visit
    In order for first time visitor
    As a guest
    I want to be able to sign up and login to application

    Scenario: first visit
        Given I have no users
        When I go to the root page
        Then I should redirected to signin page
        And I should see "Sign Up"
        And I should see "Sign In"

    Scenario: user sign up
        Given I am on the root page
        When I follow "Sign Up"
        And I fill in "Username" with "admin"
        And I fill in "email" with "admin@example.com"
        And I fill in "Password" with "secret"
        And I fill in "Password Confirmation" with "secret"
        And I press "Sign me up"
        Then I should see "You're signed up!"
        And I should see "Welcome admin"
        And I should have 1 user

    Scenario: user sign in
        Given I am not signed in
        And I have the following user records
            | username | email | password |
            | admin | admin@example.com | secret |
            | bob | bob@example.com | secret |
        When I fill in "Username" with "admin"
        And I fill in "Password" with "secret"
        And I press "Sign In"
        Then I should see "Welcome admin"
