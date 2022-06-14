import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_uzzubiju/datas/products_data.dart';

class CartProduct {
  late String cid;
  late String category;
  late String pid;
  late int quantity;
  late String size;
  late String typePayment;

  ProductsData productsData = ProductsData();
  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document["category"];
    pid = document["pid"];
    quantity = document["quantity"];
    size = document["size"];
    typePayment = document["typePayment"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "typePayment": typePayment,
      "product": productsData.toResumedMap(),
    };
  }
}
