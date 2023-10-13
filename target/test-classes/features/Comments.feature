@comments
Feature: Comments

@post
  Scenario:I should send post comment under the any blog
    Given Api user sets "api/Comments" path parameters.
    And Request body is:
    """
     {
  "content": "I will try send comments with Cucumber API ",
  "blogId": "899c0bfc-1a9c-4a60-bc9e-7573e31fc654"
}
    """
    And Sends POST request with Body and valid Authorization
    And Verifies that the response "blogId" value is "899c0bfc-1a9c-4a60-bc9e-7573e31fc654"
    Then Verifies that the returned status code is 201

  @post
  Scenario:I should NOT send comment under the any blog with invalid credentials(invalid blog ID)
    Given Api user sets "api/Comments" path parameters.
    And Request body is:
    """
     {
  "content": "I will try send comments with Cucumber API ",
  "blogId": "xxx9c0bfc-1a9c-4a60-bc9e-7573e31f"
}
    """
    And Sends POST request with Body and valid Authorization
    Then Verifies that the returned status code is 500

  @post
  Scenario:I should NOT send comment under the any blog with invalid credentials(invalid authorization)
    Given Api user sets "api/Comments" path parameters.
    And Request body is:
    """
     {
  "content": "I will try send comments with Cucumber API",
  "blogId": "899c0bfc-1a9c-4a60-bc9e-7573e31fc654"
}
    """
    And Sends POST request with Body and invalid Authorization
    Then Verifies that the returned status code is 401

  @post
  Scenario:I should NOT send comment under the any blog with invalid credentials(without content)
    Given Api user sets "api/Comments" path parameters.
    And Request body is:
    """
     {
  "content": "",
  "blogId": "xxx9c0bfc-1a9c-4a60-bc9e-7573e31f"
}
    """
    And Sends POST request with Body and valid Authorization
    And Verifies that the response "errors.Content[0]" value is "'Content' darf nicht leer sein."
    Then Verifies that the returned status code is 400

@get
  Scenario:I should see spesific comments page wich ever I want.
    Given Api user sets "api/Comments/899c0bfc-1a9c-4a60-bc9e-7573e31fc654/1/15" path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "data.$values[0].content" value is "Yeliz hocam yorum gonderdim onaylar misiniz"
    Then Verifies that the returned status code is 200

@get
  Scenario:I should NOT see spesific comments page wich ever I want.(invalid parameters)
    Given Api user sets "api/Comments/899c0bfc-1a9c-4a60-bc9e-7573e31fc654/m/15" path parameters.
    And Sends GET request with valid Authorization
    And Verifies that the response "errors.page[0]" value is "The value 'm' is not valid."
    Then Verifies that the returned status code is 400


