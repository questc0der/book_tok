import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      right: 0,
                      top: 0,
                      child: StreamBuilder<DocumentSnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("bookmarks")
                                .doc(book.id)
                                .snapshots(),
                        builder: (context, snapshot) {
                          bool isBookMarked = snapshot.data?.exists ?? false;

                          return IconButton(
                            icon: Icon(
                              Icons.bookmark_rounded,
                              color: isBookMarked ? Colors.red : Colors.grey,
                            ),
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user == null) {
                                print("Error: No user is currently logged in.");
                                // Maybe show a SnackBar or navigate to login screen
                                return; // Stop execution if no user
                              }

                              final userId = user.uid;
                              final bookMarkDocRef = FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userId) // Using the safe userId
                                  .collection("bookmarks")
                                  .doc(book.id);

                              if (isBookMarked) {
                                await bookMarkDocRef.delete();
                              } else {
                                print(
                                  "Current user ID being used for bookmark: $userId",
                                ); // Detailed print
                                print("Bookmarking book ID: ${book.id}");

                                await bookMarkDocRef.set({
                                  "title": book['title'],
                                  "author": book['author'],
                                  "image": book['image'],
                                  "bookmarkedAt": FieldValue.serverTimestamp(),
                                });
                                print(
                                  "Bookmark added successfully for user $userId to book ${book.id}",
                                );
                              }
                            },
                          );
                        },
                      ),
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
                                data["postedBy"],
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                stream:
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                        )
                                        .collection("following")
                                        .doc(data['uid'])
                                        .snapshots(),
                                builder: (context, snapshot) {
                                  final isFollowing =
                                      snapshot.data?.exists ?? false;

                                  return ElevatedButton(
                                    onPressed: () async {
                                      final currentUserUid =
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid;
                                      final creatorUid = data['uid'];

                                      final followingRef = FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(currentUserUid)
                                          .collection("following")
                                          .doc(creatorUid);

                                      final followersRef = FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(creatorUid)
                                          .collection("followers")
                                          .doc(currentUserUid);

                                      final docSnapshot =
                                          await followingRef.get();

                                      if (docSnapshot.exists) {
                                        await followingRef.delete();
                                        await followersRef.delete();
                                        print("Unfollowed $creatorUid");
                                      } else {
                                        await followingRef.set({
                                          "followedAt":
                                              FieldValue.serverTimestamp(),
                                        });
                                        await followersRef.set({
                                          "followedAt":
                                              FieldValue.serverTimestamp(),
                                        });
                                        print("Followed $creatorUid");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(70, 30),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      isFollowing ? "Following" : "Follow",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                            stream:
                                FirebaseFirestore.instance
                                    .collection("books")
                                    .doc(book.id)
                                    .collection("likes")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                            builder: (context, snapshot) {
                              final isLiked = snapshot.data?.exists ?? false;

                              return IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: isLiked ? Colors.red : Colors.grey,
                                ),
                                onPressed: () async {
                                  final likeDocRef = FirebaseFirestore.instance
                                      .collection("books")
                                      .doc(book.id)
                                      .collection("likes")
                                      .doc(
                                        FirebaseAuth.instance.currentUser!.uid,
                                      );

                                  if (isLiked) {
                                    await likeDocRef.delete();
                                  } else {
                                    await likeDocRef.set({
                                      "likedAt": FieldValue.serverTimestamp(),
                                    });
                                  }
                                },
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream:
                                FirebaseFirestore.instance
                                    .collection('books')
                                    .doc(book.id)
                                    .collection("likes")
                                    .snapshots(),
                            builder: (context, likeSnapshot) {
                              if (likeSnapshot.hasData) {
                                return Text(
                                  "${likeSnapshot.data!.docs.length}",
                                );
                              } else {
                                return Text("0");
                              }
                            },
                          ),
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
              child: Text(
                contentPages[index - 1],
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontFamily: 'Circular',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
