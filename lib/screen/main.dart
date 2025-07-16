import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  final QueryDocumentSnapshot book;
  const MainView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final data = book.data() as Map<String, dynamic>;

    // Split content into pages
    List<String> paginateContent(String content, int charsPerPage) {
      List<String> pages = [];
      for (int i = 0; i < content.length; i += charsPerPage) {
        pages.add(
          content.substring(
            i,
            (i + charsPerPage > content.length)
                ? content.length
                : i + charsPerPage,
          ),
        );
      }
      return pages;
    }

    final contentPages = paginateContent(data['content'], 800);

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1 + contentPages.length, // 1 for post + N pages
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      data['image'],
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2.2,
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              offset: Offset(0, -3),
                              spreadRadius: 10,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Circular',
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data['author'],
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(radius: 27.5),
                          SizedBox(width: 4),
                          Column(
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(70, 30),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                ),
                                child: Text(
                                  "Follow",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                            color: Colors.grey,
                          ),
                          Text("0"),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.mode_comment),
                            color: Colors.grey,
                          ),
                          Text("0"),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      contentPages[0],
                      style: TextStyle(fontFamily: 'Circular', fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 9,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Page 2...N: reading pages only
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SingleChildScrollView(
                child: Text(
                  contentPages[index - 1],
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    fontFamily: 'Circular',
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
