class ProductModel {
  final dynamic id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String image;
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      category: jsonData['category'],
      // The API returns price as a String on update, but as a num on get.
      // We handle both cases by parsing it.
      price: double.parse(jsonData['price'].toString()),
      description: jsonData['description'],
      image: jsonData['image'],
      rating: RatingModel.fromJson(
        jsonData['rating'] ?? {'rate': 0.0, 'count': 0},
      ),
    );
  }
}

class RatingModel {
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> jsonData) {
    return RatingModel(
      // Handle cases where rate might not be a num
      rate: double.parse(jsonData['rate'].toString()),
      count: jsonData['count'],
    );
  }
}
