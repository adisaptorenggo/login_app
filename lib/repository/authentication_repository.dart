import 'dart:async';
import 'dart:convert';

import 'package:login_app/repository/message_authentication.dart';
import 'package:meta/meta.dart';

class AuthenticationRepository {
  Future sendAuthentication({String username, String password}) async {
    print('sendAuthentication');
    var response = await sendAuthenticationMessage(username, password);
    Map<String, dynamic> jsonData = jsonDecode(response);
    print(jsonData.toString());
    if (isSuccess(jsonData)) {
      return jsonData['token'];
    } else {
      print('failed1');
      throw Exception();
    }
  }

  bool isSuccess(Map<String, dynamic> jsonData) {
    return jsonData.toString().startsWith('{token: ');
  }
}
