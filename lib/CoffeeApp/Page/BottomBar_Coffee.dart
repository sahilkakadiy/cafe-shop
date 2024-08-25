import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../CoffeeApp/Page/Homepage_Coffee.dart';
import 'Cart_Coffee1.dart';
import 'Deshbord_Coffee.dart';
import 'Profile_Coffee.dart';
import 'favorite_controller.dart';
//
// class BottenBarChat extends StatefulWidget {
//   const BottenBarChat({super.key});
//
//   @override
//   State<BottenBarChat> createState() => _BottenBarChatState();
// }
//
// class _BottenBarChatState extends State<BottenBarChat> {
//   int _selectedIndex = 0;
//   final List<Widget> _pages = [
//     Deshboardcoffee(),
//     Favoritescreen(),
//     HomePage(),
//     ProfilePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//  // final CartController cartController = Get.find<CartController>();
//
//
//   final List<String> _titles = ['Home', 'Categories', 'Search', 'Profile'];
//   final List<IconData> _icons = [
//     Icons.home,
//     Icons.category,
//     Icons.search,
//     Icons.person
//   ];
//
//   int selectedIndex = 0;
//
//   void _onDrawerItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pop(context); // Close the drawer
//
//     switch (index) {
//       case 0:
//       // Navigate to HomePage or perform a specific action
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//         break;
//       case 1:
//       // Navigate to CategoriesPage or perform a specific action
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Favoritescreen()),
//         );
//         break;
//       case 2:
//       // Navigate to SearchPage or perform a specific action
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//         break;
//       case 3:
//       // Navigate to ProfilePage or perform a specific action
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage()),
//         );
//         break;
//       default:
//       // Handle any additional cases or show a default action
//         break;
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.black),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, color: Colors.black),
//             label: 'Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications, color: Colors.black),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle, color: Colors.black),
//             label: 'Profile',
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Image.network(
//                 'https://png.pngtree.com/background/20230426/original/pngtree-image-of-person-who-is-taking-photos-on-phone-while-holding-picture-image_2481694.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 200,
//                     child: DrawerHeader(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: NetworkImage(
//                               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX2RbEu3OEGvZwvwAjpSPVWJmRhvrPbpM4HDxxL6Pehe7cpxI3jhaftLe83Q1hWqSFXRQ&usqp=CAU',
//                             ),
//                             radius: 40,
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             'John Doe',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 10.0,
//                                   color: Colors.black.withOpacity(0.5),
//                                   offset: Offset(2.0, 2.0),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             'johndoe@example.com',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Colors.brown.shade600, Colors.brown.shade800],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(30),
//                           bottomRight: Radius.circular(30),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 8,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _titles.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: Icon(
//                             _icons[index],
//                             color: _selectedIndex == index
//                                 ? Colors.yellow
//                                 : Colors.white,
//                           ),
//                           title: Text(
//                             _titles[index],
//                             style: TextStyle(
//                               color: _selectedIndex == index
//                                   ? Colors.yellow
//                                   : Colors.white,
//                               fontWeight: _selectedIndex == index
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                             ),
//                           ),
//                           onTap: () => _onDrawerItemTapped(index),
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle button press
//                       },
//                       child: Text(
//                         'Logout',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.w100),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.brown.shade700,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }

class BottenBarChat extends StatefulWidget {
  const BottenBarChat({super.key});

  @override
  State<BottenBarChat> createState() => _BottenBarChatState();
}

class _BottenBarChatState extends State<BottenBarChat> {
  final List<Widget> _pages = [
    HomePage(),  // Home
    Favoritescreen(),   // Categories
    Cartuser(),         // Search
    ProfileScreens(),      // Profile
  ];


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined, color: Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
class AppDrawer extends StatelessWidget {
  final List<String> titles;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.titles,
    required this.icons,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          icons[index],
                          color: selectedIndex == index
                              ? Colors.yellow
                              : Colors.white,
                        ),
                        title: Text(
                          titles[index],
                          style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.yellow
                                : Colors.white,
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        onTap: () => onItemSelected(index),
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
    );
  }
}
