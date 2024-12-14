import '../../models/products.dart';

abstract class CartListEvent {}

class AddToCartList extends CartListEvent {
  final Product product;

  AddToCartList({required this.product});
}

class RemoveFromCartList extends CartListEvent {
  final Product product;

  RemoveFromCartList({required this.product});
}

class FetchCartList extends CartListEvent {}
