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
  late List<Category> displayedCategories;
  Set<String> selectedCategoryNames = {};
  List<Product> filteredProducts = [];
  bool isFilterApplied = false;
  double _minPrice = 0;
  double _maxPrice = 500;
  RangeValues _selectedRange = const RangeValues(0, 500);

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories().then((data) {
      allCategories = data;
      displayedCategories = List.from(data);
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
                            selectedCategoryNames.clear();
                            _selectedRange = const RangeValues(0, 500);
                          });
                          setState(() {
                            isFilterApplied = false;
                            displayedCategories = List.from(allCategories);
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
                  RangeSlider(
                    values: _selectedRange,
                    min: _minPrice,
                    max: _maxPrice,
                    divisions: 100,
                    labels: RangeLabels(
                      '₹${_selectedRange.start.round()}',
                      '₹${_selectedRange.end.round()}',
                    ),
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.primary.withOpacity(0.3),
                    onChanged: (RangeValues values) {
                      setModalState(() {
                        _selectedRange = values;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Min: ₹${_selectedRange.start.round()}',
                          style: textStyle14(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Max: ₹${_selectedRange.end.round()}',
                          style: textStyle14(fontWeight: FontWeight.w500),
                        ),
                      ],
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
                          isFilterApplied = true;

                          final categoriesToFilter =
                              selectedCategoryNames.isEmpty
                                  ? allCategories
                                  : allCategories
                                      .where(
                                        (cat) => selectedCategoryNames.contains(
                                          cat.name,
                                        ),
                                      )
                                      .toList();

                          displayedCategories =
                              categoriesToFilter
                                  .map((category) {
                                    final filteredProducts =
                                        category.products.where((product) {
                                          return product.price >=
                                                  _selectedRange.start &&
                                              product.price <=
                                                  _selectedRange.end;
                                        }).toList();

                                    return Category(
                                      id: category.id,
                                      name: category.name,
                                      image: category.image,
                                      borderColor: category.borderColor,
                                      backgroundColor: category.backgroundColor,
                                      products: filteredProducts,
                                    );
                                  })
                                  .where((cat) => cat.products.isNotEmpty)
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
        automaticallyImplyLeading: false, // removes the back button
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

                  final categories = displayedCategories;

                  if (categories.isEmpty) {
                    return Center(
                      child: Text(
                        'No data found',
                        style: textStyle18(
                          color: AppColors.subTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }

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
