import 'package:flutter/cupertino.dart';

import 'cart_controller.dart';

class WishListController extends ChangeNotifier {
  List<Product> _wishListItems = [];

  List<Product> get wishListItems => _wishListItems;

  void addToWishList(
    String name,
    double price,
    int quantity,
    int inStock,
    String docId,
    List imageUrl,
    String supplierId,
  ) {
    final wishListProduct = Product(
      quantity: quantity,
      price: price,
      name: name,
      supplierId: supplierId,
      docId: docId,
      imageUrl: imageUrl,
      inStock: inStock,
    );
    _wishListItems.add(wishListProduct);
    notifyListeners();
  }
}
