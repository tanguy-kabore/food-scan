import 'package:openfoodfacts/openfoodfacts.dart';
import 'product_image_serialization.dart';

extension ProductSerialization on Product {
  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'productName': productName,
      'genericName': genericName,
      'brands': brands,
      'quantity': quantity,
      'packaging': packaging,
      'categories': categories,
      'labels': labels,
      'origins': origins,
      'manufacturingPlaces': manufacturingPlaces,
      'servingSize': servingSize,
      'servingQuantity': servingQuantity,
      'nutriments': nutriments?.toJson(),
      'novaGroup': novaGroup,
      'nutriscore': nutriscore,
      'ecoscoreGrade': ecoscoreGrade,
      'ecoscoreScore': ecoscoreScore,
      'additives': additives?.names,
      'allergens': allergens?.names,
      'ingredientsText': ingredientsText,
      'stores': stores,
      'tracesTags': tracesTags,
      'packagingQuantity': packagingQuantity,
      'expirationDate': expirationDate,
      'images': images?.map((image) => image.toJson()).toList(),
    };
  }
}