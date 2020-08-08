import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

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
      home: MyHomePage(title: 'Rekognition with S3'),
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

  // Variables
  File file;
  var filename = '';
  var output = 0;
  var labels=new List();
  var dataToBeShown='';

  // Function for getting the labels from API
  void gettingLabels() {
    var data;
    setState(() {});

    // Api called which gives us labels and other things
    // Created with Lambda and deployed with API gateway
    final String api_link =
        'https://c3alv12z9f.execute-api.ap-south-1.amazonaws.com/reko-test-s3/';
    
    // Converting image to bytes
    String base64Image = base64Encode(file.readAsBytesSync());
    
    // Calling the API
    http
        .post(api_link,
            body: jsonEncode(
                <String, String>{"name": filename, "image": base64Image}))
        .then((res) {
      data = List.from(Map.from(json.decode(res.body))['body']['Labels']);
      
      // Getting only label names out and storing them in a list
      for (var x in data){
        print(x["Name"]);
        labels.add(x["Name"]);
      }

      // Setting the variable dynamically
      setState(() {
        dataToBeShown=labels.toString();
      });

      // For debugging
      print(data);
    });
  }

  // Function for getting the image and its name
  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        filename = file.path.split('/').last;
      });
    }
  }

  // Widget for the Cloud icon and function triggering.
  Widget upload_icon() {
    return GestureDetector(
      onTap: () {
        _choose();
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  // Widget for the Analyse container and triggering function.
  Widget upload_button() {
    return GestureDetector(
        onTap: () {
          print("Analyzing starting");
          gettingLabels();
        },
        child: Container(
          child: Center(
            child: Text("Analyze"),
          ),
        ));
  }

  // Main Widget
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

            // Labels are shown here once we get the response from the API
            Text(
              dataToBeShown,
              style: Theme.of(context).textTheme.headline4,
            ),

            // Widget changes according to the condition
            Container(
              child: filename == '' ? upload_icon() : upload_button(),
            )
          ],
        ),
      ),
    );
  }
}
