import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Comment extends ConsumerStatefulWidget {
  final String bookId;
  const Comment({super.key, required this.bookId});

  @override
  ConsumerState<Comment> createState() => _CommentSection();
}

class _CommentSection extends ConsumerState<Comment> {
  final _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _fetchComments(),
            builder: (context, snapshot) {
              final comments = snapshot.data!.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    comments.map((doc) {
                      final data = doc.data();
                      return Text("${data['authorName']} ${data['comment']}");
                    }).toList(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Write your comment here",
                    ),
                    controller: _commentController,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final commentText = _commentController.text.trim();
                    final user = FirebaseAuth.instance.currentUser;
                    final userDoc =
                        await FirebaseFirestore.instance
                            .collection("user")
                            .doc(user!.uid)
                            .get();
                    final userData = userDoc.data();
                    final userName = userData!['name'];
                    if (commentText.isEmpty) return;

                    await FirebaseFirestore.instance
                        .collection("books")
                        .doc(widget.bookId)
                        .collection("comments")
                        .add({
                          "comment": commentText,
                          "createdAt": Timestamp.now(),
                          "authorId": user.uid,
                          "authorName": userName,
                        });
                    _commentController.clear();
                  },
                  icon: Icon(Icons.send_outlined),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _fetchComments() {
    return FirebaseFirestore.instance
        .collection("books")
        .doc(widget.bookId)
        .collection("comments")
        .snapshots();
  }
}
