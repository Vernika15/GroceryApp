import 'package:online_groceries_app/models/product.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final String borderColor;
  final String backgroundColor;
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.borderColor,
    required this.backgroundColor,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      borderColor: json['border_color'],
      backgroundColor: json['background_color'],
      products:
          (json['products'] as List<dynamic>)
              .map((item) => Product.fromJson(item))
              .toList(),
    );
  }
}
