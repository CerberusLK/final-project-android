import 'package:get/get.dart';
import 'package:safeshopping/models/Order.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

import 'AuthController.dart';

class ReadyToCollectOrderController extends GetxController {
  Rx<List<OrderModel>> _onGoingOrderList = Rx<List<OrderModel>>();
  List<OrderModel> get orderList => _onGoingOrderList.value;

  @override
  void onInit() {
    super.onInit();
    String userId = Get.find<AuthController>().user.uid;
    _onGoingOrderList
        .bindStream(FirestoreServices().getReadyToCollectOrders(userId));
  }
}
