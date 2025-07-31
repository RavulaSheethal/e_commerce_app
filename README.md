# e_commerce_app

This is a basic cross-platform e-commerce application developed using **Flutter**. The project was built to demonstrate key features of an online shopping app like product listing, search, cart, and checkout, integrated with a public API.

## 📱 Features
**User Authentication** – Login and register screens to authenticate users.
**Product Listing** – Displays products fetched from the [Fake Store API](https://fakestoreapi.com/).
**Infinite Scrolling** – Loads 10 products initially and fetches more as the user scrolls.
**Search Functionality** – Real-time search across product titles.
**Sorting Options** – Users can sort products by price, rating, and popularity.
**Add to Cart** – Users can add/remove products from the cart.
**Cart Page** – Displays selected items, total quantity, and price.
**Checkout Page** – Simple confirmation screen to simulate checkout.
**Dark Mode Toggle** – Optional feature (if enabled).
**Responsive UI** – Compatible with mobile, web (Chrome), and Android emulator.

## 📦 API Used
All product data is fetched from:
[https://fakestoreapi.com/](https://fakestoreapi.com/)

## 🚀 Getting Started

### Prerequisites:
Flutter SDK (v3.13.0 or later)
Dart SDK (v3.1.0 or later)
Android Studio or VS Code
Emulator or Chrome browser for testing

### Run the project:
flutter clean
flutter pub get
flutter run


### Folder Structure
lib

models           Data models (e.g., Product)
providers        State management using Provider
screens          UI screens (auth, home, cart, checkout)
services         API services
widgets          Reusable components like product card
main.dart        App entry point

### Testing Screenshots
Screenshots have been added in the documentation (Word) from:




