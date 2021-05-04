import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:safeshopping/controllers/AuthController.dart';
import 'package:safeshopping/controllers/ShoppingCartController.dart';
import 'package:safeshopping/models/Product.dart';
import 'package:safeshopping/services/FirestoreServices.dart';

class ShoppingCartPage extends GetWidget<ShoppingCartController> {
  ShoppingCartController shoppingCartController =
      Get.put(ShoppingCartController());
  AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    int total = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => StaggeredGridView.countBuilder(
                crossAxisCount: 1,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                itemCount: shoppingCartController.shoppingList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<ProductModel>(
                      future: FirestoreServices().getProduct(
                          shoppingCartController.shoppingList[index].productId),
                      builder: (context, productModel) {
                        if (productModel.hasData) {
                          int _total = int.parse(productModel.data.price) *
                              int.parse(shoppingCartController
                                  .shoppingList[index].quantity);
                          total = total + _total;
                          return Card(
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.memory(Base64Codec()
                                      .decode(productModel.data.imgString)),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(productModel.data.productName),
                                      Text(productModel.data.brandName),
                                      Text("Item Price: " +
                                          "Rs." +
                                          productModel.data.price +
                                          ".00"),
                                      // Text(
                                      //   "Total : " +
                                      //       "Rs." +
                                      //       total.toString() +
                                      //       ".00",
                                      //   style: TextStyle(
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                FirestoreServices()
                                                    .decrementQuantity(
                                                        _authController
                                                            .user.uid,
                                                        shoppingCartController
                                                            .shoppingList[index]
                                                            .productId);
                                              }),
                                          Text(shoppingCartController
                                              .shoppingList[index].quantity),
                                          IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                FirestoreServices()
                                                    .incrementQuantity(
                                                        _authController
                                                            .user.uid,
                                                        shoppingCartController
                                                            .shoppingList[index]
                                                            .productId);
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text("Loading...");
                        }
                      });
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1))),
          ),
          BottomAppBar(
            child: Row(
              children: [
                Obx(() => Text(shoppingCartController.total.toString())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
