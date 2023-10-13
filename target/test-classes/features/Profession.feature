@profession
Feature: GET PROFESSİONS


  Scenario:  Positive GET The user should be able to professions page
    Given Api user sets "api/Professions/profession" path parameters.
    And Sends GET request with valid Authorizations
    Then  Verifies that the response "$values[0].translatedName" value is "Arzt"
    Then Verifies that the returned status code is 200

  Scenario:  Positive GET The user should be able to professions page
    Given Api user sets "api/Professions/profession-speciality/a653cbe9-ba6f-444b-8a06-a58b8ccd087d" path parameters.
    And Send GET request with valid Authorizations
    Then Verifies that the response "$values[3].professionSpecialityId" value is "c1b2e054-8099-4bff-a3cc-14c93b761f5f"
    Then Verifies that the response "$values[3].translatedName" value is "Anatomie"
    Then Verifies that the returned status code is 200

  Scenario:  Positive GET The user should be able to professions page
    Given Api user sets "api/Professions/profession-title/c1b2e054-8099-4bff-a3cc-14c93b761f5f" path parameters.
    And Sends GET request with valid Authorizations
    Then  Verifies that the response "$values" value is "[]"
    Then Verifies that the returned status code is 200


