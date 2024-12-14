import '../../models/products.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishListLoading extends WishlistState {}

class WishListLoaded extends WishlistState {
  final List<Product> products;

  WishListLoaded(this.products);
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);
}
