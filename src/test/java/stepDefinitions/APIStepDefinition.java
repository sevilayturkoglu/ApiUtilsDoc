package stepDefinitions;

import com.github.javafaker.Faker;
import hooks.HooksAPI;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import org.hamcrest.Matchers;
import org.json.JSONObject;
import org.junit.Assert;
import org.testng.asserts.SoftAssert;
import pojos.Pojo_EducationPut;
import utilities.API_Utils;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;

public class APIStepDefinition {
    SoftAssert softAssert = new SoftAssert();
    public static String fullPath;
    public static JSONObject reqBodyJson;
    public static JSONObject expBodyJson;
    public static Response response;
    public static String refreshToken;
    public static JsonPath respJS;
    public static String eduId;

    public static String professionId;

    public static String professionSpecialityId;
    Pojo_EducationPut reqEduPutPojoBody;
    Faker faker=new Faker();

    @Given("Api user sets {string} path parameters.")
    public void apiUserSetsPathParameters(String rawPaths) {


        String[] paths = rawPaths.split("/");

        StringBuilder tempPath = new StringBuilder("/{");

        for (int i = 0; i < paths.length; i++) {
            String key = "pp" + i; //pp0 pp1 pp2
            String value = paths[i].trim(); //solunda sagında bosluk varsa silmek icibn trim kulandık
            HooksAPI.spec.pathParam(key, value);
            tempPath.append(key + "}/{");
            System.out.println("value = " + value);
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));

        fullPath = tempPath.toString();
    }


    @Then("Verifies that the returned status code is {int}")
    public void verifiesThatTheReturnedStatusCodeIs(int statusCode) {
        softAssert.assertEquals(response.getStatusCode(), statusCode, "Status code value is NOT " + statusCode);
        softAssert.assertAll();
    }


    @Then("Verifies that the response message is {string}")
    public void verifiesThatTheResponseMessageIs(String message) {
        JsonPath respJS = response.jsonPath();
        softAssert.assertEquals(respJS.getString("message"), message, "Returned message is not true");
    }


    @And("Sends GET request with Body and valid Authorization")
    public void sendsGETRequestWithBodyAndValidAuthorization() {
        response = API_Utils.getRequestWithBody(fullPath, reqBodyJson);
    }

    @And("Sends GET request with Body with invalid Authorization")
    public void sendsGETRequestWithBodyWithInvalidAuthorization() {
        System.out.println(fullPath);
        response = given()
                .spec(HooksAPI.spec)
                .header("Authorization", "Bearer " + "ZBRqKnnTiE9iSdHVCdMPbaP44dClmz")
                .contentType(ContentType.JSON)
                .when()
                .body(reqBodyJson.toString())
                .get(fullPath);
        response.prettyPrint();
    }

    @Given("Sends POST request with Body and valid Authorization")
    public void sends_post_request_with_body_and_valid_authorization() {
        response = API_Utils.postRequest(fullPath, reqBodyJson);
    }

    @And("Sends POST request with Body and invalid Authorization")
    public void sendsPOSTRequestWithBodyAndInvalidAuthorization() {
        String invalidToken = HooksAPI.token + "invalid";
        response = given().headers("Authorization",
                        "Bearer " + invalidToken,
                        "Content-Type",
                        ContentType.JSON,
                        "Accept",
                        ContentType.JSON).spec(HooksAPI.spec).contentType(ContentType.JSON)
                .when().body(reqBodyJson.toString())
                .post(fullPath);
        response.prettyPrint();

    }


    @And("Sends GET request with invalid Authorization")
    public void sendsGETRequestWithInvalidAuthorization() {
        response = API_Utils.getRequestWithInvalidAuthorization(fullPath);

        softAssert.assertAll();
    }


    @And("Sends GET request with valid Authorization")
    public void sendsGETRequestWithValidAuthorization() {
        response = API_Utils.getRequest(fullPath);
    }


    @Given("Verify that the datas are contained in the response body as {string},{string},{string}")
    public void verify_that_the_datas_are_contained_in_the_response_body_as(String rspnBody, String data, String dataValue) {
        String[] datasArr = data.split("#");
        String[] dataValuesArr = dataValue.split("#");

        for (int i = 0; i < datasArr.length; i++) {
            response
                    .then()
                    .assertThat()
                    .body(rspnBody + datasArr[i], Matchers.equalTo(dataValuesArr[i]));
            System.out.println(datasArr[i]);
            System.out.println(dataValuesArr[i]);
        }
    }


    @And("Request body is:")
    public void requestBodyIs(String body) {
        reqBodyJson = new JSONObject(body);
    }


    @And("Verifies in the response body with id {string}")
    public void verifiesInTheResponseBodyWithId(String id) {
        JsonPath resJp = response.jsonPath();
        assertEquals(id, resJp.get("lists.id[4]"));
    }

    @And("Verifies that the response {string} value is {string}")
    public void verifiesThatTheResponseValueIs(String respath, String message) {
        JsonPath respJS = response.jsonPath();
        softAssert.assertEquals(respJS.getString(respath), message, "Returned message is not true");


    }

    @And("Prepare PUT Education Request body {string} {string} {string} {string} {string} {int}.")
    public void preparePUTEducationRequestBody(String id, String title, String description, String sTime, String endTime, int gpa) {
        eduId = API_Utils.getEduId(fullPath);
        System.out.println("in the step "+eduId);
        reqEduPutPojoBody = new Pojo_EducationPut(eduId, title, description, sTime, endTime, gpa);
        reqBodyJson = new JSONObject(reqEduPutPojoBody);
    }


    @And("Delete  information {string}")
    public void deleteInformation(String del) {
        API_Utils.deleteRequest(del);
    }

    @And("Sends PUT request with valid Authorization")
    public void sendsPUTRequestWithValidAuthorization() {
        response = API_Utils.putRequest(fullPath);
    }

    @Given("Api user sets edu path parameters.")
    public void apiUserSetsDeletePathParameters() {
        String rawPaths="api/Educations/"+API_Utils.getEduId(fullPath);
        System.out.println(rawPaths);
        String[] paths = rawPaths.split("/");


        StringBuilder tempPath = new StringBuilder("/{");

        for (int i = 0; i < paths.length; i++) {
            String key = "pp" + i; //pp0 pp1 pp2
            String value = paths[i].trim(); //solunda sagında bosluk varsa silmek icibn trim kulandık
            HooksAPI.spec.pathParam(key, value);
            tempPath.append(key + "}/{");
            System.out.println("value = " + value);
        }

        tempPath.deleteCharAt(tempPath.lastIndexOf("{"));
        tempPath.deleteCharAt(tempPath.lastIndexOf("/"));

        fullPath = tempPath.toString();


    }

    @And("Delete  information")
    public void deleteInformation() {
        API_Utils.deleteRequest(fullPath);
    }
    @And("Sends PUT request with Body and valid Authorization")
    public void sendsPUTRequestWithBodyAndValidAuthorization() {
        response = API_Utils.putRequest(fullPath,reqBodyJson);
    }

    @Then("Verifies that the response body include {string} text")
    public void verifiesThatTheResponseBodyIncludeText(String body) {
        softAssert.assertTrue(response.toString().contains(body));
    }

    @Then("Saves refresh token")
    public void savesRefreshToken() {
        response.prettyPrint();
        JsonPath respJP = response.jsonPath();
        refreshToken=respJP.getString("refreshToken.token");
        System.out.println("refreshToken = " + refreshToken);
    }

    @And("Token time is refreshes")
    public void tokenTimeIsRefreshes() {
        reqBodyJson = new JSONObject(("{\n"+"  \"token\": \""+refreshToken+"\"\n" + "}"));
        System.out.println("reqBodyJson.toString() = " + reqBodyJson.toString());
        API_Utils.putRequest(fullPath,reqBodyJson);
    }

    @And("Verifies that the response {string} value contains {string}")
    public void verifiesThatTheResponseValueContains(String respath, String message) {
        JsonPath respJS = response.jsonPath();
        softAssert.assertTrue(respJS.getString(respath).contains(message));
        softAssert.assertAll();

    }

    @Given("Api user sets {string},{string},{string},{string},{string},{string} query parameters.")
    public void apiUserSetsQueryParameters(String arg0, String arg1, String arg2, String arg3, String arg4, String arg5) {

        HooksAPI.
                spec.
                queryParams("pageSize",39,
                        "pageNo" ,1,
                        "keyword","Allgemeinmedizin","lat",52.5210,"lon",13.3740,
                        "radius",80);

    }

    @Given("Api user sets {string},{string},{string},{string} query parameters.")
    public void apiUserSetsQueryParameters(String arg0, String arg1, String arg2, String arg3) {



        HooksAPI.
                spec.
                queryParams(
                        "keyword","Allgemeinmedizin","lat",52.5210,"lon",13.3740,
                        "radius",60);
    }

    @And("Sends GET request with valid Authorizations")
    public void sendsGETRequestWithValidAuthorizations() {
        response = API_Utils.getRequest(fullPath);
        JsonPath resJp = response.jsonPath();
        professionId = resJp.getString("$values[0].professionId");
        professionSpecialityId = resJp.getString("$values[3].professionSpecialityId");
        System.out.println("professionId : "+professionId);
        System.out.println("professionSpecialityId : "+professionSpecialityId);

    }

    @And("Send GET request with valid Authorizations")
    public void sendGETRequestWithValidAuthorizations() {
        response = API_Utils.getRequest(fullPath);
        JsonPath resJp = response.jsonPath();
        professionSpecialityId = resJp.getString("$values[3].professionSpecialityId");
        System.out.println("professionSpecialityId : "+professionSpecialityId);
    }

    @And("Creates request body with random datas")
    public void createsRequestBodyWithRandomDatas() {
        String firstName=faker.name().firstName();
        String lastName=faker.name().lastName();
        String email=faker.internet().emailAddress();
        reqBodyJson = new JSONObject(("    {\n" +
                "        \"firstName\": \""+firstName+"\",\n" +
                "        \"lastName\": \""+lastName+"\",\n" +
                "        \"email\": \""+email+"\",\n" +
                "        \"password\": \"Test.123\"\n" +
                "      }"));
    }
}

    

