import 'package:book_tok/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_input/image_input.dart';
import './check.dart';

typedef GenderEntry = DropdownMenuEntry<Genders>;

enum Genders {
  male('Male', 'male'),
  female('Female', 'female');

  const Genders(this.label, this.value);
  final String label;
  final String value;

  static final List<GenderEntry> entries =
      values
          .map<GenderEntry>(
            (Genders gender) => GenderEntry(value: gender, label: gender.label),
          )
          .toList();
}

class SignUp extends ConsumerWidget {
  const SignUp({super.key});
  final bool allowEdit = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create account",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Circular',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            ProfileAvatar(
              image: ref.watch(userInfo).image,
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
              onImageChanged:
                  (XFile? image) => ref.read(userInfo).setImage(image),
              onImageRemoved: () {
                ref.read(userInfo).setImage(null);
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
                onChanged: (value) => ref.read(userInfo).setEmail(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "User name",
                ),
                onChanged: (value) => ref.read(userInfo).setName(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Age",
                ),
                onChanged: (value) => ref.read(userInfo).setAge(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownMenu<Genders>(
                label: const Text("Gender"),
                dropdownMenuEntries: Genders.entries,
                onSelected:
                    (value) => ref.read(userInfo).setGender(value!.name),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Preview()),
                );
              },
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
