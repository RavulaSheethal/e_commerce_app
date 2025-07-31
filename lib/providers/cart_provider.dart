import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  Map<Product, int> _items = {};

  Map<Product, int> get items => _items;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product]! > 1) {
        _items[product] = _items[product]! - 1;
      } else {
        _items.remove(product);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
