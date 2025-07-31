import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/product_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/product_card.dart';
import '../screens/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !productProvider.isLoadingMore) {
        productProvider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mitt Arv E-Commerce'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => AuthScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => productProvider.searchProducts(value),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: DropdownButton<SortOption>(
                  value: null,
                  hint: Text("Sort By"),
                  onChanged: (SortOption? value) {
                    if (value != null) {
                      productProvider.sortProducts(value);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: SortOption.price,
                      child: Text("Price"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.rating,
                      child: Text("Rating"),
                    ),
                    DropdownMenuItem(
                      value: SortOption.popularity,
                      child: Text("Popularity"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: productProvider.products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: productProvider.products.length +
                  (productProvider.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < productProvider.products.length) {
                  return ProductCard(product: productProvider.products[index]);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
