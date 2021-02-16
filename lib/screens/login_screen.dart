import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static const double _marginLogin = 40.0;
  static const double _imageWidth = 120.0;
  static const double _imageHeight = 180.0;

  var _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: _marginLogin, right: _marginLogin),
                        child: RaisedButton(
                          child: Text('Log in'),
                          elevation: 5,
                          color: Colors.white,
                          textColor: Colors.blue,
                          onPressed: () => null,
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
