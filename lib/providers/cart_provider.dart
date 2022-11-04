import 'package:flutter/material.dart';

class Product {
  String name;
  double price;
  int qty = 1;
  int qntty;
  List imagesUrl;
  String documentId;
  String suppId;
  Product(
      {required this.name,
      required this.price,
      required this.qty,
      required this.qntty,
      required this.imagesUrl,
      required this.documentId,
      required this.suppId});

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}

class Cart extends ChangeNotifier {
  final List<Product> _list = [];
  List<Product> get getItems {
    return _list;
  }

  int? get count {
    _list.length;
  }

  void addItem(
    String name,
    double price,
    int qty,
    int qntty,
    List imagesUrl,
    String documentId,
    String suppId,
  ) {
    final product = Product(
        name: name,
        price: price,
        qty: qty,
        qntty: qntty,
        imagesUrl: imagesUrl,
        documentId: documentId,
        suppId: suppId);
    _list.add(product);
    notifyListeners();
  }

  void increament(Product product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(Product product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(Product product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}
