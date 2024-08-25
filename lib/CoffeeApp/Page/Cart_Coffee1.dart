import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/ProductModel_Coffee.dart';
import 'BottomBar_Coffee.dart';
import 'Cart_Coffee.dart';
import 'Homepage_Coffee.dart';
import 'favorite_controller.dart';

class Cartuser extends StatefulWidget {
  const Cartuser({super.key});

  @override
  State<Cartuser> createState() => _CartuserState();
}

class _CartuserState extends State<Cartuser> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Screen'),
      ),
      body: Obx(() {
        var cartlist = cartController.cartItems;
        return cartlist.isEmpty
            ? Center(child: Text('Your cart is empty.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartlist.length,
                itemBuilder: (context, index) {
                  var cartItem = cartlist[index];
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          cartItem.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        cartItem.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Price: ${cartItem.price.toString()}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          cartController.removeFromCart(cartItem);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.teal[50],
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cartController.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  bool confirm = await _showConfirmationDialog();
                  if (confirm) {
                    cartController.buyCart();
                  }
                },
                child: Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<bool> _showConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Purchase'),
        content: Text('Are you sure you want to buy all items in the cart?'),
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
}

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems(); // Fetch initial cart items from Firestore
  }

  void fetchCartItems() async {
    try {
      final snapshot = await _firestore.collection('cart').get();
      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel.fromFirestore(doc);
      }).toList();
      cartItems.assignAll(items);
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  void addToCart(ProductModel productModel) async {
    try {
      final docRef = _firestore.collection('cart').doc(productModel.id);
      if (!(await docRef.get()).exists) {
        await docRef.set(productModel.toFirestore());
        cartItems.add(productModel);
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  void removeFromCart(ProductModel productModel) async {
    try {
      final docRef = _firestore.collection('cart').doc(productModel.id);
      await docRef.delete();
      cartItems.remove(productModel);
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  void buyCart() async {
    try {
      // Process the purchase
      print('Buying items: ${cartItems.map((item) => item.name).join(', ')}');
      for (var item in cartItems) {
        await _firestore.collection('cart').doc(item.id).delete();
      }
      cartItems.clear();
    } catch (e) {
      print('Error buying cart items: $e');
    }
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      final price = double.tryParse(item.price) ?? 0.0;
      return sum + price;
    });
  }
}
//==============================================================================
// class CartController extends GetxController {
//   var cartItems = <ProductModel>[].obs;
//
//   void addToCart(ProductModel productModel) {
//     if (!cartItems.contains(productModel)) {
//       cartItems.add(productModel);
//     }
//   }
//
//   void removeFromCart(ProductModel productModel) {
//     cartItems.remove(productModel);
//   }
//
//   bool isInCart(ProductModel productModel) {
//     return cartItems.contains(productModel);
//   }
//
//   void buyCart() {
//     // Process the purchase
//     print('Buying items: ${cartItems.map((item) => item.name).join(', ')}');
//     cartItems.clear();
//   }
//
//   // Total price calculation
//   double get totalPrice {
//     return cartItems.fold(0.0, (sum, item) {
//       // Attempt to parse the price; default to 0 if parsing fails
//       final price = double.tryParse(item.price) ?? 0.0;
//       return sum + price;
//     });
//   }
// }
//..............................................................................
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
//   final CartController cartController = Get.find<CartController>();
//
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
//                     ElevatedButton(
//                       onPressed: () {
//                         cartController.addToCart(widget.product);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content:
//                                 Text('${widget.product.name} added to cart'),
//                           ),
//                         );
//                       },
//                       child: Text('Add to Cart'),
//                     ),
//                     SizedBox(width: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         cartController.addToCart(widget.product);
//                         bool confirm = await _showConfirmationDialog();
//                         if (confirm) {
//                           cartController.buyCart();
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Purchase complete!'),
//                             ),
//                           );
//                         }
//                       },
//                       child: Text('Buy Now'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _showConfirmationDialog() {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Purchase'),
//         content: Text('Are you sure you want to buy this item?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Confirm'),
//           ),
//         ],
//       ),
//     ).then((value) => value ?? false);
//   }
// }

class Cartpage extends StatefulWidget {
  final ProductModel product;

  const Cartpage({super.key, required this.product});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.product.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),),
              background: Image.network(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.to(BottenBarChat());
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  cartController.addToCart(widget.product);
                  Get.to(Cartuser());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.name} added to cart'),
                    ),
                  );
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.product.price,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.description,
                      style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              cartController.addToCart(widget.product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${widget.product.name} added to cart'),
                                ),
                              );
                            },
                            child: Text('Add to Cart'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              cartController.addToCart(widget.product);
                              bool confirm = await _showConfirmationDialog();
                              if (confirm) {
                                cartController.buyCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Purchase complete!'),
                                  ),
                                );
                              }
                            },
                            child: Text('Buy Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Purchase'),
        content: Text('Are you sure you want to buy this item?'),
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
}
