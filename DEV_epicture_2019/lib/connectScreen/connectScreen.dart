import 'package:flutter/material.dart';

class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => new _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPICTURE',
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ]),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(95.0),
            child: Center(
              
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
              Text(
                "EPICTURE",
                style: TextStyle(fontSize: 50.0, color: Colors.white),
              ),
              SizedBox(height: 150),
              Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: RaisedButton(
                        child: new Text('Connection à ImGur'),
                        textColor: Colors.black,
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        }),
                  ),
            ]),
          ),
          ),
        ),
      ),
    );
  }
}
