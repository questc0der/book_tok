import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  final QueryDocumentSnapshot book;
  const MainView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final data = book.data() as Map<String, dynamic>;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                data['image'],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 3,
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
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(height: 55, width: 55, child: CircleAvatar()),
                    SizedBox(width: 4),
                    Column(
                      children: [
                        Text(
                          "User Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            minimumSize: WidgetStatePropertyAll(Size(70, 30)),
                          ),
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
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
                      style: ButtonStyle(
                        iconColor: WidgetStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(WidgetState.pressed)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        }),
                      ),
                    ),
                    Text("0"),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mode_comment),
                      style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(Colors.grey),
                      ),
                    ),
                    Text("0"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                data['content'],
                style: TextStyle(fontFamily: 'Circular'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
