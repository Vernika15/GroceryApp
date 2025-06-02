import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_groceries_app/constants/themes/app_colors.dart';
import 'package:online_groceries_app/models/homedata.dart';
import 'package:online_groceries_app/ui_helper/text_styles.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<HomeData> futureHomeData;

  @override
  void initState() {
    super.initState();
    futureHomeData = fetchHomeData();
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
                  Text(
                    '${data.greeting}, ${data.userName}',
                    style: textStyle24(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.primary),
                      Text(data.location),
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
                  SizedBox(height: 24),
                  Text(
                    'Popular Items',
                    style: textStyle20(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
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

// class Category {
//   final int id;
//   final String name;
//   final String image;

//   Category({required this.id, required this.name, required this.image});

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(id: json['id'], name: json['name'], image: json['image']);
//   }
// }
