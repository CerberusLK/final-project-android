import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/models/User.dart';

class FirestoreServices extends GetxController {
  Firestore _db = Firestore.instance;

  Future getData(String collection) async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection(collection).getDocuments();
    return snapshot.documents;
  }

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _db
          .collection("Customer")
          .document(user.id)
          .setData({"name": user.name, "email": user.email});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _db.collection("Customer").document(uid).get();
      UserModel _userModel = UserModel.fromDocumentSnapshot(doc);
      print(_userModel.id);
      print(_userModel.name);
      print(_userModel.email);
      return _userModel;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<ProductModel>> productStream() {
    return _db
        .collection("Products")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ProductModel> retVal = List();
      querySnapshot.documents.forEach((element) {
        retVal.add(ProductModel.fromDocumentSnapshot(element));
      });
      print(retVal.length);
      print(retVal[0].productName);
      return retVal;
    });
  }

// Future<List<ProductModel>> getProducts() async {
//   QuerySnapshot querySnapshot =
//       await _db.collection("Products").getDocuments();

// List<DocumentSnapshot> templist;
// List<Map<dynamic, dynamic>> list = new List();
// list = templist.map((DocumentSnapshot documentSnapshot) {
//   return documentSnapshot.data;
// }).toList();

// return list;
// return querySnapshot.documents.map((e) => ProductModel(
//       e.documentID,
//       e.data['brand name'],
//       e.data['price'],
//       e.data['product name'],
//       e.data['quantity'],
//       e.data['storeId'],
//     ));
}
