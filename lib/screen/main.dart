import 'package:flutter/material.dart';
import '../models/book.dart';

class MainView extends StatelessWidget {
  final int index;
  const MainView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            books[index].image,
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          // This Container holds the shadow and text
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.black,
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
                    books[index].title,
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
