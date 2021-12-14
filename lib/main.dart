import 'package:flutter/material.dart';
import 'package:testflutter/page/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: homepage(),);
  }

}

