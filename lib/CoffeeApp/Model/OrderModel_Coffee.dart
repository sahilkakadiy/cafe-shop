// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class OrderModel {
//   final String id;
//   final String image;
//   final String name;
//   final String price;
//
//   OrderModel({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//   });
//
//   // Convert a Firestore document to a ProductModel
//   factory OrderModel.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return OrderModel(
//       id: doc.id,
//       image: data['image'] ?? '',
//       name: data['name'] ?? '',
//       price: data['price'] ?? '',
//     );
//   }
//
//   // Convert a ProductModel to a Firestore document
//   Map<String, dynamic> toMap() {
//     return {
//       'image': image,
//       'name': name,
//       'price': price,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
class OrderModel {
  final String productId;
  final int quantity;
  final double totalPrice;
  final Timestamp timestamp;

  OrderModel({
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.timestamp,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      productId: map['productId'],
      quantity: map['quantity'],
      totalPrice: map['totalPrice'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'timestamp': timestamp,
    };
  }
}
//socket\