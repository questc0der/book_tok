import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookDao extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  Future<String> post(
    String title,
    String content,
    String author,
    String imageLink,
    String uid,
    String email,
    String postedBy,
  ) async {
    try {
      DocumentReference docRef = await db.collection('books').add({
        'title': title,
        'content': content,
        'author': author,
        'image': imageLink,
        'uid': uid,
        'email': email,
        'postedBy': postedBy,
      });
      return docRef.id;
    } catch (e) {
      print(e);
    }
    return "Error";
  }
}
