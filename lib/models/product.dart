class Product {
  final int id;
  final String name;
  final String weight;
  final int price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
      image: json['image'],
      category: json['category'] ?? '',
    );
  }
}
