import 'package:flutter/material.dart';
import '../models/book.dart';

class PageViewCard extends StatelessWidget {
  final Book book;
  const PageViewCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  book.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(Icons.favorite_border_outlined, size: 30),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text(book.content),
            ),
          ],
        ),
      ),
    );
  }
}
