import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductRemoteDataSource {
  Future<void> getProduct(
    BuildContext context,
    String barcode,
    Function(bool) setLoadingState,
    Function(Product?) setProduct,
  ) async {
    setLoadingState(true);

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.ENGLISH,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );

    try {
      final ProductResultV3 result =
          await OpenFoodAPIClient.getProductV3(configuration);

      if (result.status == ProductResultV3.statusSuccess) {
        setProduct(result.product);
        setLoadingState(false);
      } else {
        setLoadingState(false);
        throw Exception('Product not found, please insert data for $barcode');
      }
    } catch (e) {
      setLoadingState(false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception: $e')),
        );
      }
    }
  }
}
