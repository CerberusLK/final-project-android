import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgText;
  final String productName;
  final String productPrice;

  const ProductCard(
      {Key key, this.imgText, this.productName, this.productPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            child: Image(image: AssetImage("assets/safe_shopping_logo.png")),
          )
        ],
      ),
    );
  }
}
