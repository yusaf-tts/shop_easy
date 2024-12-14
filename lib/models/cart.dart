import 'package:shop_easy/models/products.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({required this.product, this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
