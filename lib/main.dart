import 'dart:async';

import 'package:flutter/material.dart';
import 'package:victorapp/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Victor's Todo",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FadeIn();
}

class FadeIn extends State<SplashScreen> {
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;

  FadeIn() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _logoStyle = FlutterLogoStyle.horizontal;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      navigateHomePage(context);
    });
  }

  Future navigateHomePage(context) async {
    Navigator.push(
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
