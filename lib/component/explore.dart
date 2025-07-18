import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explore")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildSlideView(),
            SizedBox(height: 350, child: _buildViewCard()),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Trending Posts",
                  style: TextStyle(fontFamily: 'Circular', fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildCollectionsView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            padding: WidgetStatePropertyAll(
              EdgeInsetsDirectional.symmetric(horizontal: 20),
            ),
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: Icon(Icons.search),
          );
        },
        suggestionsBuilder: (
          BuildContext context,
          SearchController controller,
        ) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchBooks() async {
    final db = FirebaseFirestore.instance;
    final querySnapshot = await db.collection('books').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Widget _buildViewCard() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final books = snapshot.data!;
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => SizedBox(width: 12),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final bookData = books[index];

            return SizedBox(
              height: 330,
              width: 290,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      bookData['image'],
                      fit: BoxFit.cover,
                      height: 330,
                      width: 290,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 17,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(100),
                            offset: Offset(0, -1),
                            spreadRadius: 2,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookData['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Circular',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            bookData['author'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Circular',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSlideView() {
    final categories = [
      "Trending",
      "History",
      "Adventure",
      "Comic",
      "Romance",
      "Sci-Fi",
      "Mystery",
      "Horror",
    ];

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(
              categories[index],
              style: TextStyle(fontFamily: 'Circular'),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            backgroundColor: Colors.grey.shade200,
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchTrendingBooks() async {
    final db = FirebaseFirestore.instance;
    final booksSnapshot = await db.collection("books").get();

    List<Map<String, dynamic>> trendingBooks = [];

    for (var bookDoc in booksSnapshot.docs) {
      final bookId = bookDoc.id;
      final bookData = bookDoc.data();

      final likesSnapshot =
          await db.collection("books").doc(bookId).collection("likes").get();

      final likesCount = likesSnapshot.docs.length;

      trendingBooks.add({
        'bookId': bookId,
        'bookData': bookData,
        'likesCount': likesCount,
      });
    }
    trendingBooks.sort((a, b) => b['likesCount'].compareTo(a['likesCount']));
    return trendingBooks;
  }

  Widget _buildCollectionsView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchTrendingBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("$snapshot.error"));
        }
        final trending = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: trending.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final trend = trending[index];
            final bookData = trend['bookData'] as Map<String, dynamic>;
            return Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),

                    child: Image.network(
                      "${bookData['image']}",
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "${bookData['title']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
