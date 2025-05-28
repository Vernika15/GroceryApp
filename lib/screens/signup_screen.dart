import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/auth_background_container.dart';
import 'package:online_groceries_app/widget/rounded_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                          'Sign Up',
                          style: textStyle26(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Enter your credentials to continue',
                          style: textStyle16(
                            color: AppColors.subTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Username',
                          style: textStyle16(
                            color: AppColors.subTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          enabled: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter Username",
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
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
                        RichText(
                          text: TextSpan(
                            text: "By continuing you agree to our ",
                            style: textStyle14(
                              color: AppColors.subTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: textStyle14(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Terms of Service tapped');
                                      },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: textStyle14(
                                  color: AppColors.subTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy.',
                                style: textStyle14(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Privacy Policy tapped');
                                      },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RoundedButton(
                            btnName: 'Sign Up',
                            callback: () {
                              Navigator.pop(context);
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
                              text: "Already have an account? ",
                              style: textStyle14(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Signin',
                                  style: textStyle14(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
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
