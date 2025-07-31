import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

enum SortOption { price, rating, popularity }

class ProductProvider extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _visibleProducts = [];
  bool _isLoadingMore = false;
  int _itemsPerPage = 10;
  int _currentPage = 1;

  bool get isLoadingMore => _isLoadingMore;
  List<Product> get products => _visibleProducts;

  Future<void> fetchProducts() async {
    _allProducts = await ApiService.fetchProducts();
    _visibleProducts = _allProducts.take(_itemsPerPage).toList();
    _currentPage = 1;
    notifyListeners();
  }

  void loadMore() {
    if (_isLoadingMore) return;

    _isLoadingMore = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 1), () {
      final int nextPage = _currentPage + 1;
      final int endIndex = nextPage * _itemsPerPage;

      if (endIndex <= _allProducts.length) {
        _visibleProducts = _allProducts.take(endIndex).toList();
        _currentPage = nextPage;
      }

      _isLoadingMore = false;
      notifyListeners();
    });
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _visibleProducts =
          _allProducts.take(_currentPage * _itemsPerPage).toList();
    } else {
      _visibleProducts = _allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void sortProducts(SortOption option) {
    switch (option) {
      case SortOption.price:
        _visibleProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.rating:
        _visibleProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.popularity:
        _visibleProducts.sort((a, b) => b.count
            .compareTo(a.count)); // Sort by number of reviews (popularity)

        break;
    }
    notifyListeners();
  }
}
