import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../main.dart';
import './photoInfo.dart';

class ProfileData extends StatefulWidget {
  final Data data;
  ProfileData({this.data});
  @override
  _ProfileDataState createState() => _ProfileDataState(
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
      name: json['name'],
      desc: json['description'],
      link: json['link'],
      fav: json['favorite'],
    );
  }
}

class User {
  final int id;
  final String url;
  final String bio;
  final String avatar;

  User(this.id, this.url, this.bio, this.avatar);

  User.fromJson(Map<String, dynamic> json)
      : id = json['data']['id'],
        url = json['data']['url'],
        bio = json['data']['bio'],
        avatar = json['data']['avatar'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'bio': bio,
        'avatar': avatar,
      };
}

class _ProfileDataState extends State<ProfileData> {
  final Data data;
  _ProfileDataState({this.data});
  var isLoading = false;
  User user;
  List<Photo> userImage;
  static String tag = 'home-page';

  @override
  void initState() {
    super.initState();
    _fetchData();
    _fetchDataImage();
  }

  Future<void> refresh() {
    _fetchDataImage();
    return Future.value();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      'https://api.imgur.com/3/account/${data.accountUser}',
      headers: {HttpHeaders.authorizationHeader: "Client-ID ${data.clientId}"},
    );
    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      var _user = User.fromJson(userMap);
      setState(() {
        isLoading = false;
        user = _user;
      });
    }
  }

  _fetchDataImage() async {
    List<Photo> list;
    final response = await http.get(
      'https://api.imgur.com/3/account/${data.accountUser}/images/0',
      headers: {HttpHeaders.authorizationHeader: "Bearer ${data.accessToken}"},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.body);
      var rest = data["data"] as List;

      list = rest.map<Photo>((json) => Photo.fromJson(json)).toList();

      setState(() {
        isLoading = false;
        userImage = list;
      });
    }
  }

  void _onTapItem(BuildContext context, Photo photo, Data data) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PhotoInfo(
              photo: photo,
              data: data,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final body = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: RefreshIndicator(
        onRefresh: refresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              expandedHeight: 200.0,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(data.accountUser,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Row(
                    children: <Widget>[
                      Spacer(),
                      CircleAvatar(
                        radius: 54.0,
                        backgroundImage: NetworkImage(
                          user.avatar,
                        ),
                      ),
                      Spacer(),
                    ],
                  )),
            ),
            SliverFillRemaining(
              child: Container(
                child: userImage.length != 0
                    ? ListView.builder(
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
                                  child: Image.network(
                                      '${userImage[position].link}'),
                                  height: 400.0,
                                  width: 120.0,
                                ),
                              ),
                              onTap: () => _onTapItem(
                                  context, userImage[position], data),
                            ),
                          );
                        })
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Vous n'avez pas d'images",
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
