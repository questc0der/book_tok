import 'package:book_tok/providers.dart';
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
