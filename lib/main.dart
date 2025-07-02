import 'package:flutter/material.dart';
import 'package:online_groceries_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:online_groceries_app/screens/home_screen.dart';
import 'package:online_groceries_app/screens/onboarding_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Groceries App',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      // home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Online Groceries App'),
      ),
      body: Text('qwerty'),
    );
  }
}
