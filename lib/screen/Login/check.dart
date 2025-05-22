import 'package:book_tok/providers.dart';
import 'package:book_tok/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class Preview extends ConsumerWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Card(
          shape: BeveledRectangleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.file(
                    File(ref.watch(userInfo).getImage()!.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ref.watch(userInfo).getName(),
                      style: TextStyle(fontFamily: 'Circular', fontSize: 20),
                    ),
                    Text(
                      ref.watch(userInfo).getEmail(),
                      style: TextStyle(fontFamily: 'Circular'),
                    ),
                    Text(
                      ref.watch(userInfo).getAge(),
                      style: TextStyle(fontFamily: 'Circular'),
                    ),
                    Text(
                      ref.watch(userInfo).getGender(),
                      style: TextStyle(fontFamily: 'Circular'),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(120, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Done", style: TextStyle(fontFamily: 'Circular')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
