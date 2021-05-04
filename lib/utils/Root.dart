import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/controllers/UserController.dart';
import 'package:safeshopping/pages/SearchStore.dart';
import 'package:safeshopping/pages/UserLogin.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(initState: (_) async {
      Get.put<UserController>(UserController());
      Get.put(ShoppingCartController());
    }, builder: (_) {
      if (Get.find<AuthController>().user?.uid != null) {
        return SearchStore();
      } else {
        return UserLogin();
      }
    });
  }
}
