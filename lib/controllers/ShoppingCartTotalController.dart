import 'package:get/get.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'AuthController.dart';

class SHoppingCartTotalController extends GetxController {
  var cartTotal = RxInt();

  int get total => cartTotal.value;

  @override
  void onInit() {
    String userId = Get.find<AuthController>().user.uid;
    cartTotal.bindStream(FirestoreServices().cartTotalStream(userId));
  }
}
