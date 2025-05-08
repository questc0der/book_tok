import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [Tab(text: "For You"), Tab(text: "Following")],
            ),
          ),
          body: TabBarView(
            children: [
              PageView(
                controller: controller,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(color: Colors.green),
                  Container(color: Colors.yellow),
                  Container(color: Colors.red),
                ],
              ),
              PageView(
                controller: controller,
                children: <Widget>[
                  Container(color: Colors.green),
                  Container(color: Colors.yellow),
                  Container(color: Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
