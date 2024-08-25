import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Model/ProductModel_Coffee.dart';
import 'Cart_Coffee.dart';
import 'Cart_Coffee1.dart';
import 'favorite_controller.dart';

class Deshboardcoffee extends StatefulWidget {
  const Deshboardcoffee({super.key});

  @override
  State<Deshboardcoffee> createState() => _DeshboardcoffeeState();
}

class _DeshboardcoffeeState extends State<Deshboardcoffee> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Producted').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available'));
          }

          final products = snapshot.data!.docs
              .map((doc) =>
              ProductModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                backgroundColor: Colors.brown.shade500,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                title: Text(
                  'Coffee Delights',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(Favoritescreen());
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTh6O0A35h2XES3t6agRfwJMR-QXZSMjCoLfCMztEe0CDGcf4iaBq6zI-t8zv9gU0XMqXo&usqp=CAU',
                    fit: BoxFit.cover,
                  ),
                ),
                pinned: true,
                floating: true,
                snap: true,
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = products[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Cartpage(product: product),
                          ),
                        );
                      },
                      child: Hero(
                        tag: staticIconProvider,
                        transitionOnUserGestures: true,
                        child: Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Obx(() {
                                          return IconButton(
                                            onPressed: () {
                                              favoriteController
                                                  .toggleFavorite(product);
                                            },
                                            icon: favoriteController
                                                .isFavorite(product)
                                                ? Icon(Icons.favorite)
                                                : Icon(Icons
                                                .favorite_border_outlined),
                                            color: favoriteController
                                                .isFavorite(product)
                                                ? Colors.red
                                                : Colors.black38,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: products.length,
                ),
              ),
              SliverToBoxAdapter(
                child: ImageSlideshow(
                  indicatorColor: Colors.brown,
                  height: 200,
                  width: double.infinity,
                  onPageChanged: (value) {
                    debugPrint('Page changed: $value');
                  },
                  autoPlayInterval: 4000,
                  isLoop: true,
                  indicatorBottomPadding: 20,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://www.nsls.org/hubfs/OvercomingAdversityBlog-Hero-1200x630.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://149842030.v2.pressablecdn.com/wp-content/uploads/2019/08/Coffee-Coffee-Shop-Website-Template.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6g_b7O8pbvLlriut8tSz_LjypT5G9RDMnOg&s',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRckXyXBq6KqwuXneh4YhWiyE4uDGIykCq2uiD2m4qFJtY7Vyfv8R_WO42deeiXPf8quz8&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
          // return GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 10,
          //       mainAxisSpacing: 10),
          //   itemCount: products.length,
          //   itemBuilder: (context, index) {
          //     final product = products[index];
          //
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.pushReplacement(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>
          //                   HomePageinproductdetails(product: product),
          //             ));
          //       },
          //       child: Hero(
          //         tag: staticIconProvider,
          //         transitionOnUserGestures: true,
          //         child: Card(
          //           elevation: 5,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               // Display the image
          //               Expanded(
          //                 flex: 3,
          //                 child: Image.network(
          //                   product.image,
          //                   fit: BoxFit.cover,
          //                   width: double.infinity,
          //                 ),
          //               ),
          //               // Display the name
          //               Expanded(
          //                 child: Center(
          //                   child: Padding(
          //                     padding: const EdgeInsets.all(8.0),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       crossAxisAlignment:
          //                           CrossAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           product.name,
          //                           style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.w500,
          //                           ),
          //                         ),
          //                         Obx(() {
          //                           return IconButton(
          //                             onPressed: () {
          //                               favoriteController
          //                                   .toggleFavorite(product);
          //                               // Get.to(() => FavoriteScreen());
          //                             },
          //                             icon: favoriteController
          //                                     .isFavorite(product)
          //                                 ? Icon(Icons.favorite)
          //                                 : Icon(Icons
          //                                     .favorite_border_outlined),
          //                             color: favoriteController
          //                                     .isFavorite(product)
          //                                 ? Colors.red
          //                                 : Colors.black38,
          //                           );
          //                         }),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //
          //     // return Column(
          //     //   children: [
          //     //     Image.network(product.image),
          //     //     Text(product.name),
          //     //     ListTile(
          //     //          // leading: Image.network(product.image),
          //     //           // title: Text(product.name),
          //     //           // subtitle: Text('${product.price}'),
          //     //           onTap: () {
          //     //             // Handle the product tap
          //     //             Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => HomePageinproductdetails(product: product),));
          //     //             //Get.to(HomePageinproductdetails(product: product));
          //     //             // showDialog(
          //     //             //   barrierDismissible: true,
          //     //             //   context: context,
          //     //             //   builder: (context) => AlertDialog(
          //     //             //     //title: Text(product.name),
          //     //             //     content: SingleChildScrollView(
          //     //             //       scrollDirection: Axis.vertical,
          //     //             //       child: Column(
          //     //             //         crossAxisAlignment: CrossAxisAlignment.start,
          //     //             //         children: <Widget>[
          //     //             //           Padding(
          //     //             //             padding: const EdgeInsets.all(8.0),
          //     //             //             child: Center(child: Image.network(product.image,)),
          //     //             //           ),
          //     //             //           SizedBox(height: 8.0),
          //     //             //           Text('Price: ${product.price}'),
          //     //             //           SizedBox(height: 8.0),
          //     //             //           Text(product.description,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.black),),
          //     //             //         ],
          //     //             //       ),
          //     //             //     ),
          //     //             //     actions: <Widget>[
          //     //             //       TextButton(
          //     //             //         child: Text('Close'),
          //     //             //         onPressed: () {
          //     //             //           Navigator.of(context).pop();
          //     //             //         },
          //     //             //       ),
          //     //             //     ],
          //     //             //   ),
          //     //             // );
          //     //           },
          //     //     ),
          //     //   ],
          //     // );
          //   },
          // );
        },
      ),

    );
  }
}
