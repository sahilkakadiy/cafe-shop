import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/ProductModel_Coffee.dart';


class notificaionpage extends StatefulWidget {
  const notificaionpage({super.key});

  @override
  State<notificaionpage> createState() => _notificaionpageState();
}

class _notificaionpageState extends State<notificaionpage> {
  bool _isNotificationEnabled = true; // State variable for the switch

  void _toggleNotification(bool? value) {
    setState(() {
      _isNotificationEnabled = value ?? false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        title: Text('Notifications',
          style: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Push notifications',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Pause all',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            trailing: Switch(materialTapTargetSize: MaterialTapTargetSize.padded,
              value: _isNotificationEnabled,
              onChanged: _toggleNotification,
            ),
          ),
          ListTile(
            title: Text(
              'Coffee and replies',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            trailing: IconButton(onPressed: () {
              //
            }, icon: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
          ListTile(
            title: Text(
              'From Coffee',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            trailing: IconButton(onPressed: () {
              //
            }, icon: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
        ],
      ),
    );
  }
}


//--------------------------------------------------------------------
//--------------------------------------------------------------------

class HomePagea extends StatelessWidget {
  final List<String> categories = ['Cold', 'Ice', 'Coffee', 'Tea', 'Water', 'Cake'];
  final List<Product> products = [
    Product(name: 'Cold Brew', image: 'https://linktoimage1.com'),
    Product(name: 'Iced Latte', image: 'https://linktoimage2.com'),
    Product(name: 'Americano', image: 'https://linktoimage3.com'),
    // Add more products
  ];
  final FavoriteControllerab favoriteController = Get.put(FavoriteControllerab());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AKTLOC',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Colors.brown.shade500,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
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
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPageb(category: category),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Text(
                              category[0],
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(category),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPagea(product: product),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'product_$index',
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Obx(() {
                                      return IconButton(
                                        onPressed: () {
                                          favoriteController.toggleFavorite(product);
                                        },
                                        icon: Icon(
                                          favoriteController.isFavorite(product)
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                        ),
                                        color: favoriteController.isFavorite(product)
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
              autoPlayInterval: 4000,
              isLoop: true,
              indicatorBottomPadding: 20,
              children: [
                Image.network('https://www.nsls.org/hubfs/OvercomingAdversityBlog-Hero-1200x630.png', fit: BoxFit.cover),
                Image.network('https://149842030.v2.pressablecdn.com/wp-content/uploads/2019/08/Coffee-Coffee-Shop-Website-Template.png', fit: BoxFit.cover),
                Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6g_b7O8pbvLlriut8tSz_LjypT5G9RDMnOg&s', fit: BoxFit.cover),
                Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRckXyXBq6KqwuXneh4YhWiyE4uDGIykCq2uiD2m4qFJtY7Vyfv8R_WO42deeiXPf8quz8&usqp=CAU', fit: BoxFit.cover),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}



// Define your Item model class with necessary fields
class Item {
  final String id;
  final String name;
  final String image;
  final String category;

  Item({required this.id, required this.name, required this.image, required this.category});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      category: map['category'] ?? '',
    );
  }
}

Future<List<Item>> getItemsInCategory(String category) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore.collection('items')
        .where('category', isEqualTo: category)
        .get();

    return querySnapshot.docs.map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>)).toList();
  } catch (e) {
    print('Error fetching items: $e');
    return []; // Return an empty list in case of error
  }
}
class DetailsPagec extends StatelessWidget {
  final String category;

  DetailsPagec({required this.category});

  // Simulating fetching items based on category
  List<Item> getItemsInCategory(String category) {
    // Replace this with your actual data fetching logic
    List<Item> allItems = [
      Item(id: '1', name: 'Item 1', image: 'https://example.com/image1.jpg', category: 'Description 1'),
      Item(id: '2', name: 'Item 2', image: 'https://example.com/image2.jpg', category: 'Description 2'),
      // Add more items as needed
    ];

    return allItems.where((item) => item.name.contains(category)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final itemsInCategory = getItemsInCategory(category);
    final limitedItems = itemsInCategory.take(10).toList(); // Limit to 10 items

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Details'),
      ),
      body: ListView.builder(
        itemCount: limitedItems.length, // Use the limited list
        itemBuilder: (context, index) {
          final item = limitedItems[index]; // Get the item from the limited list
          return ListTile(
            leading: Image.network(item.image),
            title: Text(item.name),
            subtitle: Text(item.category),
          );
        },
      ),
    );
  }
}
// class DetailsPageb extends StatefulWidget {
//   final String category;
//
//   DetailsPageb({required this.category});
//
//   @override
//   _DetailsPagebState createState() => _DetailsPagebState();
// }
//
// class _DetailsPagebState extends State<DetailsPageb> {
//   late Future<List<Item>> _itemsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _itemsFuture = getItemsInCategory(widget.category);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.category} Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddItemPage(), // Navigate to the add item page
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Item>>(
//         future: _itemsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No items found.'));
//           } else {
//             final limitedItems = snapshot.data!.take(10).toList();
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: limitedItems.length,
//               itemBuilder: (context, index) {
//                 final item = limitedItems[index];
//                 return Card(
//                   elevation: 5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Image.network(
//                           item.image,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               item.name,
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class Item {
//   final String name;
//   final String image;
//
//   Item({required this.name, required this.image});
// }


class FavoriteControllerab extends GetxController {
  var favoriteProductsab = <Product>[].obs;

  // Toggle favorite
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      favoriteProductsab.remove(product);
    } else {
      favoriteProductsab.add(product);
    }
  }

  // Check if a product is in favorites
  bool isFavorite(Product product) {
    return favoriteProductsab.contains(product);
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final FavoriteControllerab favoriteController = Get.find();

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPagea(product: product),
          ),
        );
      },
      child: Hero(
        tag: 'product_${product.name}',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            favoriteController.toggleFavorite(product);
                          },
                          icon: Obx(() => Icon(
                            favoriteController.isFavorite(product)
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: favoriteController.isFavorite(product) ? Colors.red : Colors.black38,
                          )),
                        ),
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
  }
}



class CartPagea extends StatelessWidget {
  final Product product;

  CartPagea({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(product.image),
            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Add more product details here
          ],
        ),
      ),
    );
  }
}


//+++++++++++++++++++++===


extension ImagePickerExtension on ImagePicker {
  Future<XFile?> getImage({required ImageSource source}) async {
    return await pickImage(source: source);
  }
}


class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imageUrl;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _addItem() async {
    final product = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      price: _priceController.text,
      image: _imageUrl ?? '',
      description: _descriptionController.text,
    );

    await FirebaseFirestore.instance.collection('products').doc(product.id).set(product.toMap());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: Text('Pick and Upload Image'),
            ),
            if (_imageUrl != null)
              Image.network(_imageUrl!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPageb extends StatefulWidget {
  final String category;

  DetailsPageb({required this.category});

  @override
  _DetailsPagebState createState() => _DetailsPagebState();
}

class _DetailsPagebState extends State<DetailsPageb> {
  late Future<List<ProductModel>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = getItemsInCategory(widget.category);
  }

  Future<List<ProductModel>> getItemsInCategory(String category) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('name', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
    } catch (e) {
      // Handle errors
      return Future.error('Failed to load items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found.'));
          } else {
            final limitedItems = snapshot.data!.take(10).toList();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: limitedItems.length,
              itemBuilder: (context, index) {
                final item = limitedItems[index];
                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

//
// class AddItemPage extends StatefulWidget {
//   @override
//   _AddItemPageState createState() => _AddItemPageState();
// }
//
// class _AddItemPageState extends State<AddItemPage> {
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   String? _imageUrl;
//
//   Future<void> _pickAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().toIso8601String()}');
//       final uploadTask = storageRef.putFile(file);
//       final snapshot = await uploadTask.whenComplete(() => {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//
//       setState(() {
//         _imageUrl = imageUrl;
//       });
//     }
//   }
//
//   Future<void> _addItem() async {
//     final product = ProductModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: _nameController.text,
//       price: _priceController.text,
//       image: _imageUrl ?? '',
//       description: _descriptionController.text,
//     );
//
//     await FirebaseFirestore.instance.collection('products').doc(product.id).set(product.toMap());
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Item'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _priceController,
//               decoration: InputDecoration(labelText: 'Price'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickAndUploadImage,
//               child: Text('Pick and Upload Image'),
//             ),
//             if (_imageUrl != null)
//               Image.network(_imageUrl!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addItem,
//               child: Text('Add Item'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DetailsPageb extends StatefulWidget {
//   final String category;
//
//   DetailsPageb({required this.category});
//
//   @override
//   _DetailsPagebState createState() => _DetailsPagebState();
// }
//
// class _DetailsPagebState extends State<DetailsPageb> {
//   late Future<List<ProductModel>> _itemsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _itemsFuture = getItemsInCategory(widget.category);
//   }
//
//   Future<List<ProductModel>> getItemsInCategory(String category) async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .where('name', isEqualTo: category)
//         .get();
//     return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.category} Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddItemPage(), // Navigate to the add item page
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<ProductModel>>(
//         future: _itemsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No items found.'));
//           } else {
//             final limitedItems = snapshot.data!.take(10).toList();
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: limitedItems.length,
//               itemBuilder: (context, index) {
//                 final item = limitedItems[index];
//                 return Card(
//                   elevation: 5,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 3,
//                         child: Image.network(
//                           item.image,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               item.name,
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
