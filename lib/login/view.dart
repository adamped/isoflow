import 'package:flutter/material.dart';
import '../framework/view.dart';
import '../framework/base.dart';
import 'view.logic.dart' as logic;

class LoginView extends View<_LoginModel>{
  LoginView({Key key})
      : super(
            initial:
                _LoginModel(username: '', isLoggingIn: false),
            update: update,
            view: view) {
    logic.flow(this);
  }
}

@immutable
class _LoginModel {
  const _LoginModel({this.username, this.isLoggingIn});
  final String username;
  final bool isLoggingIn;
}

_LoginModel update(BuildContext context, Message msg, _LoginModel model) {  
  if (msg is LoginMessage)
    return _LoginModel(username: msg.username, isLoggingIn: true);

  if (msg is LoginResult)
    if (msg.success)
      return _LoginModel(username: '', isLoggingIn: false);

  return model;
}

Widget view(_LoginModel model, Send send) {
  var usernameController = new TextEditingController(text: model.username);
  var passwordController = new TextEditingController(text: '');

  return SafeArea(
      child: Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Username:'),
          TextField(controller: usernameController),
          Text('Password:'),
          TextField(
            controller: passwordController,
            obscureText: true,
          ),
          model.isLoggingIn
              ? new CircularProgressIndicator()
              : FlatButton(
                  child: Text('Login'),
                  onPressed: () => send(LoginMessage(
                      username: usernameController.text,
                      password: passwordController.text)),
                )
        ],
      ),
    ),
  ));
}

@immutable
class LoginMessage implements Message {
  const LoginMessage({this.username, this.password});
  final String username;
  final String password;
}

@immutable
class LoginResult implements Message {
  const LoginResult({this.success});
  final bool success;
}
