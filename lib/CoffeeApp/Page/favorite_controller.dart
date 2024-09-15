import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/OrderModel_Coffee.dart';
import '../Model/ProductModel_Coffee.dart';
import 'Cart_Coffee.dart';
import 'Cart_Coffee1.dart';
import 'History_Coffee.dart';

// class FavoriteController extends
//     GetxController {
//   var favoriteitem = <ProductModel>[].obs;
//
//
//   void toggalcase(ProductModel productModel) {
//     if (favoriteitem.contains(productModel)) {
//       favoriteitem.remove(productModel);
//     } else {
//       favoriteitem.add(productModel);
//     }
//
//     bool iscolor = false;
//
//     bool favorite (ProductModel productModel) {
//       return favoriteitem.contains(productModel);
//     }
//   }
// }

// class FavoriteController extends GetxController {
//   var favoriteItems = <ProductModel>[].obs;
//
//   // Toggles the state of a product between favorite and non-favorite
//   void toggleFavorite(ProductModel productModel) {
//     if (favoriteItems.contains(productModel)) {
//       favoriteItems.remove(productModel);
//     } else {
//       favoriteItems.add(productModel);
//     }
//   }
//
//   // Checks if a product is in the favorites list
//   bool isFavorite(ProductModel productModel) {
//     return favoriteItems.contains(productModel);
//   }
// }
//await
//async
//Future

// List - Map
// List - toString

//obs
//Obx
//GetController
//
// class Favoritescreen extends StatefulWidget {
//   const Favoritescreen({super.key});
//
//   @override
//   State<Favoritescreen> createState() => _FavoritescreenState();
// }
//
// class _FavoritescreenState extends State<Favoritescreen> {
//   final FavoriteController favoriteController = Get.find<FavoriteController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Products'),
//       ),
//       body: Obx(() {
//         var favoritelist = favoriteController.favoriteItems;
//
//         return favoritelist.isEmpty
//             ? Center(
//                 child: Text('No favorite products found'),
//               )
//             : ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: favoritelist.length,
//                 itemBuilder: (context, index) {
//                   var favoriteItem = favoritelist[index];
//                   return Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           Get.to(
//                               Cartpage(product: favoriteItem));
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   favoriteItem.image,
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       favoriteItem.name,
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     SizedBox(height: 4),
//                                     Text(
//                                       favoriteItem.price,
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 14,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ));
//                   //
//                   // return Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: GestureDetector(
//                   //     onTap: () {
//                   //       Get.to(HomePageinproductdetails(product: favoriteItem));
//                   //     },
//                   //     child: Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Padding(
//                   //           padding: const EdgeInsets.all(8.0),
//                   //           child: Image.network(favoriteItem.image),
//                   //         ),
//                   //         Text(
//                   //           favoriteItem.name,
//                   //           style: TextStyle(
//                   //               color: Colors.black,
//                   //               fontWeight: FontWeight.bold,
//                   //               fontSize: 25),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // );
//                 },
//               );
//       }),
//     );
//   }
// }
//------------------------------------------------------------------------------
class FavoriteController extends GetxController {
  var favoriteItems = <ProductModel>[].obs;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void toggleFavorite(ProductModel productModel) {
    final userID = firebaseAuth.currentUser;

    if (userID == null) {
      print('User not logged in.');
      return;
    }

    if (favoriteItems.contains(productModel)) {
      favoriteItems.remove(productModel);
      removeFavoriteData(productModel, userID.uid);
    } else {
      favoriteItems.add(productModel);
      addFavoriteData(productModel, userID.uid);
    }
  }

  bool isFavorite(ProductModel productModel) {
    return favoriteItems.contains(productModel);
  }

  Future<void> addFavoriteData(ProductModel product, String uid) async {
    final userID = firebaseAuth.currentUser;

    if (userID != null) {
      await firestore
          .collection('Favorite')
          .doc(userID.uid)
          .collection('CoffeeItem')
          .doc(product.id)
          .set(product.toMap());

      print('Product added to favorites successfully.');
    } else {
      print('User not logged in.');
    }
  }

  Future<void> removeFavoriteData(ProductModel product, String uid) async {
    final userID = firebaseAuth.currentUser;

    if (userID != null) {
      await firestore
          .collection('Favorite')
          .doc(userID.uid)
          .collection('CoffeeItem')
          .doc(product.id)
          .delete();

      print('Product removed from favorites successfully.');
    } else {
      print('User not logged in.');
    }
  }
}
//------------------------------------------------------------------------------

// all statemengement in flutter

// juna ma junu Provider

// class FavoriteController extends GetxController {
//   var favoriteItems = <ProductModel>[].obs;
//
//   // Toggles the state of a product between favorite and non-favorite
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   void toggleFavorite(ProductModel productModel) {
//
//     final  userID = firebaseAuth.currentUser;
//
//
//     if (favoriteItems.contains(productModel)) {
//       favoriteItems.remove(productModel);
//     } else {
//       favoriteItems.add(productModel);
//       addFavoriteData(productModel, userID!.uid);
//       removeFavoriteData(productModel, userID!.uid);
//     }
//   }
//
//   //git init
//   //git add .
//   //git commit  "dashboard change"  - >  git push
//   // git commit -n "seconde push"
//   // git commit -u
//   // Checks if a product is in the favorites list
//   bool isFavorite(ProductModel productModel) {
//     return favoriteItems.contains(productModel);
//   }
// //kaushaldhameliya1979@gmail.com
//   // kushal
//   // kausha.0
//   // Future<void> AddFavoritedata(ProductModel product,String userID) async {
//   //
//   //   final  userID = firebaseAuth.currentUser;
//   //
//   //   if(userID != null){
//   //     firestore.collection('Favorite').doc(userID.uid).collection('CoffeeItem').doc(product.id).set(product.toFirestore());
//   //   }
//   //   await firestore.collection('favorite');
//   // }
//
//   Future<void> addFavoriteData(ProductModel product, String uid) async {
//     // Get the current user
//     final userID = FirebaseAuth.instance.currentUser;
//
//     if (userID != null) {
//       // Get the Firestore instance
//       final firestore = FirebaseFirestore.instance;
//
//       // Add product to the user's 'Favorite' collection
//       await firestore
//           .collection('Favorite')
//           .doc(userID.uid)
//           .collection('CoffeeItem')
//           .doc(product.id)
//           .set(product.toMap()); // Use toMap() to convert the product to a map
//
//       print('Product added to favorites successfully.');
//     } else {
//       print('User not logged in.');
//     }
//   }
//   Future<void> removeFavoriteData(ProductModel product, String uid) async {
//     // Get the current user
//     final userID = FirebaseAuth.instance.currentUser;
//
//     if (userID != null) {
//       // Get the Firestore instance
//       final firestore = FirebaseFirestore.instance;
//
//       // Add product to the user's 'Favorite' collection
//       await firestore
//           .collection('Favorite')
//           .doc(userID.uid)
//           .collection('CoffeeItem')
//           .doc(product.id)
//           .set(product.toMap()); // Use toMap() to convert the product to a map
//
//       print('Product added to favorites successfully.');
//     } else {
//       print('User not logged in.');
//     }
//   }
//
// }

class Favoritescreen extends StatefulWidget {
  const Favoritescreen({super.key});

  @override
  State<Favoritescreen> createState() => _FavoritescreenState();
}

class _FavoritescreenState extends State<Favoritescreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final CartController cartController = Get.find<CartController>();

  //final OrderHistoryController orderHistoryController = Get.find<OrderHistoryController>();
  final OrderHistoryManager orderHistoryManager =
      Get.find<OrderHistoryManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: Obx(() {
        var favoritelist = favoriteController.favoriteItems;

        return favoritelist.isEmpty
            ? Center(
                child: Text('No favorite products found'),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: favoritelist.length,
                itemBuilder: (context, index) {
                  var favoriteItem = favoritelist[index];
                  return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(Cartpage(product: favoriteItem));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  favoriteItem.image,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      favoriteItem.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      favoriteItem.price,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            cartController
                                                .addToCart(favoriteItem);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      '${favoriteItem.name} added to cart')),
                                            );
                                          },
                                          child: Text('Add to Cart'),
                                        ),
                                        SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () async {
                                            cartController
                                                .addToCart(favoriteItem);
                                            bool confirm =
                                                await _showConfirmationDialog();
                                            if (confirm) {
                                              // Create a temporary order model for the purchase
                                              final order = OrderModel(
                                                productId: DateTime.now()
                                                    .toIso8601String(),
                                                // Use timestamp or unique ID
                                                quantity: 1,
                                                // Assuming one item per order
                                                totalPrice: double.parse(
                                                    favoriteItem.price),
                                                timestamp: Timestamp.now(),
                                              );

                                              // Add to order history
                                              await orderHistoryManager
                                                  .addOrderToHistory(order);

                                              // Proceed with cart purchase
                                              cartController.buyCart();

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Purchase complete!')),
                                              );
                                            }
                                          },
                                          child: Text('Buy Now'),
                                        ),
                                        // ElevatedButton(
                                        //   onPressed: () async {
                                        //     cartController.addToCart(favoriteItem);
                                        //     bool confirm = await _showConfirmationDialog();
                                        //     if (confirm) {
                                        //       cartController.buyCart();
                                        //       ScaffoldMessenger.of(context).showSnackBar(
                                        //         SnackBar(content: Text('Purchase complete!')),
                                        //       );
                                        //     }
                                        //   },
                                        //   child: Text('Buy Now'),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                  //
                  // return Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Get.to(HomePageinproductdetails(product: favoriteItem));
                  //     },
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Image.network(favoriteItem.image),
                  //         ),
                  //         Text(
                  //           favoriteItem.name,
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 25),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              );
      }),
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
