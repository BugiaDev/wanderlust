import 'package:flutter/material.dart';
import 'package:wanderlust/src/ui/authentication/authentication_screen.dart';
import 'package:wanderlust/src/ui/home/home_screen.dart';
import 'package:wanderlust/src/ui/splash/splash_screen.dart';
import 'package:wanderlust/src/utils/constants.dart';

void main() {
  runApp(Constants(
    child: wanderlust()
  ));
}

MaterialApp wanderlust() {
  return MaterialApp(
      title: 'Wanderlust',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        'authentication': (BuildContext context) => AuthenticationScreen(),
        'home': (BuildContext context) => HomeScreen(title: 'Wanderlust'),
      }
    );
}