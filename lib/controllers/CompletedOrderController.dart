import 'package:get/get.dart';
import 'package:safeshopping/models/Order.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'AuthController.dart';

class CompletedOrderController extends GetxController {
  Rx<List<OrderModel>> _completedOrderList = Rx<List<OrderModel>>();
  List<OrderModel> get orderList => _completedOrderList.value;

  @override
  void onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().user.uid;
    _completedOrderList
        .bindStream(FirestoreServices().getCompletedOrders(userId));
  }
}
