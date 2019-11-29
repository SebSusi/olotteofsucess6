import 'dart:async';
import 'package:flutter_travel_concept/screens/galerie_take.dart';
import 'package:flutter_travel_concept/screens/request.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/material.dart';

const baseUrl = "https://api.myjson.com/bins/e4z6a";

class API {
  static Future getUsers() {
    var url = baseUrl;
    return http.get(url);
  }
}


class User {
  String nom;
  String nom2;
  bool absent;
  bool retard;

  User(String nom, String nom2, bool absent, bool retard) {
    this.nom = nom;
    this.nom2 = nom2;
    this.absent = absent;
    this.retard = retard;
  }

  User.fromJson(Map json)
      : nom = json['nom'],
        nom2 = json['prenom'],
        absent = false,
        retard = false;

  Map toJson() {
    return {'nom': nom, 'prenom': nom2, 'absent': absent, 'retard': retard};
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   build(context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Liste d\'appel',
//       theme: ThemeData(
//         primarySwatch: Colors.yellow,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }



class CheckScreen extends StatefulWidget {
  @override
  createState() => _CheckScreenState();
}


class _CheckScreenState extends State {
  var users = List<User>();
  var usersAbsent = List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chek-IN"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () {_pushAbsentLateScreen(usersAbsent);}
            )
          ],
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].nom + " " + users[index].nom2),
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new IconButton(
                      icon: Icon(
                          users[index].absent ? Icons.error_outline : Icons
                              .error_outline,
                          color: users[index].retard ? Colors.red : Colors
                              .green),
                      onPressed: () {
                        setState(() {
                          if (users[index].retard == true) {
                            users[index].retard = false;
                          } else {
                            users[index].retard = true;
                          }
                        });
                      },
                    ),
                    new IconButton(
                      icon: Icon(
                          users[index].absent ? Icons.build : Icons
                              .build,
                          color: users[index].absent ? Colors.red : Colors
                              .green),
                      onPressed: () {
                        setState(() {
                          if (users[index].absent == true) {
                            usersAbsent.remove(users[index]);
                            users[index].absent = false;
                          } else {
                            usersAbsent.add(users[index]);
                            users[index].absent = true;
                          }
                        });
                      },
                    ),
                  ]),
            );
          },
        ),floatingActionButton: FloatingActionButton(
        onPressed: () {FavoriteScreen();},
        child: Icon(
          Icons.photo_camera,
        ),
      ));
  }

  void _pushAbsentLateScreen(usersAbsent) {
    Navigator.push(context,
      new MaterialPageRoute(builder: (context) {
        return new AbsentLateScreen(usersAbsent, users);
      }),
    );
  }
}

class AbsentLateScreen extends StatelessWidget {
  final usersAbsent;
  final users;
  AbsentLateScreen(this.usersAbsent, this.users);


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pièces endommagées')),
      body: ListView.builder(
        itemCount: usersAbsent.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(usersAbsent[index].nom + " " + usersAbsent[index].nom2),
            trailing: Icon(Icons.cancel, color: Colors.red),
            onTap: () {      // Add 9 lines from here...
              users[index].absent = false;
              usersAbsent.remove(usersAbsent[index]);
            },
          );
        },
      ),
    );
  }
}