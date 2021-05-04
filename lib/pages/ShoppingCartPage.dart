import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartPage extends GetWidget<ShoppingCartController> {
  final shoppingCartController = Get.put(ShoppingCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                itemCount: shoppingCartController.shoppingList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<ProductModel>(
                      future: FirestoreServices().getProduct(
                          shoppingCartController.shoppingList[index].productId),
                      builder: (context, productModel) {
                        if (productModel.hasData) {
                          return Row(
                            children: [Text(productModel.data.productName)],
                          );
                        } else {
                          return Text("Loading...");
                        }
                      });
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1))),
          ),
        ],
      ),
    );
  }
}
