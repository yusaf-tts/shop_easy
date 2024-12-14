import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/events/wishlist_event.dart';
import 'package:shop_easy/blocs/states/wishlist_state.dart';
import '../repositories/wishlist_repository.dart';

class WishListBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishListRepository wishListRepository;

  WishListBloc({required this.wishListRepository}) : super(WishlistInitial()) {
    on<FetchWishlist>((event, emit) async {
      try {
        emit(WishListLoading());
        final products = await wishListRepository.fetchWishLists();
        emit(WishListLoaded(products));
      } catch (e) {
        emit(WishlistError(
          "Failed to load wishlists: $e",
        ));
      }
    });
  }
}
