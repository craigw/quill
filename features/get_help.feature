Feature: Get Help
  In order to work out what Quill can do
  As someone connected to Quill
  I want to get some help

  Scenario: Ask for help
    Given a new Quill session
    When I ask for help
    Then I should see the help screen
