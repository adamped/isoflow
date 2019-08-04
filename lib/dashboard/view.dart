import 'package:flutter/material.dart';
import '../framework/view.dart';
import '../framework/base.dart';

class DashboardView extends View<_DashboardModel>{
  DashboardView({Key key})
      : super(
            initial:
                _DashboardModel(),
            update: update,
            view: view);
}

@immutable
class _DashboardModel {
  const _DashboardModel();
}

_DashboardModel update(BuildContext context, Message msg, _DashboardModel model) {
  return model;
}

Widget view(_DashboardModel model, Send send) { 
  return SafeArea(
      child: Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Howdy!')
        ],
      ),
    ),
  ));
}
