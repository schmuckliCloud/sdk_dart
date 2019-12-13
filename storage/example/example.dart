//Import the package
import 'package:schmucklicloud_storage/main.dart';

//Setup a referene
sCStorage reference = new sCStorage("<YOUR_APP_ID>", "<YOUR_APP_SECRET>");

//Define the bucket id and the dataset id
reference.setBucket(12);
reference.setDataset("my_dataset");

//Instead of a dataset, you also can use the auth token, when you want to use user specific data
reference.setAuthToken("<AUTH_TOKEN>");

//Insert some data
Map<String, dynamic> data = {
    "column_a": "some data...",
    "column_b": 34,
    "another_column": true
};
reference.insert("fancy_container", data).then((response) {
    print(jsonDecode(response.body)["status"]);
    //If the status code is 200, then the data has been saved successfully
    //If another status code is shown, then check the message parameter from the decoded response.body.
});