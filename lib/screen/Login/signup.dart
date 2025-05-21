import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(width: 240, height: 240, "assets/pictures/reading.png"),
            SizedBox(height: 30),
            Text(
              "Create account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirm password",
                ),
              ),
            ),
            SizedBox(height: 20),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size(420, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text(
                "Create account",
                style: TextStyle(fontFamily: 'Circular'),
              ),
            ),
            SizedBox(height: 100),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 60.0, right: 60.0),
              child: Text(
                "By creating an account or engaging you agree to our Terms and Conditions",
                style: TextStyle(fontFamily: 'Circular'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
