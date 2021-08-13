import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreenModel extends ChangeNotifier{

  bool isLoading = false;

  void loadingScreen() {
    isLoading = !isLoading;
    notifyListeners();
  }
}