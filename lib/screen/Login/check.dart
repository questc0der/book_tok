import 'package:book_tok/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class Preview extends ConsumerWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          ClipOval(
            child: Image.file(
              File(ref.watch(userInfo).getImage()!.path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Text(ref.watch(userInfo).getName()),
          Text(ref.watch(userInfo).getEmail()),
          Text(ref.watch(userInfo).getAge()),
          Text(ref.watch(userInfo).getGender()),
        ],
      ),
    );
  }
}
