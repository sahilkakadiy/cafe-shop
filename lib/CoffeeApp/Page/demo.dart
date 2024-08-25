// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'Homepage_Coffee.dart';
//
// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<void> signUp(String email, String password) async {
//     try {
//       await FirebaseFirestore.instance.collection('coffee-user')
//         ..doc(email).get();
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw e.message!;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//
// class LoginPagedd extends StatefulWidget {
//   @override
//   _LoginPageddState createState() => _LoginPageddState();
// }
//
// class _LoginPageddState extends State<LoginPagedd> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 checkValues(context);
//               },
//               child: Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignupPagedd()),
//                 );
//               },
//               child: Text('Create an account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkValues(BuildContext context) {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       print("Incomplete Data");
//       Text("Please fill all the fields");
//     } else {
//       signIn(context, email, password);
//     }
//   }
//
//   Future<void> signIn(
//       BuildContext context, String email, String password) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (credential.user != null) {
//         String uid = credential.user!.uid;
//
//         // Fetch user data from Firestore if needed
//         DocumentSnapshot userDoc =
//             await FirebaseFirestore.instance.collection('User').doc(uid).get();
//
//         if (userDoc.exists) {
//           // Handle user data as needed
//           print("User Data: ${userDoc.data()}");
//         } else {
//           print("No user data found in Firestore");
//         }
//
//         // Proceed with navigation or other logic
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomePage(),
//             )); // Example of navigation
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       print('Login Failed');
//       Text('${e.message} An unknown error occurred');
//     } catch (e) {
//       print(e);
//       print('Error show in catch');
//       Text('An unexpected error occurred: ${e.toString()}');
//     }
//   }
// }
//
// class SignupPagedd extends StatefulWidget {
//   @override
//   _SignupPageddState createState() => _SignupPageddState();
// }
//
// class _SignupPageddState extends State<SignupPagedd> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 checkValues(context);
//               },
//               child: Text('Sign Up'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPagedd()),
//                 );
//               },
//               child: Text('Create an account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkValues(BuildContext context) {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       // Show an alert dialog or snack bar if fields are empty
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Incomplete Data"),
//             content: Text("Please fill all the fields"),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       signIn(context, email, password);
//     }
//   }
//
//   Future<void> signIn(
//       BuildContext context, String email, String password) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (credential.user != null) {
//         String uid = credential.user!.uid;
//
//         // Fetch user data from Firestore if needed
//         DocumentSnapshot userDoc =
//             await FirebaseFirestore.instance.collection('User').doc(uid).get();
//
//         if (userDoc.exists) {
//           // Handle user data as needed
//           print("User Data: ${userDoc.data()}");
//         } else {
//           print("No user data found in Firestore");
//         }
//
//         // Navigate to another screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => HomePage()), // Replace with your home page
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       // Show an alert dialog or snack bar for authentication errors
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Login Failed"),
//             content: Text(e.message ?? 'An unknown error occurred'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       // Show an alert dialog or snack bar for unexpected errors
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text('An unexpected error occurred: ${e.toString()}'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
//
// class HomePageddd extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               context.read<AuthenticationService>().signOut();
//             },
//           ),
//         ],
//       ),
//       body: Center(child: Text('Welcome to the Home Page!')),
//     );
//   }
// }

// second------------------------------------------------

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class AuthenticationService extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//
//   Future<void> signUp(String email, String password) async {
//     try {
//       // Check if a user already exists using Firebase Authentication
//       List<String> signInMethods = await _auth.fetchSignInMethodsForEmail(email);
//       if (signInMethods.isNotEmpty) {
//         throw Exception('User already exists');
//       }
//
//       // Proceed with user creation
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//
//       // Optionally, create a Firestore document for the user
//       await FirebaseFirestore.instance.collection('coffee-user').doc(email).set({
//         'email': email,
//         // Add other fields if needed
//       });
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.message ?? 'An unknown error occurred');
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
//
//
// class LoginPagedd extends StatefulWidget {
//   @override
//   _LoginPageddState createState() => _LoginPageddState();
// }
//
// class _LoginPageddState extends State<LoginPagedd> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 checkValues(context);
//               },
//               child: Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignupPagedd()),
//                 );
//               },
//               child: Text('Create an account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkValues(BuildContext context) {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Incomplete Data"),
//             content: Text("Please fill all the fields"),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       signIn(context, email, password);
//     }
//   }
//
//   Future<void> signIn(BuildContext context, String email, String password) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//
//     try {
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (credential.user != null) {
//         String uid = credential.user!.uid;
//
//         // Fetch user data from Firestore if needed
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('coffeeuser').doc(email).get();
//
//         if (userDoc.exists) {
//           // Handle user data as needed
//           print("User Data: ${userDoc.data()}");
//         } else {
//           print("No user data found in Firestore");
//         }
//
//         // Proceed with navigation or other logic
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomePageddd()), // Example of navigation
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Login Failed"),
//             content: Text(e.message ?? 'An unknown error occurred'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text('An unexpected error occurred: ${e.toString()}'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
// }
//
//
//
// class SignupPagedd extends StatefulWidget {
//   @override
//   _SignupPageddState createState() => _SignupPageddState();
// }
//
// class _SignupPageddState extends State<SignupPagedd> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 checkValues(context);
//               },
//               child: Text('Sign Up'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginPagedd()),
//                 );
//               },
//               child: Text('Already have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void checkValues(BuildContext context) {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     if (email.isEmpty || password.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Incomplete Data"),
//             content: Text("Please fill all the fields"),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       signUp(context, email, password);
//     }
//   }
//
//   Future<void> signUp(BuildContext context, String email, String password) async {
//     final AuthenticationService authService = Provider.of<AuthenticationService>(context, listen: false);
//
//     try {
//       await authService.signUp(email, password);
//
//       // Navigate to home page or other logic after successful sign-up
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePageddd()), // Replace with your home page
//       );
//     } on FirebaseAuthException catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Sign-Up Failed"),
//             content: Text(e.message ?? 'An unknown error occurred'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text('An unexpected error occurred: ${e.toString()}'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//
// }
//
//
//
//
// class HomePageddd extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               context.read<AuthenticationService>().signOut();
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPagedd()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(child: Text('Welcome to the Home Page!')),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// API Service Class

class ApiService {
  static var client = http.Client();

  // Fetch a list of coffee products
  static Future<List<Coffeemodel>?> fetchProducts() async {
    try {
      final response = await client.get(Uri.parse('https://api.sampleapis.com/coffee/hot'));

      if (response.statusCode == 200) {
        // Decode JSON response to a list of Coffeemodel
        var jsonString = response.body;
        return List<Coffeemodel>.from(
            json.decode(jsonString).map((x) => Coffeemodel.fromJson(x))
        );
      } else {
        print('Failed to load products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
}
// Product Controller
class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Coffeemodel>[].obs;
  var favoriteProducts = <Coffeemodel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    loadFavorites();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ApiService.fetchProducts();
      if (products != null) {
        productList.assignAll(products);
        favoriteProducts.assignAll(productList.where((p) => p.isFavorite));
      }
    } finally {
      isLoading(false);
    }
  }

  void toggleFavorite(Coffeemodel product) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      favoriteProducts.add(product);
      await _firestore
          .collection('favorite-product')
          .doc(product.id.toString())
          .set(product.toJson());
    } else {
      favoriteProducts.remove(product);
      await _firestore
          .collection('favorite-product')
          .doc(product.id.toString())
          .delete();
    }
    productList.refresh(); // Update the list to reflect changes
  }

  void loadFavorites() async {
    var snapshot = await _firestore.collection('favorite-product').get();
    var favorites = snapshot.docs.map((doc) {
      var data = doc.data();
      return Coffeemodel.fromJson(data);
    }).toList();
    favoriteProducts.assignAll(favorites);
  }
}

// App String Constants
class AppString {
  static final fetchApiData = "Fetch API Data";
  static final Coffeelist = "Product List";
}

// Product List View Widget
class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.Coffeelist),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.to(FavoriteProductsScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.productList.isEmpty) {
          return Center(child: Text('No products found'));
        } else {
          return ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              final product = productController.productList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(product.image,fit: BoxFit.contain,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(product.ingredients.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(product.description),
                      ),
                      IconButton(
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          productController.toggleFavorite(product);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class FavoriteProductsScreen extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: Obx(() {
        if (productController.favoriteProducts.isEmpty) {
          return Center(child: Text('No favorite products found'));
        } else {
          return ListView.builder(
            itemCount: productController.favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = productController.favoriteProducts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.image),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(product.isFavorite.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(product.description),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

// Coffee API Model

List<Coffeemodel> coffeemodelFromJson(String str) => List<Coffeemodel>.from(json.decode(str).map((x) => Coffeemodel.fromJson(x)));

String coffeemodelToJson(List<Coffeemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Coffeemodel {
//   String title;
//   String description;
//   List<String> ingredients;
//   String image;
//   int id;
//   bool isFavorite; // New field to track favorite status
//
//   Coffeemodel(String jsonString, {
//     required this.title,
//     required this.description,
//     required this.ingredients,
//     required this.image,
//     required this.id,
//     this.isFavorite = false, // Default to false
//   });
//
//   factory Coffeemodel.fromJson(Map<String, dynamic> json) => Coffeemodel(
//     title: json["title"],
//     description: json["description"],
//     ingredients: List<String>.from(json["ingredients"].map((x) => x)),
//     image: json["image"],
//     id: json["id"],
//     isFavorite: json["isFavorite"] ?? false, // Default to false if not present
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "description": description,
//     "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
//     "image": image,
//     "id": id,
//     "isFavorite": isFavorite, // Include isFavorite in JSON
//   };
// }
class Coffeemodel {
  String title;
  String description;
  List<String> ingredients;
  String image;
  int id;
  bool isFavorite; // Optional

  Coffeemodel({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.id,
    this.isFavorite = false,
  });

  factory Coffeemodel.fromJson(Map<String, dynamic> json) => Coffeemodel(
    title: json["title"],
    description: json["description"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    image: json["image"],
    id: json["id"],
    isFavorite: json["isFavorite"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "image": image,
    "id": id,
    "isFavorite": isFavorite,
  };
}



class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Home', 'Categories', 'Search', 'Profile'];
  final List<IconData> _icons = [
    Icons.home,
    Icons.category,
    Icons.search,
    Icons.person
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://png.pngtree.com/background/20230426/original/pngtree-image-of-person-who-is-taking-photos-on-phone-while-holding-picture-image_2481694.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Drawer content
          Container(
            color: Colors.black.withOpacity(0.5), // Overlay to darken the background
            child: Column(
              children: [
                // Custom header with image and text
                Container(
                  height: 200, // Adjust the height as needed
                  child: DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile image
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX2RbEu3OEGvZwvwAjpSPVWJmRhvrPbpM4HDxxL6Pehe7cpxI3jhaftLe83Q1hWqSFXRQ&usqp=CAU',
                          ),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        // User name
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
                        // User email
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
                // Custom ListTiles with icons and dynamic styles
                Expanded(
                  child: ListView.builder(
                    itemCount: _titles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          _icons[index],
                          color: _selectedIndex == index
                              ? Colors.yellow // Highlighted color
                              : Colors.white,
                        ),
                        title: Text(
                          _titles[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.yellow // Highlighted color
                                : Colors.white,
                            fontWeight: _selectedIndex == index
                                ? FontWeight.bold // Bold for selected item
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          // Handle navigation
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                // Custom footer with a button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text('Logout'),
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
    );
  }
}
