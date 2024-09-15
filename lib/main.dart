import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'CoffeeApp/Page/BottomBar_Coffee.dart';
import 'CoffeeApp/Page/Cart_Coffee1.dart';
import 'CoffeeApp/Page/History_Coffee.dart';
import 'CoffeeApp/Page/Homepage_Coffee.dart';
import 'CoffeeApp/Page/Signup_Coffee.dart';
import 'CoffeeApp/Page/favorite_controller.dart';
import 'CoffeeApp/Page/splashscreen_Coffee.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Dependency injection
  Get.put(FavoriteController());
  Get.put(OrderHistoryManager());
  Get.put(CartController());
 //Get.put(OrderHistoryController());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticationService(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthenticationService>();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return Splash();
          } else {
            return BottenBarChat();
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}




//
// void main() async{
//   //GetxController
//   // final FavoriteController favoriteController = Get.put(FavoriteController());
//   Get.put(FavoriteController());
//   Get.put(CartController());
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp( MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AuthenticationService(),
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Firebase Auth',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: AuthGate(),
//       ),
//     );
//   }
// }
//
// class AuthGate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthenticationService>();
//
//     return StreamBuilder<User?>(
//       stream: authService.authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final User? user = snapshot.data;
//           if (user == null) {
//             return Splash();
//           } else {
//             return HomePage();
//           }
//         }
//         return Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
//


