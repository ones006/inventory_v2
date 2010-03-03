@subscription
Feature: new user or company subscription
    In order to use the application
    As a new user
    I want to subscribe to the application

    Scenario: new user visit
        Given I have no users
        When I go to the home page
        Then I should see "Sign Up"

    Scenario: new user registration
        Given I have no users
        And I am on the home page
        When I follow "Register"
        And I fill in "Username" with "admin"
        And I fill in "Password" with "secret"
        And I fill in "Password confirmation" with "secret"
        And I fill in "Company name" with "Monster Inc."
        And I press "Register"
        Then I should see "Registered successfully, please check your inbox for your activation email"
        And I should have 1 user
        And I should have 1 company
