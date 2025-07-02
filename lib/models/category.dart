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
    final categoryName = json['name'];
    final List<Product> productList =
        (json['products'] as List<dynamic>)
            .map(
              (item) => Product.fromJson({...item, 'category': categoryName}),
            )
            .toList();

    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      borderColor: json['border_color'],
      backgroundColor: json['background_color'],
      products: productList,
    );
  }
}
