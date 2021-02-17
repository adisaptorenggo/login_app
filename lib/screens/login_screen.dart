import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/home/list_users_bloc.dart';
import 'package:login_app/bloc/login/login_bloc.dart';
import 'package:login_app/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (
        BuildContext context,
        LoginState loginState,
      ) {
        if (_loginSucceeded(loginState)) {
          _bloc.add(LoggedIn());
          _onWidgetDidBuild(() {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => ListUsersBloc(),
                    child: HomeScreen(),
                  );
                },
              ),
            );
          });
        }

        if (_loginFailed(loginState)) {
          _onWidgetDidBuild(() {
            showAlertDialog(context);
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: _form(loginState),
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Login Failed"),
      content: Text("Authentication Failed"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _form(LoginState loginState) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'username'),
            controller: _usernameController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'password'),
            controller: _passwordController,
            obscureText: true,
          ),
          RaisedButton(
            onPressed:
                loginState.isLoginButtonEnabled ? _onLoginButtonPressed : null,
            child: Text('Login'),
          ),
          Container(
            child: loginState.isLoading ? CircularProgressIndicator() : null,
          ),
        ],
      ),
    );
  }

  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;
  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _bloc.add(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }
}
