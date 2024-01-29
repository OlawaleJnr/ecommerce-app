/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// The `Product` class represents a product with various properties such as id, image URL, title,
/// description, price, available quantity, average rating, and number of ratings.
class Product {
  /// The `const Product()` constructor is creating a new instance of the `Product` class with the
  /// specified properties.
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;
}
