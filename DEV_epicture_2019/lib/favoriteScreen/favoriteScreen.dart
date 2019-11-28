import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../main.dart';

class FavoriteScreen extends StatefulWidget {
  final Data data;
  FavoriteScreen({this.data});
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState(
        data: data,
      );
}

class Photo {
  final String id;
  final String name;
  final String desc;
  final String link;
  final bool fav;

  Photo(
      {this.id = "", this.name = "", this.desc = "", this.link = "", this.fav});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      id: json['id'].toString(),
      name: json['title'],
      desc: json['description'],
      link: json['link'],
      fav: json['favorite'],
    );
  }
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Data data;
  _FavoriteScreenState({this.data});
  var isLoading = false;
  List<Photo> userImage;
  int nb_fav = 0;
  @override
  void initState() {
    super.initState();
    _fetchDataImage();
  }

  Future<void> refresh() {
    _fetchDataImage();
    return Future.value();
  }

  _fetchDataImage() async {
    List<Photo> list;
    final response = await http.get(
      'https://api.imgur.com/3/account/${data.accountUser}/favorites/0/newest',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${data.accessToken}"},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.body);
      var rest = data["data"] as List;

      list = rest.map<Photo>((json) => Photo.fromJson(json)).toList();
      for (var i = 0; i < list.length; i++) {
        print(i);
        print(list[i].fav);
        if (list[i].fav == true) {
          nb_fav = nb_fav + 1;
        }
      }
      print(nb_fav);
      setState(() {
        isLoading = false;
        userImage = list;
      });
    }
  }

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
        child: Container(
          child: userImage.length != 0 
              ?RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  itemCount: userImage.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, position) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${userImage[position].name}',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: userImage[position].desc != null
                            ? Text("${userImage[position].desc}")
                            : Text(""),
                        isThreeLine: true,
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Image.network('${userImage[position].link}'),
                            height: 400.0,
                            width: 120.0,
                          ),
                        ),
                        //onTap: () => _onTapItem(context, userImage[position]),
                      ),
                    );
                  })
              )
              :
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.blue,
                          Colors.lightBlueAccent,
                        ]),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Vous n'avez pas de favoris",
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              
        ),
      ),
    );
  }
}
