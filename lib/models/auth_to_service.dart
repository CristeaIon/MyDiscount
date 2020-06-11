import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServ with ChangeNotifier {

  Future<void> attemptSignIn(String displayName, String email, String userId,
      String photoUrl, String accessToken) async {
    String credentials = "appuser:frj936epae293e9c6epae29";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Authorization': 'Basic ' + encoded,
    };
    const url = 'http://api.efactura.md:8585/AppCardService/json/GetTID';
    final response = await http.post(url,
        headers: headers,
        body: json.encode({
          "DisplayName": displayName,
          "Email": email,
          "ID": userId,
          "PhotoUrl": photoUrl,
          "access_token": accessToken,
        }));
    print(response.body);
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('data', response.body);
   notifyListeners();
  } 
 
}
