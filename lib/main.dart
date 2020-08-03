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
  File file;
  var filename = '';
  var output = 0;
  var labels=new List();
  var dataToBeShown='';

  void gettingLabels() {
    var data;
    setState(() {});
    final String api_link =
        'https://xwycgbpe6c.execute-api.ap-south-1.amazonaws.com/reko-test-harsh-4';
    String base64Image = base64Encode(file.readAsBytesSync());
    http
        .post(api_link,
            body: jsonEncode(
                <String, String>{"name": filename, "image": base64Image}))
        .then((res) {
      data = List.from(Map.from(json.decode(res.body))['body']['Labels']);
      for (var x in data){
        print(x["Name"]);
        labels.add(x["Name"]);
      }
      setState(() {
        dataToBeShown=labels.toString();
      });
      print(data);
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
          gettingLabels();
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
              style: Theme.of(context).textTheme.headline4,
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
