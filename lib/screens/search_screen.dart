import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/cart_button.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> allProducts;

  const SearchScreen({super.key, required this.allProducts});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> filteredProducts = [];
  String query = "";

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.allProducts;
  }

  void searchProduct(String input) {
    final results =
        widget.allProducts.where((product) {
          return product.name.toLowerCase().contains(input.toLowerCase());
        }).toList();

    setState(() {
      query = input;
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: TextField(
          autofocus: true,
          onChanged: searchProduct,
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: textStyle14(color: AppColors.subTextColor),
            border: InputBorder.none,
          ),
        ),
        leading: BackButton(color: AppColors.textColor),
      ),
      body:
          query.isEmpty
              ? Center(child: Text('Start typing to search products'))
              : filteredProducts.isEmpty
              ? Center(child: Text('No products found'))
              : Padding(
                padding: EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.underlineColor,
                          width: 1,
                        ),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.network(product.image, height: 100),
                          ),
                          SizedBox(height: 5),
                          Text(
                            product.name,
                            style: textStyle16(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.weight,
                            style: textStyle14(
                              color: AppColors.subTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${product.price}',
                                style: textStyle18(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CartButton(product: product),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
