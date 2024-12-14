import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/events/cart_event.dart';
import 'package:shop_easy/blocs/states/cart_state.dart';
import 'package:shop_easy/repositories/cart_repository.dart';

class CartBloc extends Bloc<CartListEvent, CartListState> {
  final CartListRepository cartListRepository;

  CartBloc({required this.cartListRepository}) : super(CartListInitial()) {
    on<FetchCartList>((event, emit) async {
      try {
        emit(CartListLoading());
        final products = await cartListRepository.fetchCartLists();
        emit(CartListLoaded(products));
      } catch (e) {
        emit(CartListError(
          "Failed to load cart list: $e",
        ));
      }
    });
  }
}
