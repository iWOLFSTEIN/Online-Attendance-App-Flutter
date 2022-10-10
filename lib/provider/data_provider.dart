import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  bool _isClass = true;
  bool get isClass => _isClass;
  set isClass(bool value) {
    _isClass = value;
    notifyListeners();
  }
}
