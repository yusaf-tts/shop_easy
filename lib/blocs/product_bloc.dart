import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/events/product_event.dart';
import 'package:shop_easy/blocs/states/product_state.dart';
import 'package:shop_easy/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Failed to load products: $e"));
      }
    });

    on<AddToWishlist>((event, emit) async {
      try {
        emit(ProductLoading());
        final updatedProduct = event.product.copyWith(addedToFav: true);
        await productRepository.addToWishlist(updatedProduct);
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Failed to add product to wishlist: $e"));
      }
    });

    on<AddToCart>((event, emit) async {
      try {
        emit(ProductLoading());
        final updatedProduct = event.product.copyWith(addedToFav: true);
        await productRepository.addToCartList(updatedProduct);
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Failed to add product to wishlist: $e"));
      }
    });
  }
}
