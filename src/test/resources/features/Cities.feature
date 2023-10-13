

Feature: All Cities in Unsdoc  are listed via API

  @cities
  Scenario: The user should be list the cities page by entering the required data.
    Given Api user sets "api/Cities/get-all-cities" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response body include "$id" text
    Then Verifies that the response body include "$values" text