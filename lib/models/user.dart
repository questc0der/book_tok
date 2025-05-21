import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class User extends ChangeNotifier {
  XFile? image;
  String name;
  String email;
  String gender;
  String age;
  String? password;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    this.image,
  });

  XFile? getImage() {
    return image;
  }

  void setImage(XFile? image) {
    this.image = image;
    notifyListeners();
  }

  String getName() {
    return name;
  }

  void setName(String userName) {
    name = userName;
    notifyListeners();
  }

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  String getAge() {
    return age;
  }

  void setAge(String age) {
    this.age = age;
  }

  String getGender() {
    return gender;
  }

  void setGender(String gender) {
    this.gender = gender;
  }
}
