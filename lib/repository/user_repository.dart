import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class UserRepository {
  Future<List<UserModel>> getUsers({int page}) async {
    print('getUsers');
    final response = await http.get(
        "https://reqres.in/api/users?page=$page");
    if (response.statusCode == 200) {
      print('data:' + json.decode(response.body)['data'].toString());
      return userModelFromJson(response.body);
    }
    throw Exception('error fetching posts');
  }
}
