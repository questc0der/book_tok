import 'package:book_tok/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_input/image_input.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  final bool allowEdit = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDao = ref.watch(userDaoProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email Address',
                  ),
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  controller: _emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email Required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Password',
                  ),
                  autofocus: false,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  controller: _passwordController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Required';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final errorMessage = await userDao.login(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (errorMessage != null) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            duration: const Duration(milliseconds: 700),
                          ),
                        );
                      } else {
                        if (!mounted) return;
                        context.go('/home');
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final errorMessage = await userDao.signup(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 3700),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: ListView(
    //       // mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           "Create account",
    //           style: TextStyle(
    //             fontSize: 30,
    //             fontWeight: FontWeight.bold,
    //             fontFamily: 'Circular',
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //         SizedBox(height: 30),

    //         ProfileAvatar(
    //           image: ref.watch(userInfo).image,
    //           radius: 100,
    //           allowEdit: allowEdit,
    //           addImageIcon: Container(
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).colorScheme.primaryContainer,
    //               borderRadius: BorderRadius.circular(100),
    //             ),
    //             child: const Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Icon(Icons.add_a_photo),
    //             ),
    //           ),
    //           removeImageIcon: Container(
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).colorScheme.primaryContainer,
    //               borderRadius: BorderRadius.circular(100),
    //             ),
    //             child: const Padding(
    //               padding: EdgeInsets.all(8.0),
    //               child: Icon(Icons.close),
    //             ),
    //           ),
    //           onImageChanged:
    //               (XFile? image) => ref.read(userInfo).setImage(image),
    //           onImageRemoved: () {
    //             ref.read(userInfo).setImage(null);
    //           },
    //           getImageSource: () {
    //             return showDialog<ImageSource>(
    //               context: context,
    //               builder: (context) {
    //                 return SimpleDialog(
    //                   children: [
    //                     SimpleDialogOption(
    //                       child: const Text("Camera"),
    //                       onPressed: () {
    //                         Navigator.of(context).pop(ImageSource.camera);
    //                       },
    //                     ),
    //                     SimpleDialogOption(
    //                       child: const Text("Gallery"),
    //                       onPressed: () {
    //                         Navigator.of(context).pop(ImageSource.gallery);
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ).then((value) {
    //               return value ?? ImageSource.gallery;
    //             });
    //           },
    //           getPreferredCameraDevice: () {
    //             return showDialog<CameraDevice>(
    //               context: context,
    //               builder: (context) {
    //                 return SimpleDialog(
    //                   children: [
    //                     SimpleDialogOption(
    //                       child: const Text("Rear"),
    //                       onPressed: () {
    //                         Navigator.of(context).pop(CameraDevice.rear);
    //                       },
    //                     ),
    //                     SimpleDialogOption(
    //                       child: const Text("Front"),
    //                       onPressed: () {
    //                         Navigator.of(context).pop(CameraDevice.front);
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ).then((value) {
    //               return value ?? CameraDevice.rear;
    //             });
    //           },
    //         ),

    //         // Image.asset(width: 240, height: 240, "assets/pictures/reading.png"),
    //         SizedBox(height: 30),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: "Email",
    //             ),
    //             onChanged: (value) => ref.read(userInfo).setEmail(value),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: "User name",
    //             ),
    //             onChanged: (value) => ref.read(userInfo).setName(value),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextField(
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: "Age",
    //             ),
    //             onChanged: (value) => ref.read(userInfo).setAge(value),
    //           ),
    //         ),

    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextField(
    //             obscureText: true,
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: "Password",
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: TextField(
    //             obscureText: true,
    //             decoration: InputDecoration(
    //               border: OutlineInputBorder(),
    //               hintText: "Confirm password",
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 20),

    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(builder: (context) => const Preview()),
    //             );
    //           },
    //           style: TextButton.styleFrom(
    //             minimumSize: Size(420, 50),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //             ),
    //             backgroundColor: Colors.black,
    //             foregroundColor: Colors.white,
    //           ),
    //           child: Text(
    //             "Create account",
    //             style: TextStyle(fontFamily: 'Circular'),
    //           ),
    //         ),
    //         SizedBox(height: 100),

    //         Padding(
    //           padding: const EdgeInsets.only(top: 8.0, left: 60.0, right: 60.0),
    //           child: Text(
    //             "By creating an account or engaging you agree to our Terms and Conditions",
    //             style: TextStyle(fontFamily: 'Circular'),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  // }
// }
