import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductRepository {

  FakeProductRepository._();

  static FakeProductRepository instance = FakeProductRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductList () {
    return _products; 
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => products.firstWhere((product) => product.id == id));
  }
} 