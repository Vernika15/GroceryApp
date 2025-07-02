import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/homedata.dart';
import 'package:online_groceries_app/screens/category_products_screen.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';

class ShopScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const ShopScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<HomeData> futureHomeData;
  String? _address;
  bool _isLoadingAddress = true;

  @override
  void initState() {
    super.initState();
    _getAddressFromLatLng();
    futureHomeData = fetchHomeData();
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.latitude,
        widget.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        setState(() {
          _address = '${place.administrativeArea}, ${place.country}';
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _address = 'Unable to get address';
        _isLoadingAddress = false;
      });
      debugPrint('Error in reverse geocoding: $e');
    }
  }

  Future<HomeData> fetchHomeData() async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/Vernika15/GroceryApp/refs/heads/main/assets/home_data.json',
      ),
    );

    if (response.statusCode == 200) {
      return HomeData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load home data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: FutureBuilder<HomeData>(
          future: futureHomeData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Image.asset(
                    'assets/images/login_image.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: AppColors.locationColor),
                      SizedBox(width: 5),
                      _isLoadingAddress
                          ? Text('Loading address....')
                          : Text('$_address'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(data.bannerImage),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Categories',
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final category = data.categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CategoryProductsScreen(
                                      categoryName: category.name,
                                      products: category.products,
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  category.image,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(category.name, style: textStyle12()),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Popular Items',
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.popularItems.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final category = data.popularItems[index];
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                category.image,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(category.name, style: textStyle12()),
                          ],
                        );
                      },
                    ),
                  ),
                  // // Column(
                  // //   children:
                  // //       data.popularItems.map((item) {
                  // //         return Card(
                  // //           shape: RoundedRectangleBorder(
                  // //             borderRadius: BorderRadius.circular(12),
                  // //           ),
                  // //           margin:  EdgeInsets.only(bottom: 16),
                  // //           child: ListTile(
                  // //             leading: ClipRRect(
                  // //               borderRadius: BorderRadius.circular(10),
                  // //               child: Image.network(
                  // //                 item.image,
                  // //                 height: 50,
                  // //                 width: 50,
                  // //                 fit: BoxFit.cover,
                  // //               ),
                  // //             ),
                  // //             title: Text(item.name),
                  // //             subtitle: Text(item.weight),
                  // //             trailing: Text('₹${item.price}'),
                  // //           ),
                  // //         );
                  // //       }).toList(),
                  // ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          },
        ),
      ),
    );
  }
}
