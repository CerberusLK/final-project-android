import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOutTotalModel {
  String totalCheckout;

  CheckOutTotalModel({
    this.totalCheckout,
  });

  CheckOutTotalModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    totalCheckout = documentSnapshot.data["totalCheckout"];
  }
}
