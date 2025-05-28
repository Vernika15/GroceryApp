import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/screens/login_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/rounded_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // BoxDecoration takes the image
        decoration: BoxDecoration(
          // Image set to background of the body
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // content thath will be shown above the background image
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/onboarding_image.png',
                width: 50,
                height: 55,
              ),
              Text(
                'Welcome\nto our store',
                textAlign: TextAlign.center,
                style: textStyle48(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Get your groceries in as fast as one hour',
                textAlign: TextAlign.center,
                style: textStyle16(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RoundedButton(
                    btnName: 'Get Started',
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    textStyle: textStyle18(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    bgColor: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
