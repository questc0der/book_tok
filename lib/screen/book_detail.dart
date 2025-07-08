import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../component/page_view.dart';
import '../models/book.dart';

class BookDetail extends StatelessWidget {
  final QueryDocumentSnapshot book;
  const BookDetail({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    final data = book.data() as Map<String, dynamic>;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(child: PageViewCard(book: data)),
      ),
    );
  }
}
