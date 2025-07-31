import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cart.items.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.items.entries.map((entry) {
                      final product = entry.key;
                      final quantity = entry.value;
                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.title),
                        subtitle: Text('₹${product.price} x $quantity'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            cart.removeFromCart(product);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Total: ₹${cart.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                        child: Text('Proceed to Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
