import 'package:get/get.dart';
import 'package:safeshopping/models/CheckoutOrder.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'AuthController.dart';

class CheckoutOrderController extends GetxController {
  Rx<List<CheckoutOrderModel>> _checkoutOrderList =
      Rx<List<CheckoutOrderModel>>();

  List<CheckoutOrderModel> get checkoutOrderList => _checkoutOrderList.value;

  @override
  void onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().user.uid;
    _checkoutOrderList
        .bindStream(FirestoreServices().getCheckoutOrders(userId));
  }
}
