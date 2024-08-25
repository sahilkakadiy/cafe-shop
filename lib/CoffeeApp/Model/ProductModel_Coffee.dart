import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductModel {
//   final String name;
//   final String price;
//   final String image;
//   final String description;
//
//   ProductModel({
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.description,
//   });
//
//   // Factory constructor to create a ProductModel from a map
//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     return ProductModel(
//       name: map['name'] ?? '',
//       price: map['price']?.toString() ?? '',
//       image: map['image'] ?? '',
//       description: map['details'] ?? '',
//     );
//   }
//
//   // Method to convert ProductModel to a map
//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'name': name,
//   //     'price': price,
//   //     'image': image,
//   //     'details': description,
//   //   };
//   // }
// }

// rules_version = '2';
//
// service cloud.firestore {
// match /databases/{database}/documents {
//
// // This rule allows anyone with your Firestore database reference to view, edit,
// // and delete all data in your Firestore database. It is useful for getting
// // started, but it is configured to expire after 30 days because it
// // leaves your app open to attackers. At that time, all client
// // requests to your Firestore database will be denied.
// //
// // Make sure to write security rules for your app before that time, or else
// // all client requests to your Firestore database will be denied until you Update
// // your rules
// match /{document=**} {
// allow read, write: if request.time < timestamp.date(2024, 8, 20);
//}
//}
//}

//
// rules_version = '2';
//
// service cloud.firestore {
// match /databases/{database}/documents {
// // Public read access
// match /public/{document=**} {
// allow read: if true;
// allow write: if request.auth != null;
// }
//
// // User-specific access
// match /users/{userId} {
// allow read, write: if request.auth != null && request.auth.uid == userId;
// }
//
// // Admin-specific access
// match /admin/{document=**} {
// allow read, write: if request.auth != null && request.auth.token.admin == true;
// }
// }
// }
//
//

//
// rules_version = '2';
//
// service cloud.firestore {
// match /databases/{database}/documents {
//
//
// match /{document=**} {
// allow read, write: if true;
// }
//
// match /{document=**} {
// allow read, write: if request.time < timestamp.date(2024, 8, 20);
// }
// }
// }


class ProductModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  // Factory constructor to create a ProductModel from a map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toString() ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '', // Adjusted to match 'description'
    );
  }

  // Factory constructor to create a ProductModel from Firestore DocumentSnapshot
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data);
  }

  // Method to convert ProductModel to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  // Method to convert ProductModel to Firestore DocumentSnapshot
  Map<String, dynamic> toFirestore() {
    return toMap();
  }
}


// Adding a product to Firestore
Future<void> addProduct(ProductModel product) async {
  final firestore = FirebaseFirestore.instance;
  await firestore.collection('products').doc(product.id).set(product.toFirestore());
}

// Getting a product from Firestore
Future<ProductModel?> getProduct(String id) async {
  final firestore = FirebaseFirestore.instance;
  final doc = await firestore.collection('products').doc(id).get();
  if (doc.exists) {
    return ProductModel.fromFirestore(doc);
  } else {
    return null; // Handle this case as needed
  }
}
