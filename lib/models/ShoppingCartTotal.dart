import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingCartTotalModel {
  String totalPrice;

  ShoppingCartTotalModel({this.totalPrice});

  ShoppingCartTotalModel.fromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    totalPrice = documentSnapshot.data["totalCartPrice"];
  }
}
