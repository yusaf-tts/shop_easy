import '../../models/products.dart';

abstract class WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final Product product;

  AddToWishlist({required this.product});
}

class RemoveFromWishlist extends WishlistEvent {
  final Product product;

  RemoveFromWishlist({required this.product});
}

class FetchWishlist extends WishlistEvent {}
