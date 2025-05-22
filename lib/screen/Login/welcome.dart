import 'package:book_tok/screen/Login/signup.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(width: 340, height: 340, "assets/pictures/reading.png"),
            SizedBox(height: 30),
            Text(
              "Welcome To Book Tok",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 70.0, right: 70.0),
              child: Text(
                "Now your finances are in one place and always under control",
                style: TextStyle(fontFamily: "Circular"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size(340, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text("Sign in", style: TextStyle(fontFamily: 'Circular')),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => const SignUp()));
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black, width: 2.0),
                minimumSize: Size(340, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              child: Text(
                "Create account",
                style: TextStyle(fontFamily: 'Circular', color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
