import 'package:get/get.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'AuthController.dart';

class CheckOutTotalController extends GetxController {
  var _checkoutTotal = RxInt();

  int get checkOutTotal => _checkoutTotal.value;

  @override
  void onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().user.uid;
    _checkoutTotal.bindStream(FirestoreServices().checkOutTotalStream(userId));
  }
}
