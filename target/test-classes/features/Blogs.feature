

Feature: GET Blogs

Scenario: Pozitif GET The user should be able to enter the Blogs page by entering the required data.
Given Api user sets "api/Blogs/1/10" path parameters.
And Sends GET request with valid Authorization
Then Verifies that the returned status code is 200


  Scenario: Pozitif GET The user should be able to enter the desired "id" on the Blogs page by entering the necessary data.
    Given Api user sets "api/Blogs/bbf81495-abce-45d0-ad9c-1e1874125ae8" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200

