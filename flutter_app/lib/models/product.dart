class Product {
  final String name;
  final String category;
  final int stock;
  final double price;
  final String image;
  final String description;

  Product({
    required this.name,
    required this.category,
    required this.stock,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? 'No Name',
      category: json['category'] ?? 'Uncategorized',
      stock: json['stock'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? 'placeholder_image_url',
      description: json['description'] ?? 'No description',
    );
  }
}
