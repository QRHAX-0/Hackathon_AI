import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(product: product),
            ),
          ),
      child: Card(
        child: Column(
          children: [
            Image.network(product.image, height: 100, fit: BoxFit.contain),
            Text(product.name, style: TextStyle(fontSize: 16)),
            Text(
              "${product.price} USD",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
