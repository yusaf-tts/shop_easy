import 'package:firebase_database/firebase_database.dart';
import '../models/products.dart';

class WishListRepository {
  final DatabaseReference _wishlistRef =
      FirebaseDatabase.instance.ref('wishlist');

  Future<List<Product>> fetchWishLists() async {
    try {
      final snapshot = await _wishlistRef.get();
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
}
