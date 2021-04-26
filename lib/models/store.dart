import 'package:flutter/material.dart';

class Store {
  final String storeId;
  final String city;
  final String name;
  final String ownerId;
  final String phone;
  final String image;

  Store(
      {this.city,
        this.name,
        this.ownerId,
        this.phone,
        @required this.storeId,
        this.image});

  Store.fromMap(Map<String, dynamic> data, String id)
      : this(
    storeId: id,
    city: data["Store City"],
    name: data["Store Name"],
    ownerId: data["Store Owner"],
    phone: data["Store Phone"],
    image: data["Store Photo"],
  );
}
