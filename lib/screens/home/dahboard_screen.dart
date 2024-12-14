import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../product_details/product_list_screen.dart';
import '../profile/profile_Screen.dart';
import '../wishlist/wishlist_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductListScreen(),
    WishListScreen(),
    CartScreen(),
    UserScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.red,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.green,), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.blue,), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.amber,), label: 'Profile'),
        ],
      ),
    );
  }
}
