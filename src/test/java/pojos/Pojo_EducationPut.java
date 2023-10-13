package pojos;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pojo_EducationPut {

/*
{
  "id": "{{educationId}}",
  "title": "Cerrahpasa Tip",
  "description": "Hematoloji",
  "startTime": "2014-09-04T22:39:39.350Z",
  "endTime": "2016-09-04T22:39:39.350Z",
  "gpa": 0
}
 */

    private String id;
    private String title;
    private String description;
    private String startTime;
    private String endTime;
    private int gpa;



}
