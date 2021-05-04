import 'package:get/get.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';

class ShoppingCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppingCartController>(() => ShoppingCartController());
  }
}
