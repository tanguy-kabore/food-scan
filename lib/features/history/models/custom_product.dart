import 'package:openfoodfacts/openfoodfacts.dart';

class ProductData {
  final Product product;
  final DateTime createdAt;
  final Map<String, dynamic> location;

  ProductData(this.product, this.createdAt, this.location);
}