import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(bottom: _buildTabBar()),
        body: _buildTabBarView(),
      ),
    );
  }

  PageView _buildVerticalPageView() {
    return PageView(
      controller: _buildPageController(),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(color: Colors.green),
        Container(color: Colors.yellow),
        Container(color: Colors.red),
      ],
    );
  }

  PageView _buildHorizontalView() {
    return PageView(
      controller: _buildPageController(),
      children: <Widget>[
        Container(color: Colors.green),
        Container(color: Colors.yellow),
        Container(color: Colors.red),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(tabs: [Tab(text: "For You"), Tab(text: "Following")]);
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      children: [_buildVerticalPageView(), _buildHorizontalView()],
    );
  }

  PageController _buildPageController() {
    final controller = PageController(initialPage: 0);
    return controller;
  }
}
