class ProductModel {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.images,
  });

  String get imageUrl {
    if (images.isNotEmpty) {
      return images.first;
    }
    return 'https://via.placeholder.com/300x200?text=No+Image';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] is num ? (json['price'] as num).toDouble() : double.tryParse('${json['price']}') ?? 0.0),
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      images: json['images'] is List
          ? List<String>.from((json['images'] as List).map((item) => '$item'))
          : <String>[],
    );
  }
}
