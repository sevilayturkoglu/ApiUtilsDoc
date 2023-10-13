Feature:Accounts

  @signup @smoke @Post
  Scenario: User registers to the UnsDoc via API
    Given Api user sets "api/Accounts/signup" path parameters.
    And Creates request body with random datas
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 201

  @signin
  Scenario: User signin to the UnsDoc via API
    Given Api user sets "api/Accounts/signin" path parameters.
    And Request body is:
     """
    {
        "email": "cobij65750@chambile.com",
        "password": "Kevin123*"
    }
    """
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response body include "$id" text
    Then Verifies that the response body include "token" text

  @logout
  Scenario: User logout from the UnsDoc via API
    Given Api user sets "api/Accounts/logout" path parameters.
    And Sends PUT request with valid Authorization
    Then Verifies that the returned status code is 204

  @update
  Scenario: User update to user data via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
  {
      "firstName": "Donald",
      "lastName": "Trump",
      "email": "cobij65750@chambile.com",
      "phonaNumber": "987654321",
      "cityNameId": 27,
      "postCode": 0,
      "birthDate": "2023-09-14T10:30:35.954Z",
      "professionName": "Arzt",
      "professionSpecialityName": "Chirurgie",
      "professionTitleName": ""
  }
    """
    And Sends PUT request with Body and valid Authorization
    Then Verifies that the returned status code is 200

  @accounts
  Scenario: User lists accounts via API
    Given Api user sets "api/Accounts" path parameters.
    And Sends GET request with valid Authorization
    Then Verifies that the returned status code is 200
    Then Verifies that the response body include "email" text

  @change
  Scenario: User changes password via API
    Given Api user sets "api/Accounts/change-password" path parameters.
    And Request body is:
     """
      {
        "currentPassword": "Kevin123*",
        "newPassword": "Kevin123*"
      }
    """
    And Sends PUT request with Body and valid Authorization
    Then Verifies that the returned status code is 200

  @refresh
  Scenario: User refreshs token via API
    Given Api user sets "api/Accounts/signin" path parameters.
    And Request body is:
     """
      {
          "email": "keven.ali@minofangle.org",
          "password": "Kevin123*"
      }
    """
    And Sends POST request with Body and valid Authorization
    Then Saves refresh token
    When Api user sets "api/Accounts/refresh-token" path parameters.
    And Token time is refreshes
    Then Verifies that the returned status code is 200
    Then Verifies that the response body include "refreshToken" text

  @nodata
  Scenario: User cannot register without entering any data via API
    Given Api user sets "api/Accounts/signup" path parameters.
    And Request body is:
    """
       {
        "firstName": "",
        "lastName": "",
        "email": "",
        "password": ""
      }
    """
    And Sends POST request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.LastName[0]" value is "'Last Name' darf nicht leer sein."
    But Verifies that the response "errors.FirstName[0]" value is "'First Name' darf nicht leer sein."
    But Verifies that the response "errors.Email[0]" value contains "'Email' darf nicht leer sein."
    But Verifies that the response "errors.Password[0]" value contains "'Password' darf nicht leer sein."


  @unnamed
  Scenario: User cannot register with unnamed data via API
    Given Api user sets "api/Accounts/signup" path parameters.
    And Request body is:
    """
       {
        "firstName": "",
        "lastName": "",
        "email": "fofov76444@chambile.com",
        "password": "Test.123"
      }
    """
    And Sends POST request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.LastName[0]" value is "'Last Name' darf nicht leer sein."
    But Verifies that the response "errors.FirstName[0]" value is "'First Name' darf nicht leer sein."

  @invalidPassword
  Scenario: User cannot register with unnamed data via API
    Given Api user sets "api/Accounts/signup" path parameters.
    And Request body is:
    """
      {
        "firstName": "Test",
        "lastName": "Assa",
        "email": "fofv7644@chambile.com",
        "password": "Test"
      }
    """
    And Sends POST request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.Password[0]" value is "Die Länge von 'Password' muss größer oder gleich 6 sein. Sie haben 4 Zeichen eingegeben."

  @invalidEmail
  Scenario: User cannot register with unnamed data via API
    Given Api user sets "api/Accounts/signup" path parameters.
    And Request body is:
    """
      {
        "firstName": "Test",
        "lastName": "Assa",
        "email": "fofv7644chambile.com",
        "password": "Test.123"
      }
    """
    And Sends POST request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.Email[0]" value is "'Email' ist keine gültige E-Mail-Adresse."

  @updateInvalidMail
  Scenario: User cannot update invalidmail via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
      "firstName": "Donald",
      "lastName": "Trump",
      "email": "kamlehekku@assa",
      "phonaNumber": "987654321",
      "city": "NewYork",
      "postCode": 0,
      "birthDate": "2023-09-14T10:30:35.954Z",
      "professionName": "Arzt",
      "professionSpecialityName": "Chirurgie",
      "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.Email[0]" value is "'Email' weist ein ungültiges Format auf."
    But Verifies that the response "traceId" value is "00-e191279a80ad8feac3162ba0a0e59153-41c2950ec67f9a4d-00"
    But Verifies that the response "title" value is "One or more validation errors occurred."

  @updateInvalidPostCode
  Scenario: User cannot update invalidpostacode via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
    "firstName": "Donald",
    "lastName": "Trump",
    "email": "cobij65750@chambile.com",
    "phonaNumber": "987654321",
    "cityNameId": 27,
    "postCode": "string",
    "birthDate": "2023-09-14T10:30:35.954Z",
    "professionName": "Arzt",
    "professionSpecialityName": "Chirurgie",
    "professionTitleName": ""
     }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.accountUpdateDto[0]" value is "The accountUpdateDto field is required."
    But Verifies that the response "errors.$.postCode[0]" value is "The JSON value could not be converted to System.Nullable`1[System.Int32]. Path: $.postCode | LineNumber: 6 | BytePositionInLine: 22."

  @updateInvalidCityName
  Scenario: User cannot update invalidcityname via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
      "firstName": "Donald",
      "lastName": "Trump",
      "email": "cobij65750@chambile.com",
      "phonaNumber": "987654321",
      "cityNameId": "adana",
      "postCode": 0,
      "birthDate": "2023-09-14T10:30:35.954Z",
      "professionName": "Arzt",
      "professionSpecialityName": "Chirurgie",
      "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "detail" value is "Diese E-Mail Adresse existiert bereits"
    But Verifies that the response "title" value is "Rule violation"

  @updateNoNameSurname
  Scenario: User cannot update nonamesurname via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
    "firstName": "",
    "lastName": "",
    "email": "cobij65750@chambile.com",
    "phonaNumber": "987654321",
    "cityNameId": 27,
    "postCode": 0,
    "birthDate": "2023-09-14T10:30:35.954Z",
    "professionName": "Arzt",
    "professionSpecialityName": "Chirurgie",
    "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.LastName[0]" value is "'Last Name' darf nicht leer sein."
    But Verifies that the response "errors.FirstName[0]" value is "'First Name' darf nicht leer sein."


  @updateinvalidPhone
  Scenario: User cannot update invalidphone via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
    "firstName": "Donald",
    "lastName": "Trump",
    "email": "cobij65750@chambile.com",
    "phonaNumber": "telefon",
    "cityNameId": 27,
    "postCode": 0,
    "birthDate": "2023-09-14T10:30:35.954Z",
    "professionName": "Arzt",
    "professionSpecialityName": "Chirurgie",
    "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.PhonaNumber[0]" value is "'Phona Number' weist ein ungültiges Format auf."

  @updateBirthDate
  Scenario: User cannot update invalidphone via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
    "firstName": "Donald",
    "lastName": "Trump",
    "email": "kamlehekku@tozya",
    "phonaNumber": "987654321",
    "cityNameId": 27,
    "postCode": 0,
    "birthDate": "2024-09-14T10:30:35.954Z",
    "professionName": "Arzt",
    "professionSpecialityName": "Chirurgie",
    "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "errors.BirthDate[0]" value is "Der Wert von 'Birth Date' muss kleiner sein als '28.09.2023 12:24:57'."

  @updateInvalidSpecialityName
  Scenario: User cannot update invalidspecialityname via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
     {
    "firstName": "Donald",
    "lastName": "Trump",
    "email": "cobij65750@chambile.com",
    "phonaNumber": "987654321",
    "cityNameId": 27,
    "postCode": 0,
    "birthDate": "2023-09-14T10:30:35.954Z",
    "professionName": "Arzt",
    "professionSpecialityName": "KBB",
    "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "detail" value is "Keine solche Berufsspezialität gefunden"
    But Verifies that the response "instance" value is "null"

  @updateInvalidProfessionName
  Scenario: User cannot update invalidprofessionname via API
    Given Api user sets "api/Accounts/update" path parameters.
    And Request body is:
     """
    {
      "firstName": "Donald",
      "lastName": "Trump",
      "email": "cobij65750@chambile.com",
      "phonaNumber": "987654321",
      "cityNameId": 27,
      "postCode": 0,
      "birthDate": "2023-09-14T10:30:35.954Z",
      "professionName": "Ogretmen",
      "professionSpecialityName": "Chirurgie",
      "professionTitleName": ""
    }
    """
    And Sends PUT request with Body and valid Authorization
    But Verifies that the returned status code is 400
    But Verifies that the response "detail" value is "BERUF ÜBERSETZEN GIBT ES NICHT"
    But Verifies that the response "instance" value is "null"

  @invalidChangePassword
  Scenario: User cannot changes invalid password via API
    Given Api user sets "api/Accounts/change-password" path parameters.
    And Request body is:
     """
     {
      "currentPassword": "Kevin123_Assa",
      "newPassword": "Kevin123*"
     }
    """
    And Sends PUT request with Body and valid Authorization
    Then Verifies that the returned status code is 400
    But Verifies that the response "detail" value is "Das eingegebene Passwort ist ungültig"
    But Verifies that the response "instance" value is "null"
