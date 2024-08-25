import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteItem {
  final String id;
  final String image;
  final String name;

  FavoriteItem({required this.id, required this.image, required this.name});

  // Convert a Firestore document to a FavoriteItem
  factory FavoriteItem.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteItem(
      id: doc.id,
      image: data['image'] ?? '',
      name: data['name'] ?? '',
    );
  }

  // Convert a FavoriteItem to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
    };
  }
}
