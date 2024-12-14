import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_easy/repositories/cart_repository.dart';
import '../../blocs/cart_bloc.dart';
import '../../blocs/events/product_event.dart';
import '../../blocs/product_bloc.dart';
import '../../blocs/states/product_state.dart';
import '../../repositories/product_repository.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(productRepository: ProductRepository())
            ..add(FetchProducts()),
        ),
        BlocProvider(
          create: (_) => CartBloc(cartListRepository: CartListRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Products')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color:
                                  product.addedToFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(AddToWishlist(product: product));
                            },
                          ),
                          product.addedToCart
                              ? Text('Already Added')
                              : IconButton(
                                  icon: Icon(Icons.add_shopping_cart),
                                  onPressed: () {
                                    BlocProvider.of<ProductBloc>(context)
                                        .add(AddToCart(product: product));
                                    DatabaseReference cartRef = FirebaseDatabase
                                        .instance
                                        .ref()
                                        .child('carts');
                                    cartRef.push().set({
                                      'category': product.category,
                                      'description': product.description,
                                      'discount': product.discount,
                                      'image_url': product.imageUrl,
                                      'name': product.name,
                                      'price': product.price,
                                      'rating': product.rating,
                                      'stock': product.stock,
                                      'added_to_fav': product.addedToFav,
                                      'added_to_cart': true,
                                    }).then((_) {
                                      product.addedToCart = true;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                '${product.name} added to cart!')),
                                      );
                                    }).catchError((error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Failed to add to cart: $error')),
                                      );
                                    });
                                  },
                                ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No Products Found'));
            }
          },
        ),
      ),
    );
  }
}
