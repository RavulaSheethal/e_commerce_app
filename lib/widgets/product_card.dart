import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: ListTile(
          leading: Image.network(
            product.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(product.title),
          subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.title} added to cart')),
              );
            },
          ),
        ),
      ),
    );
  }
}
