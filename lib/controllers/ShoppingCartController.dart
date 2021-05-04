import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/models/ShoppingCart.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartController extends GetxController {
  Rx<List<ShoppingCartModel>> _shoppingCart = Rx<List<ShoppingCartModel>>();

  List<ShoppingCartModel> get shoppingList => _shoppingCart.value;

  @override
  void onInit() {
    String userId = Get.find<AuthController>().user.uid;
    _shoppingCart.bindStream(FirestoreServices().shoppingCartStream(userId));
  }
}
