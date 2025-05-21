import 'package:flutter_riverpod/flutter_riverpod.dart';
import "./models/user.dart";

final name = StateProvider<String>((ref) {
  return "Biruk in River";
});

final userInfo = ChangeNotifierProvider<User>((ref) {
  return User(name: "", email: "", age: "", gender: "", image: null);
});
