import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/UserModel_Coffee.dart';
import 'BottomBar_Coffee.dart';
import 'Homepage_Coffee.dart';
import 'Signup_Coffee.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   final _formKey = GlobalKey<FormState>();
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();


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
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu2je2RaW_J1jUCWpQwicPNdzLwdr8xhlVwIB6kCgq-UVTYvbemte4B5ihqHbkaeR-y_Y&usqp=CAU'
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 3D login card
          Center(
            child: Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white54.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                      blurStyle: BlurStyle.outer
                    //offset: Offset(10, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: EmailController,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15),
                              focusColor: Colors.black,
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.white38),
                                  gapPadding: 10),
                              border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              hoverColor: Colors.black),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: PasswordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15),
                              focusColor: Colors.black,
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(color: Colors.white38),
                                  gapPadding: 10),
                              border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              hoverColor: Colors.black),
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: (){
                          checkValues(context);
                        },
                        child: Text('Login'),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ));
                          },
                          child: Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))
                            ],
                            text: 'Dont have an acoount?  ',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w100,
                                fontSize: 12),
                          ))),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   // void checkValues(BuildContext context) {
   //   String email = EmailController.text.trim();
   //   String password = PasswordController.text.trim();
   //
   //   if (email.isEmpty || password.isEmpty) {
   //     showDialog(
   //       context: context,
   //       builder: (BuildContext context) {
   //         return AlertDialog(
   //           title: Text("Incomplete Data"),
   //           content: Text("Please fill all the fields"),
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
   //   } else {
   //     signIn(context, email, password);
   //   }
   // }
   //
   // Future<void> signIn(BuildContext context, String email, String password) async {
   //   final FirebaseAuth _auth = FirebaseAuth.instance;
   //
   //   try {
   //     UserCredential credential = await _auth.signInWithEmailAndPassword(
   //       email: email,
   //       password: password,
   //     );
   //
   //     if (credential.user != null) {
   //       String uid = credential.user!.uid;
   //
   //       // Fetch user data from Firestore if needed
   //       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(email).get();
   //
   //       if (userDoc.exists) {
   //         // Handle user data as needed
   //         print("User Data: ${userDoc.data()}");
   //       } else {
   //         print("No user data found in Firestore");
   //       }
   //
   //       // Proceed with navigation or other logic
   //       Navigator.pushReplacement(
   //         context,
   //         MaterialPageRoute(builder: (context) => HomePage()), // Example of navigation
   //       );
   //     }
   //   } on FirebaseAuthException catch (e) {
   //     showDialog(
   //       context: context,
   //       builder: (BuildContext context) {
   //         return AlertDialog(
   //           title: Text("Login Failed"),
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
   void checkValues(BuildContext context) {
     if (_formKey.currentState?.validate() ?? false) {
       // Form is valid, proceed with sign-in
       String email = EmailController.text.trim();
       String password = PasswordController.text.trim();
       signIn(context, email, password);
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

   Future<void> signIn(BuildContext context, String email, String password) async {
     final FirebaseAuth _auth = FirebaseAuth.instance;

     try {
       UserCredential credential = await _auth.signInWithEmailAndPassword(
         email: email,
         password: password,
       );

       if (credential.user != null) {
         String uid = credential.user!.uid;

         // Fetch user data from Firestore
         DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

         if (userDoc.exists) {
           UserModel user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
           print("User Data: ${user.toMap()}");
         } else {
           print("No user data found in Firestore");
         }

         // Proceed with navigation or other logic
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => BottenBarChat()),
         );
       }
     } on FirebaseAuthException catch (e) {
       showErrorDialog(context, "Login Failed", e.message ?? 'An unknown error occurred');
     } catch (e) {
       showErrorDialog(context, "Error", 'An unexpected error occurred: ${e.toString()}');
     }
   }
}
