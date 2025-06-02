class PopularItem {
  final int id;
  final String name;
  final String weight;
  final int price;
  final String image;

  PopularItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
      image: json['image'],
    );
  }
}
