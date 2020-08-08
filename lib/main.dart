// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File file;
//   var filename = '';
//   var output = 0;
//   var labels=new List();
//   var dataToBeShown='';

//   void gettingLabels() {
//     var data;
//     setState(() {});
//     final String api_link =
//         'https://xwycgbpe6c.execute-api.ap-south-1.amazonaws.com/reko-test-harsh-4';
//     String base64Image = base64Encode(file.readAsBytesSync());
//     http
//         .post(api_link,
//             body: jsonEncode(
//                 <String, String>{"name": filename, "image": base64Image}))
//         .then((res) {
//       data = List.from(Map.from(json.decode(res.body))['body']['Labels']);
//       for (var x in data){
//         print(x["Name"]);
//         labels.add(x["Name"]);
//       }
//       setState(() {
//         dataToBeShown=labels.toString();
//       });
//       print(data);
//     });
//   }

//   void _choose() async {
//     file = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() {
//         filename = file.path.split('/').last;
//       });
//     }
//   }

//   Widget upload_icon() {
//     return GestureDetector(
//       onTap: () {
//         _choose();
//       },
//       child: Icon(Icons.cloud_upload),
//     );
//   }

//   Widget upload_button() {
//     return GestureDetector(
//         onTap: () {
//           print("Analyzing starting");
//           gettingLabels();
//         },
//         child: Container(
//           child: Center(
//             child: Text("Analyze"),
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               dataToBeShown,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Container(
//               child: filename == '' ? upload_icon() : upload_button(),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:cloudinary_client/cloudinary_client.dart';

// // ignore: unused_import
// import 'package:cloudinary_public/cloudinary_public.dart';
// // ignore: unused_import
// import 'package:loading/indicator.dart';
// // ignore: unused_import
// import 'package:loading/indicator/ball_pulse_indicator.dart';

// import 'package:cloudinary_client/models/CloudinaryResponse.dart' as cr;
// import 'dart:convert';
// // ignore: unused_import
// import 'package:loading/loading.dart';
// import 'credentials.dart' as cred;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Making the cloudinary client
//   CloudinaryClient client =
//       CloudinaryClient(cred.api_key, cred.api_secret, cred.cloud_name);
//   var imageUrl;
//   bool isLoading = false;
//   Image uploadedImagee;

//   Future uploadImage() async {
//     print("Starting uploading");
//     // var image = ImagePicker.pickImage(source: ImageSource.gallery);
//     // setState(() {
//     //   isLoading = true;
//     // });
//     // file = await ImagePicker.pickImage(source: ImageSource.gallery);
//     // if (file != null) {
//     //   setState(() {
//     //     filename = file.path.split('/').last;
//     //   });
//     // }
//     cr.CloudinaryResponse response =
//         await client.uploadImage(file.path, folder: 'new_floder 123');
//     print(response.secure_url);
//     setState(() {
//       isLoading = false;
//       imageUrl = response.secure_url;
//       // filename = file.path.split('/').last;
//       uploadedImagee = Image.network(imageUrl);
//     });
//     print("Finished uploading");
//     print("starting labeling");
//     gettingLabels();
//     print("Ending labelling");
//   }

//   File file;
//   var filename = '';
//   var output = 0;
//   var labels = new List();
//   var dataToBeShown = '';

//   void gettingLabels() {
//     var data;
//     setState(() {});
//     final String api_link =
//         'https://xwycgbpe6c.execute-api.ap-south-1.amazonaws.com/reko-test-harsh-4';
//     String base64Image = base64Encode(file.readAsBytesSync());
//     http
//         .post(api_link,
//             body: jsonEncode(
//                 <String, String>{"name": filename, "image": base64Image}))
//         .then((res) {
//       data = List.from(Map.from(json.decode(res.body))['body']['Labels']);
//       for (var x in data) {
//         print(x["Name"]);
//         labels.add(x["Name"]);
//       }
//       setState(() {
//         dataToBeShown = labels.toString();
//       });
//       print(data);
//     });
//   }

//   void _choose() async {
//     file = await ImagePicker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       setState(() {
//         filename = file.path.split('/').last;
//       });
//     }
//   }

//   Widget upload_icon() {
//     return GestureDetector(
//       onTap: () {
//         _choose();
//       },
//       child: Icon(Icons.cloud_upload),
//     );
//   }

//   Widget upload_button() {
//     return GestureDetector(
//         onTap: () {
//           print("Analyzing starting");
//           uploadImage();
//         },
//         child: Container(
//           child: Center(
//             child: Text("Analyze"),
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               dataToBeShown,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Container(
//               child: filename == '' ? upload_icon() : upload_button(),
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:loading/indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:cloudinary_client/models/CloudinaryResponse.dart' as cr;
import 'dart:convert';
import 'package:loading/loading.dart';
import 'credentials.dart' as cred;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Making the cloudinary client
  CloudinaryClient client =
      CloudinaryClient(cred.api_key, cred.api_secret, cred.cloud_name);
  String imageUrl;
  bool isLoading = false;
  Image uploadedImagee;

  Future uploadImage() async {
    print("Starting uploading");
    cr.CloudinaryResponse response =
        await client.uploadImage(file.path, folder: 'new_floder 123');
    print(response.secure_url);
    setState(() {
      isLoading = false;
      imageUrl = response.secure_url;
      uploadedImagee = Image.network(imageUrl);
    });
    print("Finished uploading");
    print("starting labeling");
    gettingLabels();
    print("Ending labelling");
  }

  File file;
  var filename = '';
  var output = 0;
  var labels = new List();
  var dataToBeShown = '';

  void gettingLabels() {
    var data;
    setState(() {});
    final String api_link =
        'https://ufbh6l57pc.execute-api.ap-south-1.amazonaws.com/test11-deployment-2-POST/geturl';
    print("Printing url");
    print(imageUrl.toString());

    http
        .post(api_link,
            body:
                jsonEncode(<String, String>{"url": imageUrl, "name": filename}))
        .then((res) {
      print(res.body);
      data = Map.from(json.decode(res.body))['body'];
      data=data.toString().replaceAll("'", "\"");
      data=List.from(Map.from(json.decode(data))["Labels"]);
      print(data.runtimeType);
      for (var x in data) {
        print(x["Name"]);
        labels.add(x["Name"]);
      }
      setState(() {
        dataToBeShown = labels.toString();
      });
      print(data.toString());
    });
  }

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        filename = file.path.split('/').last;
      });
    }
  }

  Widget upload_icon() {
    return GestureDetector(
      onTap: () {
        _choose();
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Widget upload_button() {
    return GestureDetector(
        onTap: () {
          print("Analyzing starting");
          uploadImage();
        },
        child: Container(
          child: Center(
            child: Text("Analyze"),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              dataToBeShown,
              // style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              child: filename == '' ? upload_icon() : upload_button(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
