import 'package:flutter/material.dart';
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            // Profile Info
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile_image.png'),
              ),
              title: Row(
                children: [
                  Text(
                    'Afsar Hossen',
                    style: textStyle18(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
                ],
              ),
              subtitle: Text(
                'lmshuvo97@gmail.com',
                style: textStyle16(
                  color: AppColors.subTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 25),
            Divider(color: AppColors.underlineColor, height: 0.0),

            // Menu Items
            MenuItem(icon: Icons.shopping_bag_outlined, title: 'Orders'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(icon: Icons.badge_outlined, title: 'My Details'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(
              icon: Icons.location_on_outlined,
              title: 'Delivery Address',
            ),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(icon: Icons.payment, title: 'Payment Methods'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(
              icon: Icons.confirmation_num_outlined,
              title: 'Promo Cord',
            ),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(icon: Icons.notifications_none, title: 'Notifications'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(icon: Icons.help_outline, title: 'Help'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            MenuItem(icon: Icons.info_outline, title: 'About'),
            Divider(color: AppColors.underlineColor, height: 0.0),

            Spacer(),

            // Log Out Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.logoutButtonColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 60,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Log Out',
                      style: textStyle18(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      child: Icon(Icons.logout, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textColor),
      title: Text(
        title,
        style: textStyle18(
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
