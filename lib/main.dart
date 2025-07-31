import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mitt Arv E-Commerce',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            home: AuthScreen(),
            routes: {
              '/cart': (_) => CartScreen(), // Your cart page
              '/checkout': (_) => CheckoutScreen(),
              '/auth': (_) => AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
