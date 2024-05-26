import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

abstract class ProductRepository {
  Future<void> getProduct(
    BuildContext context,
    String barcode,
    Function(bool) setLoadingState,
    Function(Product?) setProduct,
  );
}
