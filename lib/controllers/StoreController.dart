import 'package:get/get.dart';
import 'package:safeshopping/models/store.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class StoreController extends GetxController {
  Rx<List<StoreModel>> _storeList = Rx<List<StoreModel>>();
  List<StoreModel> get storeList => _storeList.value;

  @override
  void onInit() {
    super.onInit();
    _storeList.bindStream(FirestoreServices().getStrores());
  }
}
