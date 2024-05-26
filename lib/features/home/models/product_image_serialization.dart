import 'package:openfoodfacts/openfoodfacts.dart';

extension ProductImageSerialization on ProductImage {
  static ProductImage fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: json['url'],
      field: json['field'],
      language: OpenFoodFactsLanguage.ENGLISH,
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'field': field,
      'size': size,
    };
  }
}
