class ExclusiveOffer {
  final int id;
  final String name;
  final String weight;
  final int price;
  final String image;

  ExclusiveOffer({
    required this.id,
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
  });

  factory ExclusiveOffer.fromJson(Map<String, dynamic> json) {
    return ExclusiveOffer(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      price: json['price'],
      image: json['image'],
    );
  }
}
