import 'package:flutter/material.dart';

import 'main.dart';


class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => DetailScreen());
      case secondScreenRoute:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text('Ters giden birşeyler oldu'),
                ),
              ),
        );
    }
  }
}

const String homeRoute = '/';
const String secondScreenRoute = '/secondScreen';