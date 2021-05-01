import 'package:get/get.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ProductController extends GetxController {
  Rx<List<ProductModel>> productList = Rx<List<ProductModel>>();

  List<ProductModel> get products => productList.value;

  @override
  void onInit() {
    productList.bindStream(
        FirestoreServices().productStream()); //stream coming from firebase
    print(productList);
  }
}
