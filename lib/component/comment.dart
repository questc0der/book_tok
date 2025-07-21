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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No comments yet"));
              }
              final comments = snapshot.data!.docs;
              return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final data = comments[index].data();
                  return _buildCommentView(data['authorName'], data['comment']);
                },
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
                            .collection("users")
                            .doc(user!.uid)
                            .get();
                    final userData = userDoc.data();
                    final userName = userData?['name'];
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

  Widget _buildCommentView(String authorName, String comment) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          CircleAvatar(radius: 20),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(authorName, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(comment),
            ],
          ),
        ],
      ),
    );
  }
}
