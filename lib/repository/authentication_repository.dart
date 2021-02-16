import 'dart:async';
import 'dart:convert';

import 'package:login_app/bloc/message.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    var response = await sendAuthenticationMessage(username, password);
    Map<String, dynamic> jsonData = jsonDecode(response);
    if (isSuccess(jsonData)){
      _controller.add(AuthenticationStatus.authenticated);
    }else{
      throw Exception();
    }



    // await Future.delayed(
    //   const Duration(milliseconds: 300), () {
    //     _controller.add(AuthenticationStatus.authenticated);
    //   }
    // );
  }

  bool isSuccess(Map<String, dynamic> jsonData){
    int respCode = jsonData['response_code'];
    return respCode.toString() == '0';
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
