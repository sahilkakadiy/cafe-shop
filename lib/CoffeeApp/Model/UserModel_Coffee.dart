import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String username;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }
}


// class UserModels {
//   final String uid;
//   final String name;
//   final String email;
//
//   UserModels({required this.uid, required this.name, required this.email});
//
//   // Convert a Firestore document to a UserModel
//   factory UserModels.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return UserModels(
//       uid: doc.id,
//       name: data['name'] ?? '',
//       email: data['email'] ?? '',
//     );
//   }
//
//   // Convert a UserModel to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//     };
//   }
// }
