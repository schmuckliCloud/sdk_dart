# schmuckliCloud Storage SDK for Dart
This is the official SDK for the schmuckliCloud Storage service for Dart.

## Get started
To install the package, just add the following line in your existing `pubspec.yaml` file under `dependencies`:

```yml
dependencies:
    schmucklicloud_storage: <SELECT THE NEWEST VERSION>
```

After that, just install the package on your local machine via the command:

```bash
pub get
```

Now you are ready to use the schmuckliCloud storage service on your Dart/Flutter projects.

## Use in your project
Before you can use the function inside of your project, you also have to import the package in your file, where you will using the service.

```dart
//Import the package
import 'package:schmucklicloud_storage/main.dart';

//Setup a referene
sCStorage reference = sCStorage("<YOUR_APP_ID>", "<YOUR_APP_SECRET>");

//Define the bucket id and the dataset id
reference.setBucket(12);
reference.setDataset("my_dataset");

//Instead of a dataset, you also can use the auth token, when you want to use user specific data
reference.setAuthToken("<AUTH_TOKEN>");
```

As you can see in the example above, you have to create a reference to use then the function to insert, update, delete and get the data from the backend.