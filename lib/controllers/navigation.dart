import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier{
  String screenName = '/';

  void changeSceen(String newScreenName){
    screenName = newScreenName;
    notifyListeners();
  }
}