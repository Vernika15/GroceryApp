import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';

class AuthBackgroundContainer extends StatelessWidget {
  final Widget child;

  const AuthBackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/auth_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
