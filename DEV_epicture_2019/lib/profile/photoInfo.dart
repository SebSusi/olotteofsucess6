import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../main.dart';
import './profile.dart';



class PhotoInfo extends StatefulWidget {
  Photo photo;
  Data data;
  PhotoInfo({this.photo, this.data});
  @override
  _PhotoInfoState createState() => _PhotoInfoState(
        photo: photo,
        data:data,
      );
}

class _PhotoInfoState extends State<PhotoInfo> {
  Photo photo;
  Data data;
  _PhotoInfoState({this.photo, this.data});
  bool isLoading = false;
  bool pressAttention;

  @override
  void initState() {
    super.initState();
    if (photo.fav == true)
      pressAttention = true;
    else
      pressAttention = false;
  }

  favoriteImage() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      'https://api.imgur.com/3/image/${photo.id}/favorite',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${data.accessToken}"},
			
    );
    print(response.statusCode);
    
    if (response.statusCode == 200) {
      pressAttention = !pressAttention;
      print(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: new Container(
          height: 300.0,
          width: 300.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(
                  photo.link),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: photo.name != null ? Text(
        photo.name,
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ) : Text(""),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: photo.desc != null ? Text(
        photo.desc,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ) : Text(""),
    );

    final favoris = new RaisedButton(
  child: new Text('FAVORIS'),
  textColor: Colors.white,
  shape: new RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(30.0),
  ),
  color: pressAttention ? Colors.green : Colors.blue,
  onPressed: favoriteImage,
);

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: Column(
        children: <Widget>[alucard, welcome, lorem, favoris],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: body,
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(""),
    //   ),
    //   body: Container(
        
    //     // decoration: BoxDecoration(
    //     //   color: Colors.blue
    //     // ),
    //     child:
    //       Column (
    //       children: 
    //       <Widget>[
    //         Image.network(photo.link,fit: BoxFit.cover,
    // alignment: Alignment.center,),
    //         photo.name != null ? Text(
    //           photo.name, 
    //           textAlign: TextAlign.center,
    //            style: TextStyle(
    //            fontSize: 40.0,
    //            fontWeight: FontWeight.bold,
    //            color: Colors.white,)) : Text(""),
    //         photo.desc != null ? Text(
    //           photo.desc, 
    //           textAlign: TextAlign.center,
    //            style: TextStyle(
    //            fontSize: 15.0,
    //            fontWeight: FontWeight.bold,
    //            color: Colors.white,)) : Text(""),
    //       ],
    //     ),
    //   ),
      
    // );
  }
}
