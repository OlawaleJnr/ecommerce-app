import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {

  /// The line `final List<Product> _products = kTestProducts;` is initializing a private variable
  /// `_products` with the value of `kTestProducts`. `kTestProducts` is a constant list of `Product`
  /// objects, likely used for testing purposes. This line is creating a copy of the `kTestProducts`
  /// list and assigning it to the `_products` variable, which can be accessed within the
  /// `FakeProductRepository` class.
  final List<Product> _products = kTestProducts;

  /// The function returns a list of products.
  /// 
  /// Returns: The method is returning a list of Product objects.
  List<Product> getProductList() {
    return _products; 
  }

  /// The function `getProduct` returns a `Product` object with a matching `id` from a list of products.
  /// 
  /// Args: id (String): The id parameter is a string that represents the unique identifier of a product.
  /// 
  /// Returns: The getProduct function returns a Product object.
  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  /// The function fetchProductList fetches a list of products asynchronously and returns it as a Future.
  /// 
  /// Returns: A `Future` that resolves to a `List<Product>`.
  Future<List<Product>> fetchProductList() async {
    await Future.delayed(const Duration(seconds: 4));
    // throw Exception('Connection Failed');
    return Future.value(_products);
  }

  /// The function returns a stream that emits a list of products after a delay of 4 seconds.
  Stream<List<Product>> watchProductList() async* {
    await Future.delayed(const Duration(seconds: 4));
    yield getProductList();
  }

  /// The function `watchProduct` returns a stream that emits the first product from a product list that matches the given id.
  /// 
  /// Args: id (String): The id parameter is a string that represents the unique identifier of a product.
  /// 
  /// Returns: The code is returning a stream of nullable Product objects.
  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => products.firstWhere((product) => product.id == id));
  }
} 

/// The `productsRepositoryProvider` is a `Provider` that creates and provides an instance of the
/// `FakeProductRepository` class. It is defined using the `Provider` constructor with a generic type
/// argument of `FakeProductRepository`.
final productsRepositoryProvider = Provider<FakeProductRepository>((ref) {
  debugPrint("Created Product Repository Provider");
  return FakeProductRepository();
});

/// The `productListStreamProvider` is a `StreamProvider` that creates and provides a stream of
/// `List<Product>` objects. It is defined using the `StreamProvider.autoDispose` constructor with a
/// generic type argument of `List<Product>`.
final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint("Created Product List Stream Provider");
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductList();
});

/// The `productListFutureProvider` is a `FutureProvider` that creates and provides a future that
/// resolves to a list of `Product` objects. It is defined using the `FutureProvider.autoDispose`
/// constructor with a generic type argument of `List<Product>`.
final productListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  debugPrint("Created Product List Future Provider");
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductList();
});

/// The `productProvider` is a `StreamProvider` that creates and provides a stream of nullable `Product`
/// objects based on a given `id`. It is defined using the `StreamProvider.autoDispose.family`
/// constructor, which allows for the creation of a family of providers that can be accessed with
/// different values.
final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  debugPrint("Created Product Provider with :id $id");
  ref.onDispose(() => debugPrint("Disposed Product Provider with :id $id"));
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}); 