import 'package:flutter/material.dart';
// import 'package:quiz_app/screens/home_screen.dart';
// import 'package:quiz_app/ui_helper/text_styles.dart'; // Import the main quiz screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay to navigate to the onboarding screen after 2 seconds
    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeScreen()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_icon.png', width: 150, height: 150),
            // SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
