import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/screens/account_screen.dart';
import 'package:online_groceries_app/screens/cart_screen.dart';
import 'package:online_groceries_app/screens/explore_screen.dart';
import 'package:online_groceries_app/screens/shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  // Screens to navigate between
  final List<Widget> _screens = [
    ShopScreen(),
    ExploreScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Shop'),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
