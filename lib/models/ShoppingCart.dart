import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartModel {
  String storeId;
  Timestamp dataAdded;
  String productId;
  String quantity;
  String price;

  ShoppingCartModel({
    this.dataAdded,
    this.productId,
    this.quantity,
    this.storeId,
    this.price,
  });

  ShoppingCartModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    storeId = documentSnapshot.data["storeId"];
    dataAdded = documentSnapshot.data["dataAdded"];
    productId = documentSnapshot.data["productId"];
    quantity = documentSnapshot.data["quantity"];
    price = documentSnapshot.data["price"];
  }
}
