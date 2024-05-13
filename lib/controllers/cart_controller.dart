import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_mart_user_side/controllers/user_controller.dart';
import 'package:smart_mart_user_side/models/cart_model.dart';

class CartController extends ChangeNotifier {
  CartModel? _cartModel;
  CartModel? get cartModel => _cartModel;

  getCartItem(BuildContext context) async {
    try {
      final userController = Provider.of<UserController>(context).userModel;
      for (var id in userController!.cart!) {
        await FirebaseFirestore.instance.collection('cart').doc(id).snapshots().listen(
          (snap) {
            if (snap.exists) {
              _cartModel = CartModel.fromMap(snap);
            } else {
              throw "No ProductFound";
            }
          },
        );
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
