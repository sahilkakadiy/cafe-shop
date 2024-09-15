// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../Model/ProductModel_Coffee.dart';
//
//
// //
// // Future<void> addCartToHistory(String userId, List<ProductModel> cartItems) async {
// //   try {
// //     // Calculate total price
// //     // Assuming your cart items are in a list and each item has a 'price' field as a string
// //     double totalPrice = cartItems.fold(0.0, (sum, item) {
// //       // Parse the price of the item from string to double, default to 0.0 if parsing fails
// //       double price = double.tryParse(item.price) ?? 0.0;
// //       return sum + price;
// //     });
// //
// //
// //     // Create cart items list
// //     List<Map<String, dynamic>> itemsList = cartItems.map((item) {
// //       return {
// //         'item_id': item.id,
// //         'item_name': item.name,
// //         'item_price': item.price,
// //         'quantity': 1, // Assuming quantity is 1 for simplicity
// //       };
// //     }).toList();
// //
// //     // Save cart history
// //     await FirebaseFirestore.instance.collection('cart_history').add({
// //       'user_id': userId,
// //       'items': itemsList,
// //       'total_price': totalPrice,
// //       'timestamp': FieldValue.serverTimestamp(),
// //     });
// //
// //     print('Cart history saved successfully');
// //   } catch (e) {
// //     print('Error saving cart history: $e');
// //   }
// // }
// //
// //
// // class CartHistoryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Cart History'),
// //         backgroundColor: Colors.black,
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance
// //             .collection('cart_history')
// //             .orderBy('timestamp', descending: true)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Center(child: Text('No cart history available.'));
// //           }
// //
// //           final cartHistory = snapshot.data!.docs;
// //
// //           return ListView.builder(
// //             itemCount: cartHistory.length,
// //             itemBuilder: (context, index) {
// //               final historyItem = cartHistory[index];
// //               final items = historyItem['items'] as List<dynamic>;
// //
// //               return Card(
// //                 margin: EdgeInsets.all(8.0),
// //                 child: ListTile(
// //                   title: Text('Order ${index + 1}'),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       ...items.map((item) => Text('${item['item_name']} - \$${item['item_price']}')),
// //                       SizedBox(height: 8),
// //                       Text('Total: \$${historyItem['total_price']}'),
// //                       Text('Date: ${historyItem['timestamp'].toDate()}'),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
// // lib/controllers/order_history_controller.dart
//
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// // lib/models/order_history.dart
//
// class OrderHistory {
//   final String id;
//   final DateTime date;
//   final String item;
//   final int quantity;
//   final double price;
//
//   OrderHistory({
//     required this.id,
//     required this.date,
//     required this.item,
//     required this.quantity,
//     required this.price,
//   });
//
//   // Convert a JSON map to an OrderHistory instance
//   factory OrderHistory.fromJson(Map<String, dynamic> json) {
//     return OrderHistory(
//       id: json['id'],
//       date: (json['date'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
//       item: json['item'],
//       quantity: json['quantity'],
//       price: json['price'].toDouble(), // Ensure price is a double
//     );
//   }
//
//   // Convert an OrderHistory instance to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'date': date,
//       'item': item,
//       'quantity': quantity,
//       'price': price,
//     };
//   }
// }
//
// class OrderHistoryController extends GetxController {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   var orderHistories = <OrderHistory>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchOrderHistories();
//   }
//
//   // Add a new order history
//   Future<void> addOrderHistory(OrderHistory order) async {
//     try {
//       await _db.collection('order_histories').doc(order.id).set(order.toJson());
//     } catch (e) {
//       print("Failed to add order: $e");
//     }
//   }
//
//   // Remove an order history by ID
//   Future<void> removeOrderHistory(String id) async {
//     try {
//       await _db.collection('order_histories').doc(id).delete();
//     } catch (e) {
//       print("Failed to delete order: $e");
//     }
//   }
//
//   // Fetch order histories
//   void fetchOrderHistories() async {
//     try {
//       var snapshot = await _db.collection('order_histories').get();
//       var fetchedOrders = snapshot.docs.map((doc) => OrderHistory.fromJson(doc.data())).toList();
//       orderHistories.value = fetchedOrders;
//     } catch (e) {
//       print("Failed to fetch orders: $e");
//     }
//   }
// }
//
// class OrderHistoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final OrderHistoryController orderHistoryController = Get.find<OrderHistoryController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order History'),
//       ),
//       body: Obx(() {
//         final orders = orderHistoryController.orderHistories;
//
//         if (orders.isEmpty) {
//           return Center(child: Text('No orders found.'));
//         }
//
//         return ListView.builder(
//           itemCount: orders.length,
//           itemBuilder: (context, index) {
//             final order = orders[index];
//             return ListTile(
//               title: Text(order.item),
//               subtitle: Text('Quantity: ${order.quantity}, Price: \$${order.price}'),
//               trailing: Text(order.date.toLocal().toString()),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
//
// //
// // class OrderHistoryController extends GetxController {
// //   final DatabaseReference _db = FirebaseDatabase.instance.reference().child('order_histories');
// //   var orderHistories = <OrderHistory>[].obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchOrderHistories();
// //   }
// //
// //   // Add a new order history
// //   Future<void> addOrderHistory(OrderHistory order) async {
// //     try {
// //       await _db.child(order.id).set(order.toJson());
// //     } catch (e) {
// //       print("Failed to add order: $e");
// //     }
// //   }
// //
// //   // Remove an order history by ID
// //   Future<void> removeOrderHistory(String id) async {
// //     try {
// //       await _db.child(id).remove();
// //     } catch (e) {
// //       print("Failed to delete order: $e");
// //     }
// //   }
// //
// //   // Fetch order histories
// //   void fetchOrderHistories() {
// //     _db.once().then((DataSnapshot snapshot) {
// //       if (snapshot.value != null) {
// //         var data = snapshot.value as Map;
// //         var fetchedOrders = data.entries.map((entry) => OrderHistory.fromJson(Map<String, dynamic>.from(entry.value))).toList();
// //         orderHistories.value = fetchedOrders;
// //       }
// //     }).catchError((error) {
// //       print("Failed to fetch orders: $error");
// //     });
// //   }
// // }
// //
// // class OrderHistoryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final OrderHistoryController controller = Get.find();
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Order History'),
// //       ),
// //       body: Obx(() {
// //         final orders = controller.orderHistories;
// //
// //         if (orders.isEmpty) {
// //           return Center(child: Text('No orders found.'));
// //         }
// //
// //         return ListView.builder(
// //           itemCount: orders.length,
// //           itemBuilder: (context, index) {
// //             final order = orders[index];
// //             return ListTile(
// //               title: Text(order.item),
// //               subtitle: Text('Quantity: ${order.quantity}, Price: \$${order.price}'),
// //               trailing: Text(order.date.toLocal().toString()),
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }
//
import 'package:coffee/CoffeeApp/Page/Cart_Coffee1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Model/OrderModel_Coffee.dart';
import '../Model/ProductModel_Coffee.dart';
//__________________________________________________________________________
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderHistoryManager extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Observable list of orders
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders(); // Fetch orders when the controller is initialized
  }

  // Fetch orders from Firestore
  Future<void> fetchOrders() async {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    try {
      final querySnapshot = await firestore
          .collection('Users')
          .doc(userID.uid)
          .collection('Orders')
          .orderBy('timestamp', descending: true)
          .get();

      orders.value = querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()!))
          .toList();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  // Add an order to Firestore
  Future<void> addOrderToHistory(OrderModel order) async {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    try {
      await firestore
          .collection('Users')
          .doc(userID.uid)
          .collection('Orders')
          .doc(order.productId) // Ensure unique document IDs
          .set(order.toMap());

      print('Order added to history successfully.');
      fetchOrders(); // Refresh the order history
    } catch (e) {
      print('Error adding order to history: $e');
    }
  }

  // Remove an order from Firestore
  Future<void> removeOrderFromHistory(OrderModel order) async {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    try {
      await firestore
          .collection('Users')
          .doc(userID.uid)
          .collection('Orders')
          .doc(order.productId) // Ensure unique document IDs
          .delete();

      print('Order removed from history successfully.');
      fetchOrders(); // Refresh the order history after removing an order
    } catch (e) {
      print('Error removing order from history: $e');
    }
  }

  // Remove all orders from Firestore
  Future<void> removeAllOrdersFromHistory(List<OrderModel> selectedOrders) async {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    try {
      final querySnapshot = await firestore
          .collection('Users')
          .doc(userID.uid)
          .collection('Orders')
          .get();

      final batch = firestore.batch();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      print('All orders removed from history successfully.');
      fetchOrders(); // Refresh the order history after removing all orders
    } catch (e) {
      print('Error removing all orders from history: $e');
    }
  }

  // Remove selected orders from Firestore
  Future<void> removeSelectedOrdersFromHistory(List<OrderModel> selectedOrders) async {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    try {
      final batch = firestore.batch();

      for (var order in selectedOrders) {
        await firestore
            .collection('Users')
            .doc(userID.uid)
            .collection('Orders')
            .doc(order.productId) // Ensure unique document IDs
            .delete();
      }

      await batch.commit();
      print('Selected orders removed from history successfully.');
      fetchOrders(); // Refresh the order history after removing selected orders
    } catch (e) {
      print('Error removing selected orders from history: $e');
    }
  }

  // Check if an order is in the order history
  bool isInOrderHistory(OrderModel order) {
    return orders.any((o) => o.productId == order.productId);
  }
}

class OrderHistoryPage extends StatelessWidget {
  // Create an instance of OrderHistoryManager
  final OrderHistoryManager orderHistoryManager = Get.find<OrderHistoryManager>();

  // List of selected orders
  final Set<OrderModel> _selectedOrders = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: Text('Order History'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.delete_forever,color:Colors.red),
          //   onPressed: () async {
          //     bool confirm = await _showConfirmationDialog(context ,'Are you sure you want to delete the selected orders?');
          //     if (confirm) {
          //       await orderHistoryManager.removeAllOrdersFromHistory(_selectedOrders.toList());
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text('All orders deleted.')),
          //       );
          //     }
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.delete_forever,color:Colors.red),
            onPressed: () async {
              if (_selectedOrders.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No orders selected.')),
                );
                return;
              }

              bool confirm = await _showConfirmationDialog(context, 'Are you sure you want to delete the selected orders?');
              if (confirm) {
                await orderHistoryManager.removeSelectedOrdersFromHistory(_selectedOrders.toList());
                setState(() {
                  _selectedOrders.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected orders deleted.')),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_forever,color:Colors.green),
            onPressed: () async {
              bool confirm = await _showConfirmationDialog(context, 'Are you sure you want to delete all orders?');
              if (confirm) {
                await orderHistoryManager.removeAllOrdersFromHistory(_selectedOrders.toList());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All orders deleted.')),
                );
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        var ordersList = orderHistoryManager.orders;

        return ordersList.isEmpty
            ? Center(child: Text('No orders found.'))
            : ListView.builder(
          itemCount: ordersList.length,
          itemBuilder: (context, index) {
            var order = ordersList[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Checkbox(
                  value: _selectedOrders.contains(order),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedOrders.add(order);
                      } else {
                        _selectedOrders.remove(order);
                      }
                    });
                  },
                ),
                title: Text('Order #${order.productId}'),
                subtitle: Text('Total: ${order.totalPrice}'),
                trailing: Text('Qty: ${order.quantity}'),
                onTap: () {
                  Get.to(OrderDetailPage(order: order));
                },
              ),
            );
          },
        );
      }),
    );
  }
  Future<bool> _showConfirmationDialog(BuildContext context, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Confirm'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }

  void setState(Null Function() param0) {}
}

class OrderDetailPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.productId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Total Price: ${order.totalPrice}'),
            Text('Quantity: ${order.quantity}'),
            Text('Timestamp: ${order.timestamp.toDate()}'),
            // Add more details if necessary
          ],
        ),
      ),
    );
  }
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
