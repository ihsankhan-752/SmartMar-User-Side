import 'package:flutter/cupertino.dart';

class Product {
  String name;
  double price;
  int quantity = 1;
  int inStock;
  String docId;
  List imageUrl;
  String supplierId;

  Product({
    required this.quantity,
    required this.price,
    required this.name,
    required this.supplierId,
    required this.docId,
    required this.imageUrl,
    required this.inStock,
  });
}

class CartController extends ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _items;

  int get itemsLength {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    for (var items in _items) {
      total += items.price * items.quantity;
    }
    return total;
  }

  void addItemToCart(
    String name,
    double price,
    int quantity,
    int inStock,
    String docId,
    List imageUrl,
    String supplierId,
  ) {
    final product = Product(
        quantity: quantity,
        price: price,
        name: name,
        supplierId: supplierId,
        docId: docId,
        imageUrl: imageUrl,
        inStock: inStock);
    _items.add(product);
    notifyListeners();
  }

  void increment(Product product) {
    product.quantity++;
    notifyListeners();
  }

  void decrement(Product product) {
    product.quantity--;
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
