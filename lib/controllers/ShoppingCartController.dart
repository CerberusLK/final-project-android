import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/models/ShoppingCart.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartController extends GetxController {
  Rx<List<ShoppingCartModel>> _shoppingCart = Rx<List<ShoppingCartModel>>();
  var total = 0.obs;

  List<ShoppingCartModel> get shoppingList => _shoppingCart.value;

  void calTot() {
    shoppingList.forEach((element) {
      var _total = int.parse(element.price) * int.parse(element.quantity);
      total = total + _total;
    });
  }

  @override
  void onInit() {
    String userId = Get.find<AuthController>().user.uid;
    _shoppingCart.bindStream(FirestoreServices().shoppingCartStream(userId));
  }
}
