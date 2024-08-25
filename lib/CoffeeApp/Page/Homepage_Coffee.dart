import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'Cart_Coffee.dart';
import 'Cart_Coffee1.dart';
import 'Profile_Coffee.dart';
import 'favorite_controller.dart';
import '../Model/ProductModel_Coffee.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
  final List<String> _titles = ['HomePage', 'Favorite', 'Cart', 'Profile'];
  final List<IconData> _icons = [
    Icons.home,
    Icons.category,
    Icons.search,
    Icons.person
  ];
  int _selectedIndex = 0;
  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer

    switch (index) {
      case 0:
      // Navigate to HomePage or perform a specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
      // Navigate to CategoriesPage or perform a specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Favoritescreen()),
        );
        break;
      case 2:
      // Navigate to SearchPage or perform a specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cartuser()),
        );
        break;
      case 3:
      // Navigate to ProfilePage or perform a specific action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreens()),
        );
        break;
      default:
      // Handle any additional cases or show a default action
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://png.pngtree.com/background/20230426/original/pngtree-image-of-person-who-is-taking-photos-on-phone-while-holding-picture-image_2481694.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX2RbEu3OEGvZwvwAjpSPVWJmRhvrPbpM4HDxxL6Pehe7cpxI3jhaftLe83Q1hWqSFXRQ&usqp=CAU',
                            ),
                            radius: 40,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'johndoe@example.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.brown.shade600, Colors.brown.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _titles.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            _icons[index],
                            color: _selectedIndex == index
                                ? Colors.yellow
                                : Colors.white,
                          ),
                          title: Text(
                            _titles[index],
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.yellow
                                  : Colors.white,
                              fontWeight: _selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          onTap: () => _onDrawerItemTapped(index),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('coffee').snapshots(),
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
                expandedHeight: 200.0,
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
                                        Expanded(
                                          child: Text(
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
          // return CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       expandedHeight: 250.0,
          //       backgroundColor: Colors.brown.shade500,
          //       shape: ContinuousRectangleBorder(
          //           borderRadius: BorderRadius.only(
          //               bottomLeft: Radius.circular(30),
          //               bottomRight: Radius.circular(30))),
          //       title: Text(
          //         'Coffee Delights',
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold, color: Colors.white),
          //       ),
          //       actions: [
          //         IconButton(
          //             onPressed: () {
          //               Get.to(Favoritescreen());
          //             },
          //             icon: Icon(
          //               Icons.favorite,
          //               color: Colors.white,
          //             )),
          //       ],
          //       flexibleSpace: FlexibleSpaceBar(
          //         background: Image.network(
          //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTh6O0A35h2XES3t6agRfwJMR-QXZSMjCoLfCMztEe0CDGcf4iaBq6zI-t8zv9gU0XMqXo&usqp=CAU',
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //       pinned: true,
          //       floating: true,
          //       snap: true,
          //     ),
          //     SliverGrid(
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         crossAxisSpacing: 10,
          //         mainAxisSpacing: 10,
          //       ),
          //       delegate: SliverChildBuilderDelegate(
          //         (context, index) {
          //           final product = products[index];
          //
          //           return GestureDetector(
          //             onTap: () {
          //               Navigator.pushReplacement(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) =>
          //                       Cartpage(product: product),
          //                 ),
          //               );
          //             },
          //             child: Hero(
          //               tag: staticIconProvider,
          //               transitionOnUserGestures: true,
          //               child: Card(
          //                 elevation: 5,
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Expanded(
          //                       flex: 3,
          //                       child: Image.network(
          //                         product.image,
          //                         fit: BoxFit.cover,
          //                         width: double.infinity,
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: Center(
          //                         child: Padding(
          //                           padding: const EdgeInsets.all(8.0),
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.center,
          //                             children: [
          //                               Text(
          //                                 product.name,
          //                                 style: TextStyle(
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.w500,
          //                                 ),
          //                               ),
          //                               Obx(() {
          //                                 return IconButton(
          //                                   onPressed: () {
          //                                     favoriteController
          //                                         .toggleFavorite(product);
          //                                   },
          //                                   icon: favoriteController
          //                                           .isFavorite(product)
          //                                       ? Icon(Icons.favorite)
          //                                       : Icon(Icons
          //                                           .favorite_border_outlined),
          //                                   color: favoriteController
          //                                           .isFavorite(product)
          //                                       ? Colors.red
          //                                       : Colors.black38,
          //                                 );
          //                               }),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //         childCount: products.length,
          //       ),
          //     ),
          //     SliverToBoxAdapter(
          //       child: ImageSlideshow(
          //         indicatorColor: Colors.brown,
          //         height: 200,
          //         width: double.infinity,
          //         onPageChanged: (value) {
          //           debugPrint('Page changed: $value');
          //         },
          //         autoPlayInterval: 4000,
          //         isLoop: true,
          //         indicatorBottomPadding: 20,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Image.network(
          //               'https://www.nsls.org/hubfs/OvercomingAdversityBlog-Hero-1200x630.png',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Image.network(
          //               'https://149842030.v2.pressablecdn.com/wp-content/uploads/2019/08/Coffee-Coffee-Shop-Website-Template.png',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Image.network(
          //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6g_b7O8pbvLlriut8tSz_LjypT5G9RDMnOg&s',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Image.network(
          //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRckXyXBq6KqwuXneh4YhWiyE4uDGIykCq2uiD2m4qFJtY7Vyfv8R_WO42deeiXPf8quz8&usqp=CAU',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
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



//
// class HomePageinproductdetails extends StatelessWidget {
//   final ProductModel product;
//
//   const HomePageinproductdetails({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     //final FavoriteController favoriteController = Get.put(FavoriteController());
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(10),
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
//                   Image.network(product.image),
//                   Image.network(product.image),
//                   Image.network(product.image),
//                   Image.network(product.image),
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     product.name,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 25),
//                   ),
//                   // IconButton(
//                   //   onPressed: () {
//                   //     Get.to(() => FavoriteScreen());
//                   //   },
//                   //   icon: Icon(
//                   //     Icons.favorite_border_outlined,
//                   //     color: Colors.red,
//                   //   ),
//                   // ),
//                   // Obx(() {
//                   //     return IconButton(onPressed: () {
//                   //       Get.to(FavoriteScreen());
//                   //     }, icon: Icon(Icons.favorite_border_outlined,color: Colors.red,));
//                   //   },
//                   // child: IconButton(onPressed: () {
//                   //
//                   // }, icon: Icon(Icons.favorite_border_outlined)),
//                   // ),
//                 ],
//               ),
//               SizedBox(
//                 height: 6,
//               ),
//               Text(
//                 product.price,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 18),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 product.description,
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     ElevatedButton(
//                         onPressed: () {}, child: Text('Add to Card')),
//                     ElevatedButton(onPressed: () {}, child: Text('Buy now')),
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
//
// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GridView with Favorites'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           final itemId = item['id']!;
//           return FutureBuilder<bool>(
//             future: isFavorite(itemId),
//             builder: (context, snapshot) {
//               final isFavorite = snapshot.data ?? false;
//               return Card(
//                 elevation: 5,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Stack(
//                         children: [
//                           Image.network(
//                             item['image']!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ),
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: IconButton(
//                               icon: Icon(
//                                 isFavorite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color: isFavorite ? Colors.red : Colors.grey,
//                               ),
//                               onPressed: () async {
//                                 await toggleFavorite(itemId, !isFavorite);
//                                 setState(() {}); // Refresh the state
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             item['name']!,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   final List<Map<String, String>> items = [
//     {
//       'id': '1',
//       'image':
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY1NUzssDpA-8zhLTgcIYfMNYKlr20_ZkBUQ&s',
//       'name': 'Item 1',
//     },
//     {
//       'id': '2',
//       'image':
//           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY1NUzssDpA-8zhLTgcIYfMNYKlr20_ZkBUQ&s',
//       'name': 'Item 2',
//     },
//     // Add more items here
//   ];
//
//   Future<bool> isFavorite(String itemId) async {
//     final doc = await _firestore.collection('favorites').doc(itemId).get();
//     return doc.exists;
//   }
//
//   Future<void> toggleFavorite(String itemId, bool isFavorite) async {
//     final userFavoritesRef = _firestore.collection('favorites').doc(itemId);
//     if (isFavorite) {
//       await userFavoritesRef.set({
//         'image': items.firstWhere((item) => item['id'] == itemId)['image']!,
//         'name': items.firstWhere((item) => item['id'] == itemId)['name']!,
//       });
//     } else {
//       await userFavoritesRef.delete();
//     }
//   }
// }

