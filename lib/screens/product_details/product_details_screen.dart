import 'package:flutter/material.dart';
import '../../models/products.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            SizedBox(height: 16),
            Text(product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Category: ${product.category}',
                style: TextStyle(fontSize: 18)),
             SizedBox(height: 8),
            Text('Price: \$${product.price}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Description: ${product.description}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Rating: ${product.rating} stars',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Stock: ${product.stock} available',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
