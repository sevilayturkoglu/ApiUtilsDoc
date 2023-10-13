package pojos;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pojo_RegisterCustomer {
    /*
 {
  "firstName": "Donald",
  "lastName": "Trump",
  "email": "kamlehekku@tozya.com",
  "phonaNumber": "987654321",
  "cityNameId": "{{cityId}}",
  "postCode": 0,
  "birthDate": "2023-09-14T10:30:35.954Z",
  "professionName": "Arzt",
  "professionSpecialityName": "Chirurgie",
  "professionTitleName": ""
}
         */

    private String firstName;
    private String lastName;
    private String email;
    private String phonaNumber;
    private String cityNameId;
    private int postCode;
    private String birthDate;
    private String professionName;
    private String professionSpecialityName;
    private String professionTitleName;
}