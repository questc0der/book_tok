import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfilePage();
}

class _ProfilePage extends State<Profile> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100, width: 100, child: CircleAvatar()),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "User Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateColor.transparent,
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // spacing: 70.0,
            children: [
              Column(
                children: [
                  Text("Followers"),
                  Text("100", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text("Following"),
                  Text("100", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Text("Posts"),
                  Text("100", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(bottom: _buildTabBar()),
                body: TabBarView(
                  children: <Widget>[_postsView(), _bookMarkView()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PageView _postsView() {
    return PageView(
      controller: _buildPageController(),
      children: <Widget>[_buildCardGridForPosts()],
    );
  }

  PageView _bookMarkView() {
    return PageView(
      controller: _buildPageController(),
      children: <Widget>[_buildCardGridForBookMark()],
    );
  }

  PageController _buildPageController() {
    final controller = PageController(initialPage: 0);
    return controller;
  }

  TabBar _buildTabBar() {
    return TabBar(tabs: [Tab(text: 'Posts'), Tab(text: 'BookMark')]);
  }

  Future<List<Map<String, dynamic>>> fetchPostedBooks() async {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot =
        await db
            .collection('books')
            .where("email", isEqualTo: user!.email)
            .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Widget _buildCardGridForPosts() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPostedBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error ${snapshot.error}"));
        }

        final books = snapshot.data!;
        return GridView.builder(
          itemCount: books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final bookData = books[index];
            return Column(
              children: [
                Expanded(
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(bookData['image'], fit: BoxFit.fill),
                  ),
                ),
                Text(bookData['title']),
              ],
            );
          },
        );
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchBookMarkedBooks() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("bookmarks")
        .snapshots();
  }

  Widget _buildCardGridForBookMark() {
    return StreamBuilder<QuerySnapshot>(
      stream: fetchBookMarkedBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error ${snapshot.error}"));
        }
        final books = snapshot.data!.docs;
        return GridView.builder(
          itemCount: books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final bookData = books[index].data() as Map<String, dynamic>;
            return Column(
              children: [
                Expanded(
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(bookData['image'], fit: BoxFit.fill),
                  ),
                ),
                Text(bookData['title']),
              ],
            );
          },
        );
      },
    );
  }
}
