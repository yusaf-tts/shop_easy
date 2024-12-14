import 'package:firebase_database/firebase_database.dart';
import '../models/products.dart';

class CartListRepository {
  final DatabaseReference _cartlistRef = FirebaseDatabase.instance.ref('carts');

  Future<List<Product>> fetchCartLists() async {
    try {
      final snapshot = await _cartlistRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> productMap = Map.from(snapshot.value as Map);
        return productMap.values
            .map((product) =>
                Product.fromMap(Map<String, dynamic>.from(product)))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch Carts: $e');
    }
  }
}
