import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/auth_background_container.dart';

class OrderAcceptedScreen extends StatefulWidget {
  const OrderAcceptedScreen({super.key});

  @override
  State<OrderAcceptedScreen> createState() => _OrderAcceptedScreenState();
}

class _OrderAcceptedScreenState extends State<OrderAcceptedScreen> {
  @override
  void initState() {
    super.initState();

    // Pop back after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/images/order_success.png'),
                  SizedBox(height: 80),
                  Text(
                    'Your Order has been accepted',
                    textAlign: TextAlign.center,
                    style: textStyle28(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Your order has been placed',
                    textAlign: TextAlign.center,
                    style: textStyle16(
                      color: AppColors.subTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
