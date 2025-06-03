import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/product.dart';
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
  int _currentIndex = 0;
  List<Product> allProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    const url =
        'https://raw.githubusercontent.com/Vernika15/GroceryApp/refs/heads/main/assets/home_data.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categories'];
      final List<Product> products = [];

      for (var cat in categories) {
        for (var prod in cat['products']) {
          products.add(Product.fromJson(prod));
        }
      }

      setState(() {
        allProducts = products;
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      debugPrint('Failed to load product data');
    }
  }

  // Screens to navigate between
  List<Widget> get _screens => [
    ShopScreen(),
    ExploreScreen(),
    CartScreen(allProducts: allProducts),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
