import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../data/openfoodfacts.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  /// Construit une instance de [ProductRepositoryImpl] avec la [remoteDataSource] requise.
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> getProduct(
      BuildContext context,
      String barcode,
      Function(bool p1) setLoadingState,
      Function(Product? p1) setProduct) async {
    return remoteDataSource.getProduct(
        context, barcode, (p0) => null, (p0) => null);
  }
}
