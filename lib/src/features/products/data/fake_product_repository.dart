import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductRepository {

  /// `FakeProductRepository._();` is a private constructor for the `FakeProductRepository` class. By
  /// using the underscore `_`, the constructor is made private and can only be accessed within the
  /// class itself. This means that the `FakeProductRepository` class cannot be instantiated from
  /// outside the class.
  FakeProductRepository._();

  /// The line `static FakeProductRepository instance = FakeProductRepository._();` is creating a static
  /// instance of the `FakeProductRepository` class.
  static FakeProductRepository instance = FakeProductRepository._();

  /// The function `getProductList` returns a list of products.
  /// 
  /// Returns:
  ///   The method is returning a list of Product objects.
  List<Product> getProductList () {
    return kTestProducts; 
  }

  /// The function `getProduct` returns a `Product` object with a matching `id` from a list of
  /// `kTestProducts`.
  /// 
  /// Args:
  ///   id (String): The id parameter is a string that represents the unique identifier of a product.
  /// 
  /// Returns:
  ///   The getProduct function returns a Product object.
  Product? getProduct(String id) {
    return kTestProducts.firstWhere((product) => product.id == id);
  }
} 