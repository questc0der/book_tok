import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  XFile? profileAvatarCurrentImage;
  bool allowEdit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create account",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Circular',
            ),
          ),
          SizedBox(height: 30),

          ProfileAvatar(
            image: profileAvatarCurrentImage,
            radius: 100,
            allowEdit: allowEdit,
            addImageIcon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add_a_photo),
              ),
            ),
            removeImageIcon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            ),
            onImageChanged: (XFile? image) {
              setState(() {
                profileAvatarCurrentImage = image;
              });
            },
            onImageRemoved: () {
              setState(() {
                profileAvatarCurrentImage = null;
              });
            },
            getImageSource: () {
              return showDialog<ImageSource>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      SimpleDialogOption(
                        child: const Text("Camera"),
                        onPressed: () {
                          Navigator.of(context).pop(ImageSource.camera);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text("Gallery"),
                        onPressed: () {
                          Navigator.of(context).pop(ImageSource.gallery);
                        },
                      ),
                    ],
                  );
                },
              ).then((value) {
                return value ?? ImageSource.gallery;
              });
            },
            getPreferredCameraDevice: () {
              return showDialog<CameraDevice>(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      SimpleDialogOption(
                        child: const Text("Rear"),
                        onPressed: () {
                          Navigator.of(context).pop(CameraDevice.rear);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text("Front"),
                        onPressed: () {
                          Navigator.of(context).pop(CameraDevice.front);
                        },
                      ),
                    ],
                  );
                },
              ).then((value) {
                return value ?? CameraDevice.rear;
              });
            },
          ),

          // Image.asset(width: 240, height: 240, "assets/pictures/reading.png"),
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
    );
  }
}
