import 'dart:async';

import 'package:flutter/material.dart';
import 'package:victorapp/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;

  _SplashScreenState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _logoStyle = FlutterLogoStyle.horizontal;
        timer.cancel();
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      navigateHomePage(context);
    });
  }

  Future navigateHomePage(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: new FlutterLogo(
              size: 200.0,
              style: _logoStyle,
            ),
          ),
        ),
      ),
    );
  }
}