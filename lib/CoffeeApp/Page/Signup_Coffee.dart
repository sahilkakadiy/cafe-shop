// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'Homepage_Coffee.dart';
// import 'Login_Coffee.dart';
//
// class Signup extends StatefulWidget {
//   const Signup({super.key});
//
//   @override
//   State<Signup> createState() => _SignupState();
// }
//
// class _SignupState extends State<Signup> {
//
//   // //final _formKey = GlobalKey<FormState>();
//   // final FirebaseAuth auth = FirebaseAuth.instance;
//   // final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   //
//   TextEditingController NameController = TextEditingController();
//   TextEditingController UsernameController = TextEditingController();
//   TextEditingController EmailController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//
//   // TextEditingController emailController = TextEditingController();
//   // TextEditingController passwordController = TextEditingController();
//   // TextEditingController cPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7RUWeEmgtRlQTzwXSzQrqfed-HEF5Pn3iZ64kP9lrVacrj1ySTswbX4hXCCw4R15EcMo&usqp=CAU'
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // 3D login card
//           Center(
//             child: Container(
//               height: 450,
//               width: 350,
//               decoration: BoxDecoration(
//                 color: Colors.black12,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.white54.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 15,
//                       blurStyle: BlurStyle.outer
//                     //offset: Offset(10, 10),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: NameController,
//                         decoration: InputDecoration(
//                             labelText: 'Name',
//                             labelStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w100,
//                                 fontSize: 15),
//                             focusColor: Colors.black,
//                             fillColor: Colors.black,
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20)),
//                                 borderSide: BorderSide(color: Colors.white38),
//                                 gapPadding: 10),
//                             border: UnderlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                             hoverColor: Colors.black),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: UsernameController,
//                         decoration: InputDecoration(
//                             labelText: 'Username',
//                             labelStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w100,
//                                 fontSize: 15),
//                             focusColor: Colors.black,
//                             fillColor: Colors.black,
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20)),
//                                 borderSide: BorderSide(color: Colors.white38),
//                                 gapPadding: 10),
//                             border: UnderlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                             hoverColor: Colors.black),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: EmailController,
//                         decoration: InputDecoration(
//                             labelText: 'Email',
//                             labelStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w100,
//                                 fontSize: 15),
//                             focusColor: Colors.black,
//                             fillColor: Colors.black,
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20)),
//                                 borderSide: BorderSide(color: Colors.white38),
//                                 gapPadding: 10),
//                             border: UnderlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                             hoverColor: Colors.black),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         controller: PasswordController,
//                         decoration: InputDecoration(
//                             labelText: 'Password',
//                             labelStyle: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w100,
//                                 fontSize: 15),
//                             focusColor: Colors.black,
//                             fillColor: Colors.black,
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20)),
//                                 borderSide: BorderSide(color: Colors.white38),
//                                 gapPadding: 10),
//                             border: UnderlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                             hoverColor: Colors.black),
//                         obscureText: true,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: (){
//                         checkValues(context);
//                       },
//                       child: Text('Login'),
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Login(),
//                               ));
//                         },
//                         child: Text.rich(TextSpan(
//                           children: [
//                             TextSpan(
//                                 text: 'Sign in',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 14))
//                           ],
//                           text: 'Already have a account?  ',
//                           style: TextStyle(
//                               color: Colors.white70,
//                               fontWeight: FontWeight.w100,
//                               fontSize: 12),
//                         ))),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   void checkValues(BuildContext context) {
//     String name = NameController.text.trim();
//     String Uname = UsernameController.text.trim();
//     String email = EmailController.text.trim();
//     String password = PasswordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty || name.isEmpty || Uname.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Incomplete Data"),
//             content: Text("Please fill all the fields"),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       signUp(context, email, password, name, Uname);
//     }
//   }
//
//   Future<void> signUp(BuildContext context, String name, String Uname,  String email, String password) async {
//     final AuthenticationService authService = Provider.of<AuthenticationService>(context, listen: false);
//
//     try {
//       await authService.signUp(email, password);
//
//       // Navigate to home page or other logic after successful sign-up
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()), // Replace with your home page
//       );
//     } on FirebaseAuthException catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Sign-Up Failed"),
//             content: Text(e.message ?? 'An unknown error occurred'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text('An unexpected error occurred: ${e.toString()}'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
// // Future<void> createUser() async {
//   //
//   //   String email = emailController.text.trim();
//   //   String password = passwordController.text.trim();
//   //   String cPassword = cPasswordController.text.trim();
//   //
//   //   if(email == "" || password == "" || cPassword == "") {
//   //    // UIHelper.showAlertDialog(context, "Incomplete Data", "Please fill all the fields");
//   //   }
//   //   else if(password != cPassword) {
//   //    // UIHelper.showAlertDialog(context, "Password Mismatch", "The passwords you entered do not match!");
//   //   }
//   //   else {
//   //     SignUpPage(
//   //     //    email, password
//   //     );
//   //   }
//   //
//   //   UserCredential? credential;
//   //
//   //  // UIHelper.showLoadingDialog(context, "Creating new account..");
//   //
//   //   try {
//   //     credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
//   //   } on FirebaseAuthException catch(ex) {
//   //     Navigator.pop(context);
//   //
//   //    // UIHelper.showAlertDialog(context, "An error occured", ex.message.toString());
//   //   }
//   //
//   //   if(credential != null) {
//   //     //String uid = credential.user!.uid;
//   //     // UserModel newUser = UserModel(
//   //     //     uid: uid,
//   //     //     email: email,
//   //     //     fullname: "",
//   //     //     profilepic: ""
//   //     // );
//   //     // await FirebaseFirestore.instance.collection("coffee_users").doc(uid).set(newUser.toMap()).then((value) {
//   //     //   print("New User Created!");
//   //     //   Navigator.popUntil(context, (route) => route.isFirst);
//   //     //   Navigator.pushReplacement(
//   //     //     context,
//   //     //     MaterialPageRoute(
//   //     //         builder: (context) {
//   //     //           return ProfileUser(
//   //     //               //userModel: newUser, firebaseUser: credential!.user!
//   //     //           );
//   //     //         }
//   //     //     ),
//   //     //   );
//   //       // }
//   //    // );
//   //   }
//   //
//   //   //
//   //   // try {
//   //   //   UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//   //   //       email: EmailController.text, password: PasswordController.text);
//   //   //   User? user = userCredential.user;
//   //   //
//   //   //   if (user != null) {
//   //   //     await firestore.collection('users').doc(user.uid).set({
//   //   //       'Name': NameController.text,
//   //   //       'Username': UsernameController.text,
//   //   //       'Email': EmailController.text,
//   //   //       'Password': PasswordController.text
//   //   //     });
//   //   //     print('User created and saved to FireStore');
//   //   //   }
//   //   //
//   //   //   Navigator.pushReplacement(
//   //   //       context,
//   //   //       MaterialPageRoute(
//   //   //         builder: (context) => HomePage(),
//   //   //       ));
//   //   // } catch (e) {
//   //   //   print('Error : $e');
//   //   // }
//   // }
// }
//
//
//
// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<void> signUp(String email, String password) async {
//     try {
//       // Check if a user already exists using Firebase Authentication
//       List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
//       if (signInMethods.isNotEmpty) {
//         throw Exception('User already exists');
//       }
//
//       // Proceed with user creation
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//
//       // Optionally, create a Firestore document for the user
//       await FirebaseFirestore.instance.collection('user').doc(email).set({
//         'email': email,
//         // Add other fields if needed
//       });
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.message ?? 'An unknown error occurred');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Model/UserModel_Coffee.dart';
import 'BottomBar_Coffee.dart';
import 'Homepage_Coffee.dart';
import 'Login_Coffee.dart';
//import 'your_auth_service_file.dart'; // Adjust the import for AuthenticationService

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7RUWeEmgtRlQTzwXSzQrqfed-HEF5Pn3iZ64kP9lrVacrj1ySTswbX4hXCCw4R15EcMo&usqp=CAU',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Sign-up card
          Center(
            child: Container(
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white54.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 15,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextField(controller: nameController, label: 'Name'),
                    buildTextField(controller: usernameController, label: 'Username'),
                    buildTextField(controller: emailController, label: 'Email'),
                    buildTextField(controller: passwordController, label: 'Password', obscureText: true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => checkValues(context),
                      child: Text('Sign Up'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.white38),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void checkValues(BuildContext context) {
    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty || username.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Incomplete Data"),
            content: Text("Please fill all the fields"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      signUp(context, name, username, email, password);
    }
  }

  Future<void> signUp(BuildContext context, String name, String username, String email, String password) async {
    final authService = Provider.of<AuthenticationService>(context, listen: false);

    try {
      UserCredential userCredential = await authService.signUp(email, password,name,);

      // Create Firestore document with user data
      UserModel newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        username: username,
      );

      await FirebaseFirestore.instance.collection('users').doc(newUser.uid).set(newUser.toMap());

      // Navigate to home page after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottenBarChat()),
      );
    } on FirebaseAuthException catch (e) {
      showErrorDialog(context, "Sign-Up Failed", e.message ?? 'An unknown error occurred');
    } catch (e) {
      showErrorDialog(context, "Error", 'An unexpected error occurred: ${e.toString()}');
    }
  }
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

// Future<void> signUp(BuildContext context, String name, String username, String email, String password) async {
  //   final authService = Provider.of<AuthenticationService>(context, listen: false);
  //
  //   try {
  //     await authService.signUp(email, password);
  //
  //     // Navigate to home page after successful sign-up
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomePage()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Sign-Up Failed"),
  //           content: Text(e.message ?? 'An unknown error occurred'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Error"),
  //           content: Text('An unexpected error occurred: ${e.toString()}'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

}

//
// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<void> signUp(String email, String password) async {
//     try {
//       // Check if user already exists
//       List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
//       if (signInMethods.isNotEmpty) {
//         throw Exception('User already exists');
//       }
//
//       // Create new user
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//
//       // Optionally create Firestore document
//       await FirebaseFirestore.instance.collection('users').doc(email).set({
//         'email': email,
//         // Add additional user details here if needed
//       });
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.message ?? 'An unknown error occurred');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

//
// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<UserCredential> signUp(String email, String password) async {
//     try {
//       // Create new user
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.message ?? 'An unknown error occurred');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }





class AuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthenticationService() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signUp(String email, String password, String name) async {
    try {
      // Create new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save additional user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    if (_user != null) {
      return await FirebaseFirestore.instance.collection('users').doc(_user!.uid).get();
    } else {
      throw Exception('No user is currently signed in.');
    }
  }


  // Future<void> updateProfilePicture(String url) async {
  //   if (_user != null) {
  //     await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
  //       'profilePictureUrl': url,
  //     });
  //   } else {
  //     throw Exception('No user is currently signed in.');
  //   }
  // }

  // Future<void> updateProfilePicture(File imageFile) async {
  //   if (_user != null) {
  //     try {
  //       // Upload image to Firebase Storage
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('profile_pictures/${_user!.uid}');
  //       await storageRef.putFile(imageFile);
  //
  //       // Get the download URL
  //       final downloadUrl = await storageRef.getDownloadURL();
  //
  //       // Update Firestore with the new profile picture URL
  //       await FirebaseFirestore.instance.collection('users').doc(_user!.uid).update({
  //         'profilePictureUrl': downloadUrl,
  //       });
  //     } catch (e) {
  //       print('Error updating profile picture: ${e.toString()}');
  //     }
  //   } else {
  //     throw Exception('No user is currently signed in.');
  //   }
  // }

  Future<String> updateProfilePicture(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${_auth.currentUser!.uid}.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }
}
