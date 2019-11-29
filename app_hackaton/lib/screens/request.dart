// import 'package:flutter/material.dart';
// import 'package:image_picker_modern/image_picker_modern.dart';
// import '../main.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomeFeed extends StatefulWidget {
//   final Data data;
//   HomeFeed({this.data});
//   @override
//   _HomeFeedState createState() => _HomeFeedState(
//         data: data,
//       );
// }

// class _HomeFeedState extends State<HomeFeed> {
//   final Data data;
//   List<int> _image64;
//   var _image;
//   bool imageLoaded = false;
//   String _title = "";
//   String _desc = "";
//   bool isLoading = false;

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//       _image64 = image.readAsBytesSync();
//       imageLoaded = true;
//     });
//   }

//   uploadimage() async {
//     setState(() {
//       isLoading = true;
//     });
//     print(_image);
//     String imageB64 = base64Encode(_image64);
//     print(imageB64);
//     String form = '{"images_file=@fruitbowl.jpg", "threshold=0.6", "classifier_ids=CheckinCheckout_1358473836"}';
//     final response = await http.post(
//       'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19',
//       headers: {HttpHeaders.authorizationHeader: "apikey:{oEKGDuDT5A6gkCNjjksvoKD0dj5Xg-tJo9Ma7T1lwytO}"},
//       body: imageB64,
//     );
//     print(response.body);
//     print(_desc);
//     print(_title);
//     if (response.statusCode == 200) {
//       print(response.body);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   _HomeFeedState({this.data});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//             Colors.blue,
//             Colors.lightBlueAccent,
//           ]),
//         ),
//         child: Center(

//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(children: <Widget>[
//               Text(
//                 "Upload une image",
//                 style: TextStyle(fontSize: 30.0, color: Colors.white),
//               ),
//               new RaisedButton(
//                 child: new Text('CHOISIR UNE IMAGE'),
//                 textColor: Colors.black,
//                 color: Colors.white,
//                 shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(10.0),
//                 ),
//                 onPressed: getImage,
//               ),
//               imageLoaded != false ? new Image.file(_image) : Text(""),
//               new TextField(
//                 onChanged: (text) {
//                   _title = text;
//                 },
//                 decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(),
//                     hintText: 'Titre'),
//               ),
//               TextField(
//                 onChanged: (text) {
//                   _desc = text;
//                 },
//                 decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(),
//                     hintText: 'Description'),
//               ),
//               new RaisedButton(
//                 child: new Text('UPLOAD'),
//                 textColor: Colors.black,
//                 color: Colors.white,
//                 shape: new RoundedRectangleBorder(
//                   borderRadius: new BorderRadius.circular(10.0),
//                 ),
//                 onPressed: uploadimage,
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState(
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
    String form = '{"images_file=@nacelle.jpg", "threshold=0.6", "classifier_ids=CheckinCheckout_1358473836"}';
    final response = await http.post(
      'https://gateway.watsonplatform.net/visual-recognition/api/v3/classify?version=2018-03-19',
      headers: {HttpHeaders.authorizationHeader: "apikey:{oEKGDuDT5A6gkCNjjksvoKD0dj5Xg-tJo9Ma7T1lwytO}"},
      body: form,
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
