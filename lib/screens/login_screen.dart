import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/screens/location_screen.dart';
import 'package:online_groceries_app/screens/signup_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/auth_background_container.dart';
import 'package:online_groceries_app/widget/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool _isPasswordVisible = false; // Track password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/images/login_image.png'),
                  SizedBox(height: 80),
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: textStyle26(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Enter your emails and password',
                          style: textStyle16(
                            color: AppColors.subTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Email',
                          style: textStyle16(
                            color: AppColors.subTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          enabled: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Password',
                          style: textStyle16(
                            color: AppColors.subTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          enabled: true,
                          obscureText: !_isPasswordVisible,
                          obscuringCharacter: '*',
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.subTextColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: textStyle14(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RoundedButton(
                            btnName: 'Log In',
                            callback: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(),
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
                        SizedBox(height: 20),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don’t have an account? ",
                              style: textStyle14(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Signup',
                                  style: textStyle14(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          // Navigate to signup screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => SignupScreen(),
                                            ),
                                          );
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
