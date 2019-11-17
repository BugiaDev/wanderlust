import 'package:flutter/material.dart';
import 'package:wanderlust/src/ui/themes/themes.dart';

class Separator extends StatelessWidget {
  const Separator({Key key, this.height}) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class MainTitle extends StatelessWidget {
  const MainTitle({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: "FuturaStd",
            fontSize: 22.0,
            color: WanderlustColors.darkLoginColor),
      ),
    );
  }
}