import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/category.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/screens/category_products_screen.dart';
import 'package:online_groceries_app/screens/search_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/utils.dart';
import 'package:online_groceries_app/widget/rounded_button.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late Future<List<Category>> futureCategories;
  List<Category> allCategories = [];
  Set<String> selectedCategoryNames = {};
  List<Product> filteredProducts = [];
  bool isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories().then((data) {
      allCategories = data;
      return data;
    });
  }

  Future<List<Category>> fetchCategories() async {
    const url =
        'https://raw.githubusercontent.com/Vernika15/GroceryApp/refs/heads/main/assets/home_data.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List categoriesJson = jsonData['categories'];
      return categoriesJson.map((c) => Category.fromJson(c)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void _showFilterOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false, // Prevent tap outside to close
      enableDrag: false, // Prevent swipe down to close
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close overlay
                          setModalState(() {
                            // Reset filtered state
                            selectedCategoryNames.clear();
                          });
                        },
                        child: Icon(Icons.close, size: 25),
                      ),
                      Text(
                        'Filters',
                        style: textStyle20(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            // Reset filtered state
                            selectedCategoryNames.clear();
                          });
                        },
                        child: Text(
                          'Clear All',
                          style: textStyle16(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Categories',
                    textAlign: TextAlign.left,
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: allCategories.length,
                      itemBuilder: (context, index) {
                        final category = allCategories[index];
                        final isSelected = selectedCategoryNames.contains(
                          category.name,
                        );

                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            category.name,
                            style: textStyle18(
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : AppColors.textColor,
                            ),
                          ),
                          value: isSelected,
                          activeColor: AppColors.primary,
                          onChanged: (bool? value) {
                            setModalState(() {
                              if (value == true) {
                                selectedCategoryNames.add(category.name);
                              } else {
                                selectedCategoryNames.remove(category.name);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Prices',
                    textAlign: TextAlign.left,
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 80),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RoundedButton(
                      btnName: 'Apply Filter',
                      callback: () {
                        Navigator.pop(context); // Close overlay
                        setState(() {
                          isFilterApplied = selectedCategoryNames.isNotEmpty;
                          filteredProducts =
                              allCategories
                                  .where(
                                    (c) =>
                                        selectedCategoryNames.contains(c.name),
                                  )
                                  .expand((c) => c.products)
                                  .toList();
                        });
                      },
                      textStyle: textStyle18(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      bgColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<Category> _buildFilteredCategoryList() {
    return allCategories
        .where((c) => selectedCategoryNames.contains(c.name))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Find Products',
          style: textStyle20(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Box
            TextField(
              readOnly: true,
              onTap: () async {
                final categories = await futureCategories;
                final allProducts =
                    categories.expand((c) => c.products).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SearchScreen(allProducts: allProducts),
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search Store',
                hintStyle: textStyle14(
                  color: AppColors.subTextColor,
                  fontWeight: FontWeight.w600,
                ),
                prefixIcon: Icon(Icons.search, size: 25.0),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showFilterOverlay();
                  },
                  child: Icon(Icons.tune),
                ),
                filled: true,
                fillColor: AppColors.logoutButtonColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),
            // Category Grid
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No categories available'));
                  }

                  final categories =
                      isFilterApplied
                          ? _buildFilteredCategoryList()
                          : snapshot.data!;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CategoryProductsScreen(
                                    categoryName: category.name,
                                    products: category.products,
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor(category.backgroundColor),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: HexColor(category.borderColor),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(category.image, height: 60),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: textStyle16(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
