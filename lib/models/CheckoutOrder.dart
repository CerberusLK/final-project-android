import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutOrderModel {
  String productId;
  String customerId;
  int qty;
  Timestamp orderCreated;
  String productName;
  String brandName;
  int unitPrice;

  CheckoutOrderModel({
    this.customerId,
    this.orderCreated,
    this.productId,
    this.qty,
    this.brandName,
    this.productName,
    this.unitPrice,
  });

  CheckoutOrderModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    productId = documentSnapshot.data["productId"];
    customerId = documentSnapshot.data["customerId"];
    qty = documentSnapshot.data["quantity"];
    orderCreated = documentSnapshot.data["dateCreated"];
    productName = documentSnapshot.data["productName"];
    brandName = documentSnapshot.data["productBrand"];
    unitPrice = documentSnapshot.data["unitPrice"];
  }
}
