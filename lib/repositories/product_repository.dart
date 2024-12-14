import 'package:firebase_database/firebase_database.dart';

import '../models/products.dart';

class ProductRepository {
  final DatabaseReference _productRef =
      FirebaseDatabase.instance.ref('products');
  final DatabaseReference _wishlistRef =
      FirebaseDatabase.instance.ref('wishlist');

  Future<List<Product>> fetchProducts() async {
    try {
      final snapshot = await _productRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> productMap = Map.from(snapshot.value as Map);
        return productMap.values
            .map((product) =>
                Product.fromMap(Map<String, dynamic>.from(product)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<void> addToWishlist(Product product) async {
    try {
      await _productRef.child(product.name).update({
        'added_to_fav': true,
      });
      await _wishlistRef.push().set(product.toMap());
    } catch (e) {
      throw Exception('Failed to add product to wishlist: $e');
    }
  }

  Future<void> addToCartList(Product product) async {
    try {
      await _productRef.child(product.name).update({
        'added_to_cart': true,
      });
      await _wishlistRef.push().set(product.toMap());
    } catch (e) {
      throw Exception('Failed to add product to wishlist: $e');
    }
  }
}
