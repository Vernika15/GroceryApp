import 'package:flutter/material.dart';
import 'package:online_groceries_app/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _items = {};

  Map<int, int> get items => _items;

  void addToCart(Product product) {
    _items.update(product.id, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id] = _items[product.id]! - 1;
      if (_items[product.id]! <= 0) {
        _items.remove(product.id);
      }
      notifyListeners();
    }
  }

  int getQuantity(Product product) {
    return _items[product.id] ?? 0;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
