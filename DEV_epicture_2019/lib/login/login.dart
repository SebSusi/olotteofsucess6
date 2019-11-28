import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:my_app/main.dart';

class LoginScreen extends StatefulWidget {
  final Data data;
  LoginScreen({this.data});
  @override
  _LoginScreenState createState() => new _LoginScreenState(data:data,);
}

class _LoginScreenState extends State<LoginScreen> {
  final Data data;
  _LoginScreenState({this.data});
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
    @override
    void initState() {
    super.initState();

    flutterWebviewPlugin.close();
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (data.refreshToken != "")
        flutterWebviewPlugin.close();

    });

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          if (url.startsWith("https://app.getpostman.com/oauth2/callback")) {
            RegExp regExp = new RegExp("#access_token=([a-zA-Z0-9_]*)");
            data.accessToken = regExp.firstMatch(url)?.group(1);
            print(data.accessToken);
            regExp = new RegExp("refresh_token=([a-zA-Z0-9_]*)");
            data.refreshToken = regExp.firstMatch(url)?.group(1);
            regExp = new RegExp("account_username=([a-zA-Z0-9_]*)");
            print(data.accessToken);
            data.accountUser = regExp.firstMatch(url)?.group(1);
            flutterWebviewPlugin.close();
            flutterWebviewPlugin.dispose();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/acceuil');
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String loginUrl = "https://api.imgur.com/oauth2/authorize?client_id=${data.clientId}&response_type=token";
    return WebviewScaffold(
      url: loginUrl,
      hidden: true,
      appBar: AppBar(title: Text("Connectez-vous à ImGur")),
    );
  }
}




