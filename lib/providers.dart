import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/user_dao.dart';
import 'models/book_dao.dart';

final userDaoProvider = ChangeNotifierProvider<UserDao>((ref) {
  return UserDao();
});

final postDaoProvider = ChangeNotifierProvider<BookDao>((ref) {
  return BookDao();
});
