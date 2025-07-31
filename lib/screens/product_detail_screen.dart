import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('₹${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text('${product.rating}', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(product.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
