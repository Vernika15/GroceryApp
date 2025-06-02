import 'package:online_groceries_app/models/category.dart';
import 'package:online_groceries_app/models/popularitem.dart';

class HomeData {
  final String greeting;
  final String userName;
  final String location;
  final String bannerImage;
  final List<Category> categories;
  final List<PopularItem> popularItems;

  HomeData({
    required this.greeting,
    required this.userName,
    required this.location,
    required this.bannerImage,
    required this.categories,
    required this.popularItems,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      greeting: json['greeting'],
      userName: json['user_name'],
      location: json['location'],
      bannerImage: json['banner_image'],
      categories:
          (json['categories'] as List)
              .map((c) => Category.fromJson(c))
              .toList(),
      popularItems:
          (json['popular_items'] as List)
              .map((p) => PopularItem.fromJson(p))
              .toList(),
    );
  }
}
