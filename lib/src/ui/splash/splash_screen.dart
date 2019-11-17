import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wanderlust/src/blocs/LoginBloc.dart';
import 'package:wanderlust/src/models/user.dart';
import 'package:wanderlust/src/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginBloc bloc = new LoginBloc();

  @override
  initState() {
    super.initState();

    Timer(Duration(seconds: 2, milliseconds: 200), () async {
      bloc.authenticate();
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration splashAnimationDuration = Duration(seconds: 2, milliseconds: 100);

    return Scaffold(
      body: StreamBuilder(
        stream: bloc.authenticatedUser,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data.isActivatedUser) {
              Future.delayed(splashAnimationDuration, () {
              Navigator.pushReplacementNamed(context, Constants.of(context).homeRoute);
              });
            } else {
              Future.delayed(splashAnimationDuration, () {
              Navigator.pushReplacementNamed(context, Constants.of(context).authenticationRoute);
              });
            }
          }

          return new Container(
              color: Colors.white,
              child: Center(
                child: ScaleAnimatedTextKit(
                  duration: splashAnimationDuration,
                  isRepeatingAnimation: false,
                  text: [
                    Constants.of(context).appTitle,
                  ],
                  textStyle: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Lab"),
                ),
              )
          );
        },
      ),
    );
  }
}