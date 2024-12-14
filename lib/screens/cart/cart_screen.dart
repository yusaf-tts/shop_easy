import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/blocs/states/cart_state.dart';
import 'package:shop_easy/repositories/cart_repository.dart';
import '../../blocs/cart_bloc.dart';
import '../../blocs/events/cart_event.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc(cartListRepository: CartListRepository())
        ..add(FetchCartList()),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: BlocBuilder<CartBloc, CartListState>(
          builder: (context, state) {
            if (state is CartListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartListLoaded) {
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
            } else if (state is CartListError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No Cart data Found'));
            }
          },
        ),
      ),
    );
  }
}
