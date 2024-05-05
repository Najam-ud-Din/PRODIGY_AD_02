import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/Pages/signuppage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "ToDo App",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 3),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage('images/todo.png'),
        ),
      )),
    );
  }
}
