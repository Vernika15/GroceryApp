import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/homedata.dart';
import 'package:online_groceries_app/models/product.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';
import 'package:online_groceries_app/widget/cart_button.dart';

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
                    'Exclusive Offer',
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          data.exclusiveOffers.map((product) {
                            return Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.all(12),
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.underlineColor,
                                  width: 1,
                                ),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.network(
                                      product.image,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    product.name,
                                    style: textStyle16(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.weight,
                                    style: textStyle14(
                                      color: AppColors.subTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹${product.price}',
                                        style: textStyle18(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CartButton(
                                        product: Product(
                                          id: product.id,
                                          name: product.name,
                                          weight: product.weight,
                                          price: product.price,
                                          image: product.image,
                                          category: '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          data.popularItems.map((product) {
                            return Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.all(12),
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.underlineColor,
                                  width: 1,
                                ),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.network(
                                      product.image,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    product.name,
                                    style: textStyle16(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.weight,
                                    style: textStyle14(
                                      color: AppColors.subTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹${product.price}',
                                        style: textStyle18(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CartButton(
                                        product: Product(
                                          id: product.id,
                                          name: product.name,
                                          weight: product.weight,
                                          price: product.price,
                                          image: product.image,
                                          category: '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Best Selling',
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          data.bestSelling.map((product) {
                            return Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.all(12),
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.underlineColor,
                                  width: 1,
                                ),
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.network(
                                      product.image,
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    product.name,
                                    style: textStyle16(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.weight,
                                    style: textStyle14(
                                      color: AppColors.subTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹${product.price}',
                                        style: textStyle18(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CartButton(
                                        product: Product(
                                          id: product.id,
                                          name: product.name,
                                          weight: product.weight,
                                          price: product.price,
                                          image: product.image,
                                          category: '',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
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
