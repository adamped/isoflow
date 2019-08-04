import '../framework/base.dart';
import 'package:flutter/material.dart';

Navigation instance;

class Navigation extends Base<_NavigationModel, String> {
  Navigation(BuildContext context)
      : super(
            initial: _NavigationModel(null),
            update: state,
            platform: platform,
            connector: (request) {
              connector(request, context);
            });
}

_NavigationModel state(_NavigationModel model, Message message) {
  if (message is LoginSuccess) return _NavigationModel('/dashboard');
  return _NavigationModel(null);
}

String platform(_NavigationModel model, Send send) {
  if (model.route != null) return model.route;

  return null;
}

void connector(String request, BuildContext context) {
  if (request == null) return;
  Navigator.pushNamed(context, request);
}

@immutable
class _NavigationModel {
  const _NavigationModel(this.route);
  final String route;
}

class LoginSuccess extends Message {}
