import 'package:flutter/material.dart';
import './screen/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
