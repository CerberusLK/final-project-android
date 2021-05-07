import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ProductController.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/controllers/UserController.dart';
import 'package:safeshopping/pages/SearchStore.dart';
import 'package:safeshopping/pages/UserLogin.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(initState: (_) async {
      Get.put<UserController>(UserController());
    }, builder: (_) {
      if (Get.find<AuthController>().user?.uid != null) {
        Get.put<ProductController>(ProductController());
        Get.put<ShoppingCartController>(ShoppingCartController());
        return SearchStore();
      } else {
        return UserLogin();
      }
    });
  }
}
