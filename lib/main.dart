import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cap_3/class/stateful';
import 'package:cap_3/class/homePage.dart';
import 'package:cap_3/class/timer.dart';
void main() {
  
  runApp( MyApp());
  
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TimerHomePage() //MyHomePage(title:"cap3") 
    );
  }
}
