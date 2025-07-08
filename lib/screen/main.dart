import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';

class MainView extends StatelessWidget {
  final QueryDocumentSnapshot book;
  const MainView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final data = book.data() as Map<String, dynamic>;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            data['image'],
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(190),
                    offset: Offset(0, 9),
                    spreadRadius: 28,
                    blurRadius: 30,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Circular',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Author",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Circular',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
