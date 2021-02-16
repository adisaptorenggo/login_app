import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart';

Future<String> sendAuthenticationMessage(String email, String password) {
  String url = 'https://reqres.in/api/login';
  Map<String, dynamic> jsonData = {
    'email' : email,
    'password': password,
  };

  return sendMessage(url, jsonData);
}

Future<String> sendMessage(String url, Map<String, dynamic> jsonData) async{
  String messageBody = jsonEncode(jsonData);
  Response response = await httpPostAutoFullResponse(url, messageBody);
  if (response != null){
    return response.body;
  }else {
    return '';
  }
}

Future<Response> httpPostAutoFullResponse(String url, String body) async {
  return httpPostFullResponse(url, body, createHeader());
}

Map<String, String> createHeader(){
  Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json"};
  return headers;
}

Future<Response> httpPostFullResponse(String url, String body, Map<String, String> headers) async {
  print('HTTP POST Url : $url');
  for (String keys in headers.keys){
    print('HTTP Header : $keys - ${headers[keys]}');
  }
  print('HTTP POST Body : $body');
  try{
    Response response = await post(url, headers: headers, body: body).timeout(const Duration(seconds: 30));
    int statusCode = response.statusCode;
    print('HTTP POST Status Code : $statusCode');
    return response;
  }catch(e, s){
    print("The exception thrown is $e");
    print("STACK TRACE \n $s");
  }

  return null;
}