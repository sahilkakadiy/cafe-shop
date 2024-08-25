// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:get/get.dart';
//
// import '../Model/ProductModel_Coffee.dart';
// import 'Cart_Coffee.dart';
// import 'Homepage_Coffee.dart';
// import 'favorite_controller.dart';
//
// // class Cartuser extends StatefulWidget {
// //   const Cartuser({super.key});
// //
// //   @override
// //   State<Cartuser> createState() => _CartuserState();
// // }
// //
// // class _CartuserState extends State<Cartuser> {
// //   final CartController cartController = Get.find<CartController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Cart Screen'),
// //       ),
// //       body: Obx(() {
// //         var cartlist = cartController.cartItems;
// //         return cartlist.isEmpty
// //             ? Center(child: Text('Your cart is empty.'))
// //             : Column(
// //                 children: [
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: cartlist.length,
// //                       itemBuilder: (context, index) {
// //                         var cartItem = cartlist[index];
// //                         return ListTile(
// //                           title: Text(cartItem.name),
// //                           trailing: IconButton(
// //                             icon: Icon(Icons.remove_circle),
// //                             onPressed: () {
// //                               cartController.removeFromCart(cartItem);
// //                             },
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: Text(
// //                       'Total: ${cartController.totalPrice.toStringAsFixed(2)}',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               );
// //       }),
// //       bottomNavigationBar: BottomAppBar(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: [
// //             ElevatedButton(
// //               onPressed: () async {
// //                 // Confirmation dialog before buying
// //                 bool confirm = await _showConfirmationDialog();
// //                 if (confirm) {
// //                   cartController.buyCart();
// //                 }
// //               },
// //               // onPressed: () {
// //               //   cartController.buyCart();
// //               // },
// //               child: Text('Buy Now'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Future<bool> _showConfirmationDialog() {
// //     return showDialog<bool>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Confirm Purchase'),
// //         content: Text('Are you sure you want to buy all items in the cart?'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(false),
// //             child: Text('Cancel'),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.of(context).pop(true),
// //             child: Text('Confirm'),
// //           ),
// //         ],
// //       ),
// //     ).then((value) => value ?? false);
// //   }
// // }
// //
// // class CartController extends GetxController {
// //   var cartItems = <ProductModel>[].obs;
// //
// //   void addToCart(ProductModel productModel) {
// //     if (!cartItems.contains(productModel)) {
// //       cartItems.add(productModel);
// //     }
// //   }
// //
// //   void removeFromCart(ProductModel productModel) {
// //     cartItems.remove(productModel);
// //   }
// //
// //   bool isInCart(ProductModel productModel) {
// //     return cartItems.contains(productModel);
// //   }
// //
// //   void buyCart() {
// //     // Process the purchase
// //     print('Buying items: ${cartItems.map((item) => item.name).join(', ')}');
// //     cartItems.clear();
// //   }
// //
// //   // Total price calculation
// //   double get totalPrice {
// //     return cartItems.fold(0.0, (sum, item) {
// //       // Attempt to parse the price; default to 0 if parsing fails
// //       final price = double.tryParse(item.price) ?? 0.0;
// //       return sum + price;
// //     });
// //   }
// // }
//
// class Cartpage extends StatefulWidget {
//   final ProductModel product;
//
//   const Cartpage({super.key, required this.product});
//
//   @override
//   State<Cartpage> createState() => _CartpageState();
// }
//
// class _CartpageState extends State<Cartpage> {
//   //final CartController cartController = Get.find<CartController>();
//   // final FavoriteController favoriteController =
//   //     Get.find<FavoriteController>(); // Ensure this is defined
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BackButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomePage(),
//                       ));
//                 },
//               ),
//               ImageSlideshow(
//                 indicatorColor: Colors.blue,
//                 height: 300,
//                 onPageChanged: (value) {
//                   debugPrint('Page changed: $value');
//                 },
//                 autoPlayInterval: 4000,
//                 isLoop: true,
//                 children: [
//                   Image.network(widget.product.image),
//                   Image.network(widget.product.image),
//                   Image.network(widget.product.image),
//                   Image.network(widget.product.image),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     widget.product.name,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25),
//                   ),
//                   // Obx(() {
//                   //   return IconButton(
//                   //     onPressed: () {
//                   //       favoriteController.toggleFavorite(widget.product);
//                   //     },
//                   //     icon: Icon(
//                   //       favoriteController.isFavorite(widget.product)
//                   //           ? Icons.favorite
//                   //           : Icons.favorite_border_outlined,
//                   //       color: Colors.red,
//                   //     ),
//                   //   );
//                   // }),
//                 ],
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Text(
//                 widget.product.price,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 widget.product.description,
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     // Obx(() {
//                     //   return ElevatedButton(
//                     //     onPressed: () {
//                     //       cartController.addToCart(widget.product);
//                     //     },
//                     //     child: Text('Add to Cart'), // Fixed text typo
//                     //   );
//                     // }),
//                     // SizedBox(width: 10), // Added spacing between buttons
//                     // Obx(() {
//                     //   return ElevatedButton(
//                     //     onPressed: () {
//                     //       cartController.addToCart(widget.product);
//                     //       cartController.buyCart();
//                     //     },
//                     //     child: Text('Buy Now'), // Fixed text typo
//                     //   );
//                     // }),
//           ElevatedButton(
//             onPressed: () {
//               //cartController.addToCart(widget.product);
//             },
//             child: Text('Add to Cart'), // Fixed text typo
//           ),
//         ElevatedButton(
//           onPressed: () {
//             // cartController.addToCart(widget.product);
//             // cartController.buyCart();
//           },
//           child: Text('Buy Now'), // Fixed text typo
//         ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
