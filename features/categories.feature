@categories
Feature: Categories management
    In order to manage categories
    As a registered user
    I want to ceate and manage categories

    Scenario: create new category
        Given user "admin" is signed in on "monsterinc"
        And I have no categories
        When I go to the list of categories
        And follow "Create new category"
        And I fill in "Category" with "Electronics"
        And I fill in "Name" with "MP3 Players"
        And I fill in "Description" with "MP3 Players Gadget"
        And I press "Save category"
        Then I should be redirected
        And I should see "Electronics"
        And I should see "MP3 Players"
        And I should see "MP3 Players Gadget"
        And I should have 2 category
