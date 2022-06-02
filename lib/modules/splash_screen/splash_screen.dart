import 'dart:async';

import 'package:e_comarce/home/home_layout.dart';
import 'package:e_comarce/modules/login/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../shared/components/conistance.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 4),
        () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      uid != null ? HomeLayout() : LogIn()))
            });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 20.0,
                  right: 16.0,
                  left: 16.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Lottie.asset('assets/images/90690-shopping.json'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Loading",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SplashScreenBottomBg(),
        ],
      ),
    );
  }
}
