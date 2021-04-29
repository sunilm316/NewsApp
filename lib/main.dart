import 'package:flutter/material.dart';
import 'package:newsappsunil/Screens/SplashScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'News live',
        home: new SplashScreen());
  }
}
