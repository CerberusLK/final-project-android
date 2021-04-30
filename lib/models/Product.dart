import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String productId;
  String productName;
  double price;
  double quantity;
  String measurement;
  String storeId;

  ProductModel(
    String _productId,
    String _productName,
    double _price,
    double _quantity,
    String _measurement,
    String _storeId,
  )   : this.productId = _productId,
        this.price = _price,
        this.quantity = _quantity,
        this.measurement = _measurement,
        this.storeId = _storeId;

  ProductModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    productId = documentSnapshot.documentID;
    productName = documentSnapshot.data["productName"];
    price = double.parse(documentSnapshot.data["price"]);
    quantity = double.parse(documentSnapshot.data["quantity"]);
    measurement = documentSnapshot.data["measurement"];
    storeId = documentSnapshot.data["storeId"];
  }
}
