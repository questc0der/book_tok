import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/user_dao.dart';

final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import "./models/user.dart";

// final userInfo = ChangeNotifierProvider<User>((ref) {
//   return User(name: "", email: "", age: "", gender: "", image: null);
// });
