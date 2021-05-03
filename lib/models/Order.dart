import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String customerId;
  String storeId;
  String productId;
  String quantity;
  String date;
  String time;
  bool isCompleted;
  String status; //order accepted,in review,completed

  OrderModel(this.customerId, this.date, this.isCompleted, this.orderId,
      this.status, this.storeId, this.time);

  OrderModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    orderId = documentSnapshot.data["orderId"];
    customerId = documentSnapshot.data["customerId"];
    storeId = documentSnapshot.data["storeId"];
    date = documentSnapshot.data["date"];
    time = documentSnapshot.data["time"];
    isCompleted = documentSnapshot.data["isCompleted"];
    status = documentSnapshot.data["status"];
    productId = documentSnapshot.data["productId"];
    quantity = documentSnapshot.data["quantity"];
  }
}
