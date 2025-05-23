import 'package:flutter/material.dart';
import '../component/page_view.dart';
import '../screen/book_detail.dart';
import '../screen/post.dart';
import '../screen/profile.dart';
import '../screen/explore.dart';
import '../screen/chat.dart';
import '../models/book.dart';
import '../screen/main.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(bottom: _buildTabBar()),
        body: TabBarView(
          children: [_buildVerticalPageView(), _buildHorizontalView()],
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(tabs: [Tab(text: "For You"), Tab(text: "Following")]);
  }

  PageView _buildVerticalPageView() {
    return PageView.builder(
      controller: _buildPageController(),
      scrollDirection: Axis.vertical,
      itemCount: books.length,
      itemBuilder:
          ((context, index) => GestureDetector(
            onTap:
                () => {
                  _showBottomSheet(context, index),
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => BookDetail(index: index),
                  //   ),
                  // ),
                },
            child: MainView(index: index),
          )),
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

  PageController _buildPageController() {
    final controller = PageController(initialPage: 0);
    return controller;
  }

  void _showBottomSheet(BuildContext context, index) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(maxWidth: 480, maxHeight: 600),

      builder: (context) => BookDetail(index: index),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;

  final pages = [
    HomeTabs(),
    ExplorePage(),
    PostPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  NavigationBar _buildBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (index) {
        setState(() {
          tab = index;
        });
      },
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
        NavigationDestination(icon: Icon(Icons.add), label: "Post"),
        NavigationDestination(icon: Icon(Icons.chat), label: "Inbox"),
        NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
