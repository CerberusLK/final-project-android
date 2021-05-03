import 'dart:convert';

import 'package:flutter/material.dart';

class Convertions {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}
