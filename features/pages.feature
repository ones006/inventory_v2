@pages
Feature: Main navigation
    In order to move around within the application
    As an admin
    I want to able to navigate around

    Background:
        Given company "monsterinc" exists
        And I visit subdomain "monsterinc"

    Scenario: I arrive at the root page
        When I go to the root page
        Then I should see "Sign In"

    Scenario: I arrive at the administrations page
        Given user "admin" is signed in on "monsterinc"
        When I go to the administrations page
        Then I should see "Categories"
        And I should see "Items"
