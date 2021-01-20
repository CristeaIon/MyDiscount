import 'package:flutter/material.dart';

import '../services/shared_preferences_service.dart';

class NewsSettings with ChangeNotifier {
  final SharedPref _prefs = SharedPref();
  bool _isActivate = true;

  bool get isActivate => _isActivate;

  set isActivate(bool value) {
    _isActivate = value;
    _saveNewsState();
    notifyListeners();
  }

  NewsSettings() {
    
    getNewsState();

    notifyListeners();
  }
  _saveNewsState() async {
    _prefs.saveNewsState(_isActivate);
    notifyListeners();
  }

  getNewsState() async {
    final data = await _prefs.instance;
    if (data.containsKey('newsState'))
      _isActivate = await _prefs.readNewsState();
    
    notifyListeners();
    return _isActivate;
  }
}