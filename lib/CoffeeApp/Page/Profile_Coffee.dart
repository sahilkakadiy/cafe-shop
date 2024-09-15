import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/CoffeeApp/Model/UserModel_Coffee.dart';
import 'package:coffee/CoffeeApp/Page/Homepage_Coffee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'History_Coffee.dart';
import 'Notification_Coffee.dart';
import 'Signup_Coffee.dart';
import 'package:flutter/material.dart';

import 'favorite_controller.dart';

//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               // Handle edit profile action
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Picture
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 80,
//                       backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFVHR62PqqslJrmbNHhwiH3Cmb99-h10mi6g&s'), // Replace with actual image URL
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: IconButton(
//                         icon: Icon(Icons.camera_alt, color: Colors.white, size: 30),
//                         onPressed: () {
//                           // Handle change profile picture action
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // User Information
//               Text(
//                 'John Doe',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'johndoe@example.com',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 30),
//
//               // Contact Information
//               Text(
//                 'Contact Information',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Icon(Icons.phone, color: Colors.grey[600]),
//                   SizedBox(width: 10),
//                   Text(
//                     '+123 456 7890',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Icon(Icons.location_on, color: Colors.grey[600]),
//                   SizedBox(width: 10),
//                   Text(
//                     '123 Main St, Anytown, USA',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
//
//               // Settings Section
//               Text(
//                 'Settings',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               ListTile(
//                 leading: Icon(Icons.lock),
//                 title: Text('Change Password'),
//                 onTap: () {
//                   // Handle change password action
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: Text('Notification Settings'),
//                 onTap: () {
//                   // Handle notification settings action
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text('Logout'),
//                 onTap: () {
//                   // Handle logout action
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// GetxController image-picker
//
// class ImagePickerController extends GetxController {
//   var image = Rx<XFile?>(null); // Observable to store picked image
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         imageQuality: 80, // Adjust the image quality
//       );
//       if (pickedFile != null) {
//         image.value = pickedFile; // Update the observable
//       } else {
//         print('No Image Picked');
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error picking image: $e');
//     }
//   }
//
//   void removeImage() {
//     image.value = null;
//   }
// }
//
// class images extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ImagePickerController controller = Get.put(ImagePickerController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker Example'),
//       ),
//       body: Center(
//         child: Obx(() {
//           return InkWell(
//             onTap: () {
//               controller.pickImage(ImageSource.gallery);
//             },
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 50,
//               child: controller.image.value != null
//                   ? CircleAvatar(radius: 50,backgroundImage: NetworkImage(controller.image.value!.path)) // Convert XFile to File
//                   : Center(
//                 child: Icon(Icons.person,size: 50),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final ImagePickerController controller = Get.put(ImagePickerController());
//   String name = 'John Doe';
//   String email = 'john.doe@example.com';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ProfileImageSection(controller: controller),
//             SizedBox(height: 20),
//             UserInfoSection(name: name, email: email),
//             SizedBox(height: 20),
//             EditProfileButton(onEdit: _navigateAndUpdateProfile),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _navigateAndUpdateProfile() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditProfileScreen(
//           initialName: name,
//           initialEmail: email,
//         ),
//       ),
//     );
//
//     if (result != null) {
//       setState(() {
//         name = result['name'];
//         email = result['email'];
//       });
//     }
//   }
// }
//
// class ProfileImageSection extends StatelessWidget {
//   final ImagePickerController controller;
//
//   ProfileImageSection({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           Obx(() {
//             return InkWell(
//               onTap: () {
//                 controller.pickImage(ImageSource.gallery);
//               },
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 50,
//                 child: controller.image.value != null
//                     ? CircleAvatar(radius: 50,backgroundImage: NetworkImage(controller.image.value!.path)) // Convert XFile to File
//                     : Center(
//                   child: Icon(Icons.person,size: 50),
//                 ),
//               ),
//             );
//           }),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: IconButton(
//               icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
//               onPressed: () {
//                 controller.pickImage(ImageSource.gallery);
//               },
//               color: Colors.blue,
//               padding: EdgeInsets.zero,
//               constraints: BoxConstraints(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //
// // class UserInfoSection extends StatelessWidget {
// //   final UserModel user;
// //
// //   UserInfoSection({required this.user});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Text(
// //           user.name,
// //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //         ),
// //         SizedBox(height: 5),
// //         Text(
// //           user.email,
// //           style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
// class EditProfileButton extends StatelessWidget {
//   final VoidCallback onEdit;
//   final UserModel user;
//
//
//   EditProfileButton({required this.onEdit,required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onEdit,
//       child: Text('Edit Profile'),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//         textStyle: TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }
// //
// // class EditProfileScreen extends StatefulWidget {
// //   final UserModel user;
// //
// //
// //   EditProfileScreen({required this.user});
// //
// //   @override
// //   _EditProfileScreenState createState() => _EditProfileScreenState();
// // }
// //
// // class _EditProfileScreenState extends State<EditProfileScreen> {
// //   late TextEditingController _nameController;
// //   late TextEditingController _emailController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _nameController = TextEditingController(text: widget.user.name);
// //     _emailController = TextEditingController(text: widget.user.email);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Edit Profile'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('Edit your profile information:', style: TextStyle(fontSize: 18)),
// //             SizedBox(height: 20),
// //             TextFormField(
// //               controller: _nameController,
// //               decoration: InputDecoration(
// //                 labelText: 'Name',
// //                 border: OutlineInputBorder(),
// //                 prefixIcon: Icon(Icons.person),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             TextFormField(
// //               controller: _emailController,
// //               decoration: InputDecoration(
// //                 labelText: 'Email',
// //                 border: OutlineInputBorder(),
// //                 prefixIcon: Icon(Icons.email),
// //               ),
// //               keyboardType: TextInputType.emailAddress,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Get the updated data and pop the screen
// //                 final name = _nameController.text;
// //                 final email = _emailController.text;
// //                 Navigator.pop(context, {'name': name, 'email': email});
// //               },
// //               child: Text('Save Changes'),
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.blue,
// //                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                 textStyle: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //------------------------------------------------------------------------------
// //
// // class ProfilePages extends StatelessWidget {
// //   final Map<String, dynamic> userData;
// //
// //   ProfilePages({required this.userData});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Extract user details from the provided userData map
// //     final email = userData['email'] ?? 'No email';
// //     final name = userData['name'] ?? 'No name';
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Profile'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             Text('Name: $name', style: TextStyle(fontSize: 20)),
// //             SizedBox(height: 10),
// //             Text('Email: $email', style: TextStyle(fontSize: 20)),
// //             // Add more profile fields as needed
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// //________________________________________


// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<UserModel?> getUserData() async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//         return UserModel.fromFirestore(userDoc);
//       }
//     } catch (e) {
//       print('Error fetching user data: ${e.toString()}');
//     }
//     return null;
//   }
//
//   Future<void> updateUserData(UserModel user) async {
//     try {
//       final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
//       await userDoc.update(user.toMap());
//     } catch (e) {
//       print('Error updating user data: ${e.toString()}');
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
//   Future<UserModel?> getUserData() async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
//         if (userDoc.exists) {
//           return UserModel.fromFirestore(userDoc);
//         } else {
//           print('User document does not exist.');
//         }
//       }
//     } catch (e) {
//       print('Error fetching user data: ${e.toString()}');
//     }
//     return null;
//   }
//
//   Future<void> updateUserData(UserModel user) async {
//     try {
//       final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
//       await userDoc.update(user.toMap());
//     } catch (e) {
//       print('Error updating user data: ${e.toString()}');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//
// class UserInfoSection extends StatelessWidget {
//   final UserModel user;
//
//   UserInfoSection({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           user.name,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 5),
//         Text(
//           user.email,
//           style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//         ),
//       ],
//     );
//   }
// }
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthenticationService>();
//
//     return FutureBuilder<UserModel?>(
//       future: authService.getUserData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData) {
//           return Center(child: Text('No user data found.'));
//         } else {
//           final user = snapshot.data!;
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Profile'),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () async {
//                     final updatedData = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditProfileScreen(
//                           initialName: user.name,
//                           initialEmail: user.email,
//                         ),
//                       ),
//                     );
//                     if (updatedData != null) {
//                       final updatedUser = UserModel(
//                         uid: user.uid,
//                         name: updatedData['name'],
//                         email: updatedData['email'],
//                         username: updatedData['username'],
//                       );
//                       await authService.updateUserData(updatedUser);
//                       // Refresh the profile page
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: UserInfoSection(
//                 user: user,
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
//
// class EditProfileScreen extends StatefulWidget {
//   final String initialName;
//   final String initialEmail;
//
//   EditProfileScreen({required this.initialName, required this.initialEmail});
//
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _emailController;
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.initialName);
//     _emailController = TextEditingController(text: widget.initialEmail);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Edit your profile information:', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.email),
//               ),
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an email';
//                 }
//                 final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                 if (!emailRegex.hasMatch(value)) {
//                   return 'Please enter a valid email address';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final name = _nameController.text;
//                 final email = _emailController.text;
//                 Navigator.pop(context, {'name': name, 'email': email});
//               },
//               child: Text('Save Changes'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 textStyle: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfilePages extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthenticationService>();
//
//     return FutureBuilder<UserModel?>(
//       future: authService.getUserData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData) {
//           return Center(child: Text('No user data found.'));
//         } else {
//           final user = snapshot.data!;
//
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Profile'),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () async {
//                     final updatedData = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditProfileScreen(
//                           initialName: user.name,
//                           initialEmail: user.email,
//                         ),
//                       ),
//                     );
//                     if (updatedData != null) {
//                       final updatedUser = UserModel(
//                         uid: user.uid,
//                         name: updatedData['name'],
//                         email: updatedData['email'],
//                         username: updatedData['username'],
//                       );
//                       await authService.updateUserData(updatedUser);
//                       // Refresh the profile page
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.info),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => UserDetailScreen(user: user),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: UserInfoSection(
//                 user: user,
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
//
// class UserDetailScreen extends StatelessWidget {
//   final UserModel user;
//
//   UserDetailScreen({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${user.name}', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 10),
//             Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthenticationService>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await authService.signOut();
//               Navigator.of(context).pop(); // Or navigate to login screen
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<UserModel?>(
//         future: authService.getUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No user data found.'));
//           } else {
//             final user = snapshot.data!;
//
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${user.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 8),
//                   Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//------------------------------------------------------------------------------


// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;
//
//   AuthenticationService() {
//     _auth.authStateChanges().listen((user) {
//       _user = user;
//       notifyListeners();
//     });
//   }
//
//   User? get user => _user;
//
//   Future<void> signUp(String email, String password, String name) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//         'email': email,
//         'name': name,
//       });
//     } catch (e) {
//       print('Error signing up: ${e.toString()}');
//     }
//   }
//
//   Future<void> signIn(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } catch (e) {
//       print('Error signing in: ${e.toString()}');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//==============================================================================
//-------------------------_____________--------------------------------------
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthenticationService>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await authService.signOut();
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('No user data found.'));
//           } else {
//             final userData = snapshot.data!.data() as Map<String, dynamic>;
//
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${userData['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Text('Email: ${userData['email']}', style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//---------------------------------------------------------------------------



class ProfileScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();

    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   leading: BackButton(
      //     onPressed: () {
      //       Get.to(HomePage());
      //     },
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () async {
      //         await authService.signOut();
      //         Navigator.of(context).pop(); // Navigate to login screen or home
      //       },
      //     ),
      //     // IconButton(onPressed: () {
      //     //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderHistoryScreen(),));
      //     // }, icon: Icon(Icons.history))
      //   ],
      // ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.brown.shade500,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${authService.user!.displayName}',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    )),// You can adjust the font size as needed
              ),
              background: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.network(
                    'https://img.freepik.com/premium-photo/refreshing-small-coffee-shop-creamy-atmosphere_943281-44931.jpg?w=360', // Placeholder background image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: GestureDetector(
                      onTap: () async {
                        await _showImagePickerDialog(context);
                      },
                      child:CircleAvatar(
                        radius: 60,
                        backgroundImage: authService.user?.photoURL != null
                            ? NetworkImage(authService.user!.photoURL!)
                            : AssetImage('assets/default_profile_picture.png'),
                        backgroundColor: Colors.grey.shade200,
                      ),

                    ),
                  ),
                ],
              ),
            ),
            leading: BackButton(
              onPressed: () {
                Get.to(HomePage());
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await authService.signOut();
                  Navigator.of(context).pop(); // Navigate to login screen or home
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('No user data found.'));
                } else {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        // User Info
                        Text('Name: ${userData['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Email: ${userData['email']}', style: TextStyle(fontSize: 18)),
                        SizedBox(height: 30),
                        // Edit Profile Button
                        ElevatedButton(
                          onPressed: () {
                            _showEditDialog(context, userData);
                          },
                          child: Text('Edit Profile',style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                                fontSize: 12,
                              ))),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            backgroundColor: Colors.brown.shade50,
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ListTile(
                leading: Icon(Icons.notifications_on_rounded,color: Colors.yellow.shade900,),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.brown.shade900),
                  ),
                ),
                onTap: () {
                  Get.to(notificaionpage());
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite_sharp,color: Colors.red.shade900,),
                title: Text(
                  'Favorites',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.brown.shade900),
                  ),
                ),
                onTap: () {
                  Get.to(Favoritescreen());
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark_outlined,color: Colors.blue.shade900,),
                title: Text(
                  'Bookmarks',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.brown.shade900),
                  ),
                ),
                onTap: () {
                  Get.to(OrderHistoryPage());
                },
              ),
              ListTile(
                leading: Icon(Icons.info_sharp,color: Colors.green.shade900,),
                title: Text(
                  'Information',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.brown.shade900),
                  ),
                ),
              ),
              Expanded(child: SizedBox(height: 150,)),
              ListTile(
                leading: Icon(Icons.logout_outlined,color: Colors.black,),
                title: Text(
                  'Logout',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.brown.shade900),
                  ),
                ),
                onTap: () async {
                  await authService.signOut();
                  Navigator.of(context).pop(); // Navigate to login screen or home
                },
              ),
            ]),
          )        ],
        // child: FutureBuilder<DocumentSnapshot>(
        //   future: FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).get(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else if (!snapshot.hasData || !snapshot.data!.exists) {
        //       return Center(child: Text('No user data found.'));
        //     } else {
        //       final userData = snapshot.data!.data() as Map<String, dynamic>;
        //       return Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // Profile Picture with Overlay Icon
        //             Stack(
        //               alignment: Alignment.bottomRight,
        //               children: [
        //                 GestureDetector(
        //                   onTap: () async {
        //                     await _showImagePickerDialog(context);
        //                   },
        //                   child: CircleAvatar(
        //                     radius: 70,
        //                     backgroundImage: userData['profilePictureUrl'] != null
        //                         ? NetworkImage(userData['profilePictureUrl'])
        //                         : AssetImage('assets/default_profile_picture.png') as ImageProvider,
        //                     backgroundColor: Colors.grey.shade200,
        //                   ),
        //                 ),
        //                 Positioned(
        //                   bottom: 0,
        //                   right: 0,
        //                   child: Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.white,
        //                       shape: BoxShape.circle,
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.black26,
        //                           blurRadius: 6,
        //                           spreadRadius: 1,
        //                         ),
        //                       ],
        //                     ),
        //                     child: IconButton(
        //                       icon: Icon(Icons.camera_alt, color: Colors.blue),
        //                       onPressed: () async {
        //                         await _showImagePickerDialog(context);
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             SizedBox(height: 20),
        //             // User Info
        //             Column(crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text('Name: ${userData['name']}',
        //                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        //                 SizedBox(height: 8),
        //                 Text('Email: ${userData['email']}',
        //                     style: TextStyle(fontSize: 18)),
        //                 SizedBox(height: 30),
        //                 // Edit Profile Button
        //                 ElevatedButton(
        //                   onPressed: () {
        //                     _showEditDialog(context, userData);
        //                   },
        //                   child: Text('Edit Profile'),
        //                   style: ElevatedButton.styleFrom(
        //                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), backgroundColor: Colors.blue,
        //                     textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       );
        //       // return Padding(
        //       //   padding: const EdgeInsets.all(16.0),
        //       //   child: Column(
        //       //     crossAxisAlignment: CrossAxisAlignment.start,
        //       //     children: [
        //       //       // Profile Picture
        //       //       Center(
        //       //         child: Stack(
        //       //           alignment: Alignment.center,
        //       //           children: [
        //       //             GestureDetector(
        //       //               onTap: () async {
        //       //                 await _showImagePickerDialog(context);
        //       //               },
        //       //               child: CircleAvatar(
        //       //                 radius: 70,
        //       //                 backgroundImage: userData['profilePictureUrl'] != null
        //       //                     ? NetworkImage(userData['profilePictureUrl'])
        //       //                     : AssetImage('assets/default_profile_picture.png') as ImageProvider,
        //       //                 backgroundColor: Colors.grey.shade200,
        //       //               ),
        //       //             ),
        //       //             Positioned(
        //       //               bottom: 0,
        //       //               right: 0,
        //       //               child: Container(
        //       //                 decoration: BoxDecoration(
        //       //                   color: Colors.white,
        //       //                   shape: BoxShape.circle,
        //       //                   boxShadow: [
        //       //                     BoxShadow(
        //       //                       color: Colors.black26,
        //       //                       blurRadius: 4,
        //       //                       spreadRadius: 1,
        //       //                     ),
        //       //                   ],
        //       //                 ),
        //       //                 child: IconButton(
        //       //                   icon: Icon(Icons.camera_alt, color: Colors.blue),
        //       //                   onPressed: () async {
        //       //                     await _showImagePickerDialog(context);
        //       //                   },
        //       //                 ),
        //       //               ),
        //       //             ),
        //       //           ],
        //       //         ),
        //       //       ),
        //       //       SizedBox(height: 20),
        //       //       // User Info
        //       //       Text('Name: ${userData['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        //       //       SizedBox(height: 8),
        //       //       Text('Email: ${userData['email']}', style: TextStyle(fontSize: 18)),
        //       //       SizedBox(height: 20),
        //       //       ElevatedButton(
        //       //         onPressed: () {
        //       //           _showEditDialog(context, userData);
        //       //         },
        //       //         child: Text('Edit Profile'),
        //       //       ),
        //       //     ],
        //       //   ),
        //       // );
        //     }
        //   },
        // ),
      ),
    );
  }

  // Future<void> _showImagePickerDialog(BuildContext context) async {
  //   final picker = ImagePicker();
  //   final selectedOption = await showDialog<ImageSource>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Select Image Source'),
  //       actions: [
  //         TextButton(
  //           child: Text('Camera'),
  //           onPressed: () => Navigator.pop(context, ImageSource.camera),
  //         ),
  //         TextButton(
  //           child: Text('Gallery'),
  //           onPressed: () => Navigator.pop(context, ImageSource.gallery),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   if (selectedOption != null) {
  //     final pickedFile = await picker.pickImage(source: selectedOption);
  //
  //     if (pickedFile != null) {
  //       final imageFile = File(pickedFile.path);
  //       final authService = context.read<AuthenticationService>();
  //
  //       try {
  //         // Update profile picture in Firebase Storage and get the URL
  //         final imageUrl = await authService.updateProfilePicture(imageFile);
  //         await FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).update({
  //           'profilePictureUrl': imageUrl,
  //         });
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture updated successfully.')));
  //       } catch (e) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile picture.')));
  //       }
  //     }
  //   }
  // }
  Future<void> _showImagePickerDialog(BuildContext context) async {
    final picker = ImagePicker();
    final selectedOption = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image Source'),
        actions: [
          TextButton(
            child: Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (selectedOption != null) {
      final pickedFile = await picker.pickImage(source: selectedOption);

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        final authService = context.read<AuthenticationService>();

        try {
          // Update profile picture in Firebase Storage and get the URL
          final imageUrl = await authService.updateProfilePicture(imageFile);
          await FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).update({
            'profilePictureUrl': imageUrl,
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture updated successfully.')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile picture.')));
        }
      }
    }
  }
  Future<void> _showEditDialog(BuildContext context, Map<String, dynamic> userData) async {
    final nameController = TextEditingController(text: userData['name']);
    final emailController = TextEditingController(text: userData['email']);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              final authService = context.read<AuthenticationService>();

              try {
                await FirebaseFirestore.instance.collection('users').doc(authService.user!.uid).update({
                  'name': nameController.text,
                  'email': emailController.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully.')));
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile.')));
              }
            },
          ),
        ],
      ),
    );
  }
}

//()()()()()[][][][][][][


