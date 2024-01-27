import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {

  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products; 
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductList() async {
    await Future.delayed(const Duration(seconds: 4));
    // throw Exception('Connection Failed');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductList() async* {
    await Future.delayed(const Duration(seconds: 4));
    yield getProductList();
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => products.firstWhere((product) => product.id == id));
  }
} 

final productsRepositoryProvider = Provider<FakeProductRepository>((ref) {
  debugPrint("Created Product Repository Provider");
  return FakeProductRepository();
});

final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint("Created Product List Stream Provider");
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductList();
});

final productListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  debugPrint("Created Product List Future Provider");
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductList();
});

final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  debugPrint("Created Product Provider with :id $id");
  ref.onDispose(() => debugPrint("Disposed Product Provider with :id $id"));
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}); 