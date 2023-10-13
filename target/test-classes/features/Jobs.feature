@jobs
Feature: GET JOBS


  Scenario:  Pozitif GET The user should be able to filter using all valid parameters on the jobs page
    Given Api user sets "api/Jobs" path parameters.
    Given Api user sets "pageSize=39","pageNo=1","keyword=Allgemeinmedizin","lat=52.5210","lon=13.3740","radius=80" query parameters.
    And Sends GET request with valid Authorization
    Then  Verifies that the response "take" value is "39"
    Then  Verifies that the response "data.$values[0].einsatzortOrt" value is "Berlin"
    Then Verifies that the returned status code is 200

  Scenario: Pozitif GET The user should be able to filter by leaving some of them blank by using the valid parameters that they have specified on the jobs page.
    Given Api user sets "api/Jobs" path parameters.
    Given Api user sets "keyword=Allgemeinmedizin","lat=52.5210","lon=13.3740","radius=60" query parameters.
    And   Sends GET request with valid Authorization
    Then  Verifies that the response "totalItems" value is "16"
      #totalItems iş ilanlarına göre değişebilir
    Then  Verifies that the response "data.$values[0].einsatzortOrt" value is "Berlin"
    Then  Verifies that the returned status code is 200


  Scenario: Pozitif GET The user should be able to perform general filtering by leaving all parameters blank on the jobs page.
    Given Api user sets "api/Jobs" path parameters.
    And   Sends GET request with valid Authorization
    Then  Verifies that the response "totalItems" value is "4420"
         #totalItems iş ilanlarına göre değişebilir
    Then  Verifies that the returned status code is 200

  Scenario: Pozitif GET The user should be able to view that job by using the "stelleUuid" in the job postings in the filtering result on the jobs page.
    Given Api user sets "api/Jobs/8b7f9241-01b1-4c9b-b44f-468435310dc2" path parameters.
    And   Sends GET request with valid Authorization
    Then  Verifies that the returned status code is 200


  Scenario: Negatif GET The user should not be able to view the "stelleUuid" that is not valid in the job postings in the filtering result on the job postings page
    Given Api user sets "api/Jobs/8b7f241-01b1-49b-b44f-468435" path parameters.
    And   Sends GET request with valid Authorization
    Then  Verifies that the returned status code is 500
