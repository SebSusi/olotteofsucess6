import 'package:flutter/material.dart';
import 'package:flutter_travel_concept/screens/details.dart';
import 'package:flutter_travel_concept/widgets/icon_badge.dart';
import 'package:flutter_travel_concept/util/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.location_on,
          ),
          onPressed: () {
            Alert(
                context: context,
                title: "Nacelles disponibles?",
                content: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: 'Lieu prévu:',
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.timer),
                        labelText: 'Quelle heure:',
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.maximize),
                        labelText: 'Nacelles choisie:',
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.description),
                        labelText: 'Autres informations:',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      
                      "Proposer une nacelle",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
      body: PageView(children: <Widget>[
        Container(
          child: new Image(
              image: new AssetImage('assets/map_marker.jpeg'),
              width: 48.0,
              height: 48.0),
        ),
        Container(
          child: new Image(
              image: new AssetImage('assets/map_chemin.jpeg'),
              width: 48.0,
              height: 48.0),
        ),
      ]),
    );
  }
}
