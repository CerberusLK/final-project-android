import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ProductController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/models/ShoppingCart.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartController extends GetxController {
  Rx<List<ShoppingCartModel>> _shoppingCart = Rx<List<ShoppingCartModel>>();
  RxInt total = 0.obs;
  ProductController productController = Get.find<ProductController>();

  List<ShoppingCartModel> get shoppingList => _shoppingCart.value;

  // void totalCal() {
  //   for (int i = 0; i < shoppingList.length; i++) {
  //     ProductModel productModel = FirestoreServices()
  //         .getProduct(shoppingList[i].productId) as ProductModel;
  //     total = (int.parse(shoppingList[i].quantity) *
  //         int.parse(productModel.price)) as RxInt;
  //   }
  // }

  // void calTot() {
  //   shoppingList.forEach((element) {
  //     int price;
  //     for (int i = 0; i < productController.products.length; i++) {
  //       if (productController.products[i].productId == element.productId) {
  //         total = total +
  //             int.parse(element.quantity) *
  //                 int.parse(productController.products[i].price);
  //       }
  //     }
  //   });
  // }

  @override
  void onInit() {
    String userId = Get.find<AuthController>().user.uid;
    _shoppingCart.bindStream(FirestoreServices().shoppingCartStream(userId));
  }
}
