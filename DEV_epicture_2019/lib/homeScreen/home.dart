import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import '../main.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeFeed extends StatefulWidget {
  final Data data;
  HomeFeed({this.data});
  @override
  _HomeFeedState createState() => _HomeFeedState(
        data: data,
      );
}

class _HomeFeedState extends State<HomeFeed> {
  final Data data;
  List<int> _image64;
  var _image;
  bool imageLoaded = false;
  String _title = "";
  String _desc = "";
  bool isLoading = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _image64 = image.readAsBytesSync();
      imageLoaded = true;
    });
  }

  uploadimage() async {
    setState(() {
      isLoading = true;
    });
    print(_image);
    String imageB64 = base64Encode(_image64);
    print(imageB64);
    String form = '{"type":"file", "image":"${_image}", "title":"${_title}","description":"${_desc}"}';
    final response = await http.post(
      'https://api.imgur.com/3/upload',
      headers: {HttpHeaders.authorizationHeader: "Client-ID ${data.clientId}"},
      body: imageB64,
    );
    print(response.body);
    print(_desc);
    print(_title);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  _HomeFeedState({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ]),
        ),
        child: Center(

          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text(
                "Upload une image",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              new RaisedButton(
                child: new Text('CHOISIR UNE IMAGE'),
                textColor: Colors.black,
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                onPressed: getImage,
              ),
              imageLoaded != false ? new Image.file(_image) : Text(""),
              new TextField(
                onChanged: (text) {
                  _title = text;
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Titre'),
              ),
              TextField(
                onChanged: (text) {
                  _desc = text;
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Description'),
              ),
              new RaisedButton(
                child: new Text('UPLOAD'),
                textColor: Colors.black,
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                onPressed: uploadimage,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
