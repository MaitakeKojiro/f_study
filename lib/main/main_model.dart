import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String maiText = 'Maitake';

  void changeMaiText() {
    maiText = 'Maitakeさんかっこいい';
    notifyListeners();
  }
}
