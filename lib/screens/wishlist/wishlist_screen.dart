import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/events/wishlist_event.dart';
import 'package:shop_easy/blocs/states/wishlist_state.dart';
import 'package:shop_easy/blocs/wishlist_bloc.dart';
import 'package:shop_easy/repositories/wishlist_repository.dart';


class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishListBloc(wishListRepository: WishListRepository())
        ..add(FetchWishlist()),
      child: Scaffold(
        appBar: AppBar(title: Text('WishList')),
        body: BlocBuilder<WishListBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WishListLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                    ),
                  );
                },
              );
            } else if (state is WishlistError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No WishList Found'));
            }
          },
        ),
      ),
    );
  }
}
