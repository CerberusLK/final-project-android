import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String customerId;
  String storeId;
  Map products;
  Timestamp dateCreated;
  String time;
  bool isCompleted;
  bool isOrdered;
  String status; //order accepted,in review,completed

  OrderModel(this.customerId, this.dateCreated, this.isCompleted, this.orderId,
      this.status, this.storeId, this.time, this.products, this.isOrdered);

  OrderModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    orderId = documentSnapshot.data["orderId"];
    customerId = documentSnapshot.data["customerId"];
    storeId = documentSnapshot.data["storeId"];
    dateCreated = documentSnapshot.data["date"];
    time = documentSnapshot.data["time"];
    isCompleted = documentSnapshot.data["isCompleted"];
    status = documentSnapshot.data["status"];
    products = documentSnapshot.data["productList"];
    isOrdered = documentSnapshot.data["isOrdered"];
  }
}
