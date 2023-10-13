package utilities;

import hooks.HooksAPI;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.json.JSONObject;
import org.junit.Assert;
import pojos.Pojo_EducationPut;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;

public class API_Utils {

    private static Response response;
    public static String addId;
    public static RequestSpecification spec;
    public static String edId;
    public static JSONObject reqBodyJson;
    public static String generateToken() {

        spec = new RequestSpecBuilder().setBaseUri(URI.create(ConfigReader.getProperty("base_url"))).build();
        RequestSpecification requestSpec = spec;

        Map<String, Object> expectedData = new HashMap<>();
        expectedData.put("email", ConfigReader.getProperty("email"));
        expectedData.put("password", ConfigReader.getProperty("password"));

        Response response = given().spec(requestSpec).contentType(ContentType.JSON).
                body(expectedData).when().post();

        JsonPath json = response.jsonPath();
        return json.getString("token");

    }

        public static Response deleteRequest (String endPoint){
            JSONObject object = new JSONObject();
            object.put("id", addId);
            response = RestAssured.given().spec(HooksAPI.spec).headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when().body(object.toString())
                    .delete(endPoint);
            response.prettyPrint();
            Assert.assertEquals(204, response.getStatusCode());

            return response;
        }
        public static Response getRequest (String endpoint){
             response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .get(endpoint);
            response.prettyPrint();
            return response;
        }
        public static Response getRequestWithBody (String endpoint, JSONObject reqBodyJson){
            Response response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBodyJson.toString())
                    .get(endpoint);
            response.prettyPrint();
            return response;
        }
        public static Response postRequest (String endpoint, JSONObject reqBodyJson){
            response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBodyJson.toString())
                    .post(endpoint);
            response.prettyPrint();
            return response;
        }

        public static Response patchRequest (String endPoint, JSONObject reqBody){
           response = given()
                    .spec(HooksAPI.spec)
                    .headers("Authorization", "Bearer " + HooksAPI.token)
                    .contentType(ContentType.JSON)
                    .when()
                    .body(reqBody.toString())
                    .patch(endPoint);
            response.prettyPrint();
            return response;
        }

    public static Response addNewRecord(String body,String endPoint){

        response = RestAssured.given().spec(HooksAPI.spec).header("Authorization","Bearer "+HooksAPI.token)
                .contentType(ContentType.JSON)
                .when().body(body)
                .post(endPoint);

        JsonPath path = response.jsonPath();

        addId = path.getString("addId");

        return response;
    }

    public static Response getRequestWithInvalidAuthorization(String endpoint) {

        String invalidToken=HooksAPI.token+"invalid";
        response = given().spec(HooksAPI.spec).
                headers("Authorization", "Bearer " + invalidToken)
                .contentType(ContentType.JSON)
                .when()
                .get(endpoint);
        response.prettyPrint();

        return response;
    }

    public static Response putRequest (String endPoint, JSONObject reqBody){
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .body(reqBody.toString())
                .put(endPoint);
        response.prettyPrint();
        return response;
    }

public static String getEduId(String endPoint){
 String body = "{\n" +
         "           \"title\": \"Gazi Universitesi Tip\",\n" +
         "           \"description\": \"Put ve Delete yapacagim Egitim \",\n" +
         "           \"startTime\": \"2018-09-04T22:21:51.353Z\",\n" +
         "           \"endTime\": \"2020-09-04T22:21:51.353Z\",\n" +
         "           \"gpa\": 0\n" +
         "         }";
    reqBodyJson=new JSONObject(body);

    response = given()
            .spec(HooksAPI.spec)
            .headers("Authorization", "Bearer " + HooksAPI.token)
            .contentType(ContentType.JSON)
            .when()
            .body(reqBodyJson.toString())
            .post(endPoint);
    response.prettyPrint();
    JsonPath respJS = response.jsonPath();
    edId = respJS.getString("id");
    System.out.println("method edu Id= " + edId);
    return edId;

}
    public static Response putRequest (String endPoint){
        response = given()
                .spec(HooksAPI.spec)
                .headers("Authorization", "Bearer " + HooksAPI.token)
                .contentType(ContentType.JSON)
                .when()
                .put(endPoint);
        response.prettyPrint();
        return response;
    }
}

