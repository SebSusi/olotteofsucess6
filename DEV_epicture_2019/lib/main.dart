import 'package:flutter/material.dart';
import './login/login.dart';
import './connectScreen/connectScreen.dart';
import './profile/profile.dart';
import './homeScreen/home.dart';
import './favoriteScreen/favoriteScreen.dart';

void main() => runApp(new MyApp());

class Data {
  String accessToken;
  String refreshToken;
  String accountUser;
  String clientId;
  Data({this.accessToken, this.refreshToken, this.accountUser, this.clientId});
}

class MyApp extends StatelessWidget {
  final data = Data(
    accessToken: "",
    refreshToken: "",
    accountUser: "",
    clientId: "c6f88ad89b3aa27",
  );
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ConnectScreen(),
        '/login': (context) => LoginScreen(
              data: data,
            ),
        '/acceuil': (context) => HomeScreen(
              data: data,
            ),
      },
    );
  }
}

// {data: {id: 115156547, url: tonio69, bio: null, avatar: https://imgur.com/user/tonio69/avatar?maxwidth=290, avatar_name: default/T, cover: https://imgur.com/user/tonio69/cover?maxwidth=2560, cover_name: default/1-space, reputation: 0, reputation_name: Neutral, created: 1570621593, pro_expiration: false, user_follow: {status: false}, is_blocked: false}, success: true, status: 200}

class HomeScreen extends StatefulWidget {
  final Data data;
  HomeScreen({this.data});
  @override
  _HomeScreenState createState() => new _HomeScreenState(
        data: data,
      );
}

class _HomeScreenState extends State<HomeScreen> {
  final Data data;
  _HomeScreenState({this.data});
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _searchQuery = new TextEditingController();
  final TextEditingController eCtrl = new TextEditingController();
  Widget appBarTitle = new Text(
    "Epicture",
    style: new TextStyle(color: Colors.white),
  );
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appBarTitle = new TextField(
                      controller: _searchQuery,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Recherche...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else
                    close_search();
                });
              })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.file_upload),
            title: Text('Upload'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoris'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            title: Text('Profil'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: new IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          new HomeFeed(
            data: data,
          ),
          new FavoriteScreen(
            data: data,
          ),
          new ProfileData(
            data: data,
          ),
          //new ProfileData(data:data,),
        ],
      ),
    );
  }

  void close_search() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Epicture",
        style: new TextStyle(color: Colors.white),
      );
      _searchQuery.clear();
    });
  }
}
// class WebViewInFlutter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: 'https://api.imgur.com/oauth2/authorize?client_id=0372e4d497e653b&response_type=token&state=salut',
//       hidden: true,
//       appBar: AppBar(title: Text("EPICTURE")),
//     );

//   }
// }
