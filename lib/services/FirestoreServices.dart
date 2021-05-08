import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/CompletedOrderController.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/models/CheckOutTotal.dart';
import 'package:safeshopping/models/Order.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/models/ShoppingCart.dart';
import 'package:safeshopping/models/ShoppingCartTotal.dart';
import 'package:safeshopping/models/User.dart';
import 'package:safeshopping/utils/Scanner.dart';

class FirestoreServices extends GetxController {
  Firestore _db = Firestore.instance;

  Future getData(String collection) async {
    QuerySnapshot snapshot =
        await Firestore.instance.collection(collection).getDocuments();
    return snapshot.documents;
  }

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _db.collection("Customer").document(user.id).setData({
        "name": user.name,
        "email": user.email,
        "totalCartPrice": "0",
        "totalCheckout": "0",
      });
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

  Stream<int> cartTotalStream(String customerId) {
    return _db
        .collection("Customer")
        .document(customerId)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      int retVal = int.parse(documentSnapshot.data["totalCartPrice"]);
      print("cart total = " + retVal.toString());
      return retVal;
    });
  }

  Stream<int> checkOutTotalStream(String customerId) {
    return _db
        .collection("Customer")
        .document(customerId)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      int retVal = int.parse(documentSnapshot.data["totalCheckout"]);
      print("checkout total = " + retVal.toString());
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

  Stream<List<OrderModel>> getOngoingOrders(String userId) {
    return _db
        .collection("Customer")
        .document(userId)
        .collection("OngoingOrders")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<OrderModel> retVal = List();
      querySnapshot.documents.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      print("Ongoing order num = " + retVal.length.toString());
      return retVal;
    });
  }

  Stream<List<OrderModel>> getCompletedOrders(String userId) {
    return _db
        .collection("Customer")
        .document(userId)
        .collection("CompletedOrders")
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<OrderModel> retVal = List();
      querySnapshot.documents.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
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

  Future<ShoppingCartTotalModel> getShoppingCartTotal(String customerId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection("Customer").document(customerId).get();
      if (doc.exists) {
        ShoppingCartTotalModel _total =
            ShoppingCartTotalModel.fromDocumentSnapshot(doc);
        return _total;
      } else
        return null;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<CheckOutTotalModel> getCheckOutTotal(String customerId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection("Customer").document(customerId).get();
      if (doc.exists) {
        CheckOutTotalModel _total =
            CheckOutTotalModel.fromDocumentSnapshot(doc);
        return _total;
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
        ShoppingCartTotalModel total = await getShoppingCartTotal(customerId);
        await _db.collection("Customer").document(customerId).updateData({
          'totalCartPrice': (int.parse(total.totalPrice) +
                  (int.parse(quantity) * int.parse(price)))
              .toString()
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
        ShoppingCartTotalModel total = await getShoppingCartTotal(customerId);
        await _db.collection("Customer").document(customerId).updateData({
          'totalCartPrice': (int.parse(total.totalPrice) +
                  (int.parse(quantity) * int.parse(price)))
              .toString()
        });
      }
      Get.snackbar("Success", "Item added to the cart");
    } catch (e) {
      Get.snackbar("Failed", "Item failed to add to the cart");
      rethrow;
    }
  }

  Future<void> createTheOrder(String userId) async {
    try {
      List<ShoppingCartModel> orderItems =
          Get.find<ShoppingCartController>().shoppingList;
      orderItems.forEach((element) async {
        await _db
            .collection("Customer")
            .document(userId)
            .collection("OngoingOrders")
            .add({
          'customerId': userId,
          'storeId': element.storeId,
          'unitPrice': element.price,
          'qty': element.quantity,
          'productId': element.productId,
          'dateCreated': Timestamp.now(),
          'isCompleted': "false",
          'status': 'in review',
        });
        Get.snackbar("Success", "Order created successfully");
        //TODO:add method to add order to store
        deleteItemFromShoppingCart(userId, element.productId,
            int.parse(element.quantity), int.parse(element.price));
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> incrementQuantity(
      String customerId, String productId, int price) async {
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
        ShoppingCartTotalModel total = await getShoppingCartTotal(customerId);
        await _db.collection("Customer").document(customerId).updateData({
          'totalCartPrice': (int.parse(total.totalPrice) + price).toString()
        });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> decrementQuantity(
      String customerId, String productId, int price) async {
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
        ShoppingCartTotalModel total = await getShoppingCartTotal(customerId);
        await _db.collection("Customer").document(customerId).updateData({
          'totalCartPrice': (int.parse(total.totalPrice) - price).toString()
        });
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteItemFromShoppingCart(
      String customerId, String productId, int qty, int price) async {
    await _db
        .collection("Customer")
        .document(customerId)
        .collection("ShoppingCart")
        .document(productId)
        .delete();
    Get.snackbar("Success", "Item removed from shopping cart");
    ShoppingCartTotalModel total = await getShoppingCartTotal(customerId);
    await _db.collection("Customer").document(customerId).updateData({
      'totalCartPrice': (int.parse(total.totalPrice) - (price * qty)).toString()
    });
  }

  Future<void> deleteCompletedOrder(String userId, String orderId) async {
    await _db
        .collection("Customer")
        .document(userId)
        .collection("CompletedOrders")
        .document(orderId)
        .delete();
    Get.snackbar("Success", "Order removed successfully");
  }

  Future<void> collectOrderFromStore() async {
    try {
      int total = 0;
      String storeId = await Scanner().scanQrCode();
      List<OrderModel> orderList =
          Get.find<CompletedOrderController>().orderList;
      orderList.forEach((element) async {
        if (element.storeId == storeId) {
          _db
              .collection("Stores")
              .document(storeId)
              .collection("AwaitingOrders")
              .document(element.orderId)
              .setData({
            "productId": element.productId,
            "quantity": element.qty,
            "customerId": element.customerId,
            "dateCreated": element.dateCreated,
          });
          _db
              .collection("Customer")
              .document(element.customerId)
              .collection("CheckoutOrders")
              .document(element.orderId)
              .setData({
            "productId": element.productId,
            "quantity": element.qty,
            "customerId": element.customerId,
            "dateCreated": element.dateCreated,
          });
          total += element.qty * element.unitPrice;
          CheckOutTotalModel checkOutTotalModel =
              await getCheckOutTotal(element.customerId);
          await _db
              .collection("Customer")
              .document(element.customerId)
              .updateData({
            "totalCheckout":
                (int.parse(checkOutTotalModel.totalCheckout) + total)
                    .toString(),
          });
        }
      });
    } catch (e) {
      print(e);
      rethrow;
    }
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
