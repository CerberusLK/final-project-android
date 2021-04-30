import 'package:get/state_manager.dart';
import 'package:safeshopping/models/store.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class StoreController extends GetxController {
  FirestoreServices _firestoreServices = FirestoreServices();

  var productList = List<Store>().obs;

  void fetchProducts() {
    productList = _firestoreServices.getProducts() as RxList<Store>;
  }
}
