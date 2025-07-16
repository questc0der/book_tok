import 'package:book_tok/component/explore.dart';
import 'package:book_tok/screen/book_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import '../screen/book_detail.dart';
import '../screen/post.dart';
import '../screen/profile.dart';
import '../screen/chat.dart';
import '../screen/main.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: AppBar(bottom: _buildTabBar()),
        body: TabBarView(children: [_buildVerticalPageView()]),
      ),
    );
  }

  // TabBar _buildTabBar() {
  //   return TabBar(tabs: [Tab(text: "For You"), Tab(text: "Following")]);
  // }

  StreamBuilder _buildVerticalPageView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('books').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final books = snapshot.data!.docs;
        return PageView.builder(
          controller: _buildPageController(),
          scrollDirection: Axis.vertical,
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return MainView(book: book);
          },
        );
      },
    );
  }

  // Widget _buildHorizontalView() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('books').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       final books = snapshot.data!.docs;

  //       return PageView.builder(
  //         controller: _buildPageController(),
  //         itemCount: books.length,
  //         itemBuilder: (context, index) {
  //           final book = books[index];
  //           return BookDetail(book: book);
  //         },
  //       );
  //     },
  //   );
  // }

  PageController _buildPageController() {
    final controller = PageController(initialPage: 0);
    return controller;
  }

  // void _showBottomSheet(BuildContext context, QueryDocumentSnapshot book) {
  //   showModalBottomSheet<void>(
  //     isScrollControlled: true,
  //     context: context,
  //     constraints: BoxConstraints(maxWidth: 480, maxHeight: 600),

  //     builder: (context) => BookDetail(book: book),
  //   );
  // }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;

  final pages = [HomeTabs(), ExploreView(), Post(), ChatPage(), Profile()];

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
