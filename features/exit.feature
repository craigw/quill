Feature: Quit
  In order to work out what Quill can do
  As someone connected to Quill
  I want to get some help

  Scenario: Quit
    Given a new Quill session
    When I quit the Quill session
    Then Quill should stop running
