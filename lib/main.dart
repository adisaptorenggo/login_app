import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/home/list_users_bloc.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/login_screen.dart';

import 'bloc/login/login_bloc.dart';

void main() {
  print('Run App');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginScreen()
      ),
    );
  }
}
