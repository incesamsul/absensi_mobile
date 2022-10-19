import 'package:absensi/loading.dart';
import 'package:absensi/screens/home.dart';
import 'package:absensi/screens/login.dart';
import 'package:absensi/screens/logs.dart';
import 'package:absensi/screens/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}
