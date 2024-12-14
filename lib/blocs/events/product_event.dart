import '../../models/products.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class AddToWishlist extends ProductEvent {
  final Product product;

  AddToWishlist({required this.product});
}

class AddToCart extends ProductEvent {
  final Product product;

  AddToCart({required this.product});
}
