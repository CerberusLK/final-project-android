import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String vendorId;
  String vendorName;
  String vendorEmail;

  VendorModel(
    this.vendorEmail,
    this.vendorId,
    this.vendorName,
  );

  VendorModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    vendorId = documentSnapshot.documentID;
    vendorEmail = documentSnapshot.data["email"];
    vendorName = documentSnapshot.data["name"];
  }
}
