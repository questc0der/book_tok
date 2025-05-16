import 'package:flutter/material.dart';
import '../component/page_view.dart';
import '../models/book.dart';

class BookDetail extends StatelessWidget {
  final int index;
  const BookDetail({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: SingleChildScrollView(child: PageViewCard(book: books[index])),
      ),
    );
  }
}
