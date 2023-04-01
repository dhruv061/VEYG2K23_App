import 'package:flutter/foundation.dart';

class CartItem {
  String name;
  double price;
  int quantity;

  CartItem({required this.name, required this.price, required this.quantity});
}

class CartModel extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // //consider 2% texes
  // double get gamePriceTax => _items.fold(
  //     0, (sum, item) => ((sum + item.price * item.quantity * 2.5) / 100));

  //total game price with taxes
  double get totalPrice =>
      _items.fold(0, (sum, item) => (sum + item.price * item.quantity));

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  //this is help to retrive number of team members in game office tennis
  int get quantityforOfficeTennis {
    return _items.fold(0, (sum, item) => item.quantity);
  }

  //add price
  void addItem(CartItem item) {
    var index = _items.indexWhere((i) => i.name == item.name);
    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
