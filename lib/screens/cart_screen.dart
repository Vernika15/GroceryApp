import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/providers/cart_provider.dart';
import 'package:online_groceries_app/screens/order_accepted_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/rounded_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final List<Product> allProducts;

  const CartScreen({super.key, required this.allProducts});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OverlayEntry? _overlayEntry;

  void _showCheckoutOverlay(double total) {
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              /// Transparent dimmed area (top 45%)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height * 0.45,
                child: GestureDetector(
                  onTap: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                  child: Container(
                    color: Colors.black54, // translucent black
                  ),
                ),
              ),

              /// Bottom sheet-style overlay (bottom 55%)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: MediaQuery.of(context).size.height * 0.55,
                child: Material(
                  color: Colors.black54,
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Checkout',
                              style: textStyle24(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _overlayEntry?.remove();
                                _overlayEntry = null;
                              },
                              child: Icon(
                                Icons.close,
                                color: AppColors.textColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Divider(height: 1, color: AppColors.underlineColor),
                        SizedBox(height: 15),

                        /// Delivery method
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: textStyle16(
                                color: AppColors.subTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Select Method',
                                  style: textStyle16(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(height: 1, color: AppColors.underlineColor),
                        SizedBox(height: 15),

                        /// Payment method
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment',
                              style: textStyle16(
                                color: AppColors.subTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: AppColors.textColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(height: 1, color: AppColors.underlineColor),
                        SizedBox(height: 15),

                        /// Promo code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Promo Code',
                              style: textStyle16(
                                color: AppColors.subTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Pick Discount',
                                  style: textStyle16(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(height: 1, color: AppColors.underlineColor),
                        SizedBox(height: 15),

                        /// Total cost
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Cost',
                              style: textStyle16(
                                color: AppColors.subTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹${total.toStringAsFixed(2)}',
                                  style: textStyle16(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RoundedButton(
                            btnName: 'Place Order',
                            callback: () {
                              _overlayEntry?.remove();
                              _overlayEntry = null;

                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).clearCart();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderAcceptedScreen(),
                                ),
                              );
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
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems =
        widget.allProducts
            .where((product) => cart.getQuantity(product) > 0)
            .toList();

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
                                                style: textStyle18(
                                                  color: AppColors.textColor,
                                                  fontWeight: FontWeight.w600,
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
                          _showCheckoutOverlay(total);
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
