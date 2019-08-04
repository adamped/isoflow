import 'package:flutter/material.dart';
import 'login/view.dart';
import 'dashboard/view.dart';
import 'services/navigation.dart' as navigation;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) { navigation.instance = new navigation.Navigation(context); return LoginView(); },
        '/dashboard': (context) => DashboardView(),
      }
    );
  }
}