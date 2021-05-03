import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String productName;
  String price;
  String quantity;
  String measurement;
  String storeId;
  String brandName;
  String imgString;

  ProductModel(this.measurement, this.price, this.productId, this.productName,
      this.quantity, this.storeId, this.brandName, this.imgString);

  ProductModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    productId = documentSnapshot.documentID;
    productName = documentSnapshot.data["productName"];
    price = documentSnapshot.data["price"];
    quantity = documentSnapshot.data["quantity"];
    measurement = documentSnapshot.data["measurement"];
    storeId = documentSnapshot.data["storeId"];
    brandName = documentSnapshot.data["brandName"];
    imgString = documentSnapshot.data["imgString"];
  }
}
