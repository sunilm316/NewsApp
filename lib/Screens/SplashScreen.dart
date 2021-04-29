import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newsappsunil/Screens/NewsListScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    _isConnectedToInternet().then((isConnected) {
      if (!isConnected) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please check your network connection'),
          duration: Duration(seconds: 3),
        ));
      }else{
        startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
             "https://image.flaticon.com/icons/png/512/21/21601.png",
              height: 150,
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20,),
            new Text(
              "Version 0.0.1",
            ),
          ],
        ),
      ),
    ));
  }


  startTimer() async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => new NewsListScreen())));
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
