Feature:ExternalAuths

  @externalAuths
  Scenario: User accesses google page with externalAuths
    Given Api user sets "api/ExternalAuths/google" path parameters.
    And Request body is:
     """
      {
        "idToken": ""
      }
    """
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200