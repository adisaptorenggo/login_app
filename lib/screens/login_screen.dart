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

  static const double _marginLogin = 40.0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentScope = FocusScope.of(context);
          FocusScopeNode rootScope =
              WidgetsBinding.instance.focusManager.rootScope;
          if (currentScope != rootScope) {
            currentScope.unfocus();
          }
          // FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Material(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/1.8,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Simple App'),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: _marginLogin, right: _marginLogin),
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) => previous.username != current.username,
                  builder: (context, state) {
                    return TextField(
                      key: const Key('loginForm_usernameInput_textField'),
                      onChanged: (username) =>
                          context.read<LoginBloc>().add(LoginUsernameChanged(username)),
                      decoration: InputDecoration(
                        labelText: 'username',
                        errorText: state.username.invalid ? 'invalid username' : null,
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: _marginLogin, right: _marginLogin),
                child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) => previous.password != current.password,
                  builder: (context, state) {
                    return TextField(
                      key: const Key('loginForm_passwordInput_textField'),
                      onChanged: (password) =>
                          context.read<LoginBloc>().add(LoginPasswordChanged(password)),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'password',
                        errorText: state.password.invalid ? 'invalid password' : null,
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: _marginLogin, right: _marginLogin),
                        child: BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) => previous.status != current.status,
                          builder: (context, state) {
                            return state.status.isSubmissionInProgress
                                ? const CircularProgressIndicator()
                                : RaisedButton(
                              key: const Key('loginForm_continue_raisedButton'),
                              child: const Text('Login'),
                              onPressed: state.status.isValidated
                                  ? ()
                              {
                                context.read<LoginBloc>().add(const LoginSubmitted());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                            create: (context) => ListUsersBloc(),
                                            child: HomeScreen())));
                              }
                                  : null,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
