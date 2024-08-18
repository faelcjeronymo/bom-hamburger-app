import 'dart:convert';

import 'package:flutter/services.dart';

class Product {
  //TODO - Verificar se realmente vai ser usada a classe products
  
  final int productId;
  final String productName;
  final String productType;
  final double productValue;
  final String productImage;

  const Product({
    required this.productId,
    required this.productName,
    required this.productType,
    required this.productValue,
    required this.productImage,
  });
  
}
