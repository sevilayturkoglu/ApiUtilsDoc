@educations
Feature:Educations

  @post
  Scenario:I should send my educations information
    Given Api user sets "api/Educations" path parameters.
    And Request body is:
    """
  {
  "title": "Gazi Universitesi Tip",
  "description": "Radyoloji ",
  "startTime": "2018-09-04T22:21:51.353Z",
  "endTime": "2020-09-04T22:21:51.353Z",
  "gpa": 0
}
    """
    And Sends POST request with Body and valid Authorization
    And Verifies that the response "title" value is "Gazi Universitesi Tip"
    And Verifies that the response "description" value is "Radyoloji "
    Then Verifies that the returned status code is 201

  @post
  Scenario:I should NOT send my educations information(unAuthorized)
    Given Api user sets "api/Educations" path parameters.
    And Request body is:
    """
  {
  "title": "Cucumber API Tip",
  "description": "Featuresss ",
  "startTime": "2018-09-04T22:21:51.353Z",
  "endTime": "2020-09-04T22:21:51.353Z",
  "gpa": 0
}
    """
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 401

  @post
  Scenario:I should NOT send my educations information(Without Title)
    Given Api user sets "api/Educations" path parameters.
    And Request body is:
    """
  {
  "title": "",
  "description": "Featuresss ",
  "startTime": "2018-09-04T22:21:51.353Z",
  "endTime": "2020-09-04T22:21:51.353Z",
  "gpa": 0
}
    """
    And Sends POST request with Body and valid Authorization
    And Verifies that the response "errors.Title[0]" value is "'Title' darf nicht leer sein."
    Then Verifies that the returned status code is 400

  @post
  Scenario:I should NOT send my educations information(Without description)
    Given Api user sets "api/Educations" path parameters.
    And Request body is:
    """
  {
  "title": "Cucumber API Tip",
  "description": "",
  "startTime": "2018-09-04T22:21:51.353Z",
  "endTime": "2020-09-04T22:21:51.353Z",
  "gpa": 0
}
    """
    And Sends POST request with Body and valid Authorization
    And Verifies that the response "errors.Description[0]" value is "'Description' darf nicht leer sein."
    Then Verifies that the returned status code is 400

  @post
  Scenario:I should NOT send my educations information(Wrong start Time info)
    Given Api user sets "api/Educations" path parameters.
    And Request body is:
    """
  {
  "title": "Cucumber API Tip",
  "description": "Featuresss ",
  "startTime": "2022-09-04T22:21:51.353Z",
  "endTime": "2015-09-04T22:21:51.353Z",
  "gpa": 0
}
    """
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 400


@put
  Scenario:I should send my education and then I can change my educations information
    Given Api user sets "api/Educations" path parameters.
    And Prepare PUT Education Request body "id" "Cerrahpasa Tip" "HematolojiDahiliye" "2014-09-04T22:39:39.350Z" "2016-09-04T22:39:39.350Z" 0.
    And Sends PUT request with Body and valid Authorization
    And Verifies that the response "title" value is "Cerrahpasa Tip"
    And Verifies that the response "description" value is "HematolojiDahiliye"
    Then Verifies that the returned status code is 200

  @put
  Scenario:I should NOT send my education and then I can change my educations information(Without Title)
    Given Api user sets "api/Educations" path parameters.
    And Prepare PUT Education Request body "id" "" "HematolojiDahiliye" "2014-09-04T22:39:39.350Z" "2016-09-04T22:39:39.350Z" 0.
    And Sends PUT request with Body and valid Authorization
    And Verifies that the response "errors.Title[0]" value is "'Title' darf nicht leer sein."
    Then Verifies that the returned status code is 400

  @put
  Scenario:I should NOT send my education and then I can change my educations information(Without description)
    Given Api user sets "api/Educations" path parameters.
    And Prepare PUT Education Request body "id" "Cerrahpasa Tip" "" "2014-09-04T22:39:39.350Z" "2016-09-04T22:39:39.350Z" 0.
    And Sends PUT request with Body and valid Authorization
    And Verifies that the response "errors.Description[0]" value is "'Description' darf nicht leer sein."
    Then Verifies that the returned status code is 400

@get
  Scenario:I should see spesific educations wich ever I want.
    Given Api user sets "api/Educations" path parameters.
    Given Api user sets edu path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "description" value is "Put ve Delete yapacagim Egitim "
    Then Verifies that the returned status code is 200

@get
  Scenario: I should NOT see spesific educations wich ever I want.(UnAuthorized)
    Given Api user sets "api/Educations" path parameters.
    Given Api user sets edu path parameters.
    And Sends GET request with invalid Authorization
    Then Verifies that the returned status code is 401

  @get
  Scenario:I should NOT see spesific educations wich ever I want.(Wrong Id)
    Given Api user sets "api/Educations/0466bd45-0787-477b-b39b-a6312fb3e0f" path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "title" value is "Rule violation"
    And Verifies that the response "detail" value is "Ausbildungsdaten konnten nicht gefunden werden."
    Then Verifies that the returned status code is 400

  @get
  Scenario: I should see spesific educations page/take wich ever I want.
    Given Api user sets "api/Educations/1/25" path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "page" value is "1"
    And Verifies that the response "take" value is "25"
    Then Verifies that the returned status code is 200

@get
  Scenario: I should NOT see spesific educations page/take wich ever I want.(UnAuthorized)
    Given Api user sets "api/Educations/1/25" path parameters.
    And Sends GET request with invalid Authorization
    Then Verifies that the returned status code is 401

@get
  Scenario:I should NOT see spesific educations page/take wich ever I want.(wrongPaths)
    Given Api user sets "api/Educations/1/2k" path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "errors.take[0]" value is "The value '2k' is not valid."
    Then Verifies that the returned status code is 400

  @get
  Scenario:I should delete my education information which ever I want
    Given Api user sets "api/Educations" path parameters.
    Given Api user sets edu path parameters.
    And Delete  information












