import 'package:flutter/material.dart';

class NowPlaying extends ChangeNotifier {
  String id;
  String url;

  NowPlaying({this.id = "1", this.url = ""});

  String get getId {
    return id;
  }

  String get getUrl {
    return url;
  }

  void setId(String id) {
    this.id = id;
    notifyListeners();
  }

  setUrl(String url) {
    this.url = url;
    notifyListeners();
  }
}
