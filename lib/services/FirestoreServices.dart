import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/models/ShoppingCart.dart';
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

  Future<ProductModel> getProduct(String productId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection("Products").document(productId).get();
      ProductModel _productModel = ProductModel.fromDocumentSnapshot(doc);
      return _productModel;
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

  Stream<List<ShoppingCartModel>> shoppingCartStream(String userId) {
    return _db
        .collection("Customer")
        .document(userId)
        .collection("ShoppingCart")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<ShoppingCartModel> retVal = List();
      querySnapshot.documents.forEach((element) {
        retVal.add(ShoppingCartModel.fromDocumentSnapshot(element));
      });
      print("shopping cart = " + retVal.length.toString());
      return retVal;
    });
  }

  Future<ShoppingCartModel> getShoppingCartItem(
      String productId, String userId) async {
    try {
      DocumentSnapshot doc = await _db
          .collection("Customer")
          .document(userId)
          .collection("ShoppingCart")
          .document(productId)
          .get();
      if (doc.exists) {
        ShoppingCartModel _shoppingCartModel =
            ShoppingCartModel.fromDocumentSnapshot(doc);
        return _shoppingCartModel;
      } else
        return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addToShoppingCart(String customerId, String storeId,
      String productId, String quantity, String price) async {
    ShoppingCartModel item = await getShoppingCartItem(productId, customerId);
    try {
      if (item == null) {
        await _db
            .collection("Customer")
            .document(customerId)
            .collection("ShoppingCart")
            .document(productId)
            .setData({
          'storeId': storeId,
          'productId': productId,
          'quantity': quantity,
          'dateAdded': Timestamp.now(),
          'price': price,
        });
      } else {
        int qty = int.parse(quantity) + int.parse(item.quantity);
        await _db
            .collection("Customer")
            .document(customerId)
            .collection("ShoppingCart")
            .document(productId)
            .updateData({
          'quantity': qty.toString(),
          'dateAdded': Timestamp.now(),
        });
      }
      Get.snackbar("Success", "Item added to the cart");
    } catch (e) {
      Get.snackbar("Failed", "Item failed to add to the cart");
      rethrow;
    }
  }

  Future<void> incrementQuantity(String customerId, String productId) async {
    ShoppingCartModel item = await getShoppingCartItem(productId, customerId);
    try {
      int qty = int.parse(item.quantity) + 1;
      if (qty == 21) {
        Get.snackbar("Error", "You might need to contact the Seller");
      } else {
        await _db
            .collection("Customer")
            .document(customerId)
            .collection("ShoppingCart")
            .document(productId)
            .updateData({
          'quantity': qty.toString(),
        });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> decrementQuantity(String customerId, String productId) async {
    ShoppingCartModel item = await getShoppingCartItem(productId, customerId);
    try {
      int qty = int.parse(item.quantity) - 1;
      if (qty == 0) {
        Get.snackbar("Error", "Quantity cannot be 0");
      } else {
        await _db
            .collection("Customer")
            .document(customerId)
            .collection("ShoppingCart")
            .document(productId)
            .updateData({
          'quantity': qty.toString(),
        });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteItemFromShoppingCart(
      String customerId, String productId) async {
    await _db
        .collection("Customer")
        .document(customerId)
        .collection("ShoppingCart")
        .document(productId)
        .delete();
    Get.snackbar("Success", "Item removed from shopping cart");
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
