import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/ProductModel_Coffee.dart';



Future<void> addCartToHistory(String userId, List<ProductModel> cartItems) async {
  try {
    // Calculate total price
    double totalPrice = cartItems.fold(0.0, (sum, item) => sum + double.tryParse() ?? 0.0);

    // Create cart items list
    List<Map<String, dynamic>> itemsList = cartItems.map((item) {
      return {
        'item_id': item.id,
        'item_name': item.name,
        'item_price': item.price,
        'quantity': 1, // Assuming quantity is 1 for simplicity
      };
    }).toList();

    // Save cart history
    await FirebaseFirestore.instance.collection('cart_history').add({
      'user_id': userId,
      'items': itemsList,
      'total_price': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Cart history saved successfully');
  } catch (e) {
    print('Error saving cart history: $e');
  }
}


class CartHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart History'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart_history')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No cart history available.'));
          }

          final cartHistory = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cartHistory.length,
            itemBuilder: (context, index) {
              final historyItem = cartHistory[index];
              final items = historyItem['items'] as List<dynamic>;

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Order ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...items.map((item) => Text('${item['item_name']} - \$${item['item_price']}')),
                      SizedBox(height: 8),
                      Text('Total: \$${historyItem['total_price']}'),
                      Text('Date: ${historyItem['timestamp'].toDate()}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}