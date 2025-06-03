import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/providers/cart_provider.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final List<Product> allProducts;

  const CartScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems =
        allProducts.where((product) => cart.getQuantity(product) > 0).toList();

    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + item.price * cart.getQuantity(item),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'My Cart',
          style: textStyle20(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:
          cartItems.isEmpty
              ? Center(child: Text("Your cart is empty", style: textStyle16()))
              : Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cartItems[index];
                          final qty = cart.getQuantity(product);

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      product.image,
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(width: 25),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: textStyle16(
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${product.weight} x ₹${product.price}',
                                            style: textStyle14(
                                              color: AppColors.subTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /// Quantity controls
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap:
                                                        () =>
                                                            cart.removeFromCart(
                                                              product,
                                                            ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      padding: EdgeInsets.all(
                                                        6,
                                                      ),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                        ),
                                                    child: Text(
                                                      '$qty',
                                                      style: textStyle16(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap:
                                                        () => cart.addToCart(
                                                          product,
                                                        ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                      padding: EdgeInsets.all(
                                                        6,
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColors.white,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              /// Price
                                              Text(
                                                '₹${product.price * qty}',
                                                style: textStyle16(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              Divider(
                                height: 1,
                                color: AppColors.underlineColor,
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Order Placed")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Go to Checkout',
                                style: textStyle18(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                color: AppColors.darkGreenColor,
                                child: Text(
                                  '₹${total.toStringAsFixed(2)}',
                                  style: textStyle12(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
