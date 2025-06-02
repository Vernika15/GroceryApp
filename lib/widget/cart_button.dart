import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/providers/cart_provider.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  final Product product;

  const CartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        final qty = cart.getQuantity(product);

        return qty == 0
            ? GestureDetector(
              onTap: () => cart.addToCart(product),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                padding: EdgeInsets.all(6),
                child: Icon(Icons.add, color: AppColors.white, size: 20),
              ),
            )
            : Row(
              children: [
                GestureDetector(
                  onTap: () => cart.removeFromCart(product),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.remove, color: AppColors.white, size: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '$qty',
                    style: textStyle16(fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () => cart.addToCart(product),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.add, color: AppColors.white, size: 18),
                  ),
                ),
              ],
            );
      },
    );
  }
}
