// lib/widgets/product_details_table.dart

import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductDetailsTable extends StatelessWidget {
  final Product product;

  const ProductDetailsTable({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'This table contains basic product details such as name, brand, and quantity.',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        _buildTable(
          [
            _buildTableRow('Barcode', product.barcode),
            _buildTableRow('Product Name', product.productName),
            _buildTableRow('Generic Name', product.genericName),
            _buildTableRow('Brands', product.brands),
            _buildTableRow('Quantity', product.quantity),
            _buildTableRow('Packaging', product.packaging),
            _buildTableRow('Categories', product.categories),
            _buildTableRow('Labels', product.labels),
            _buildTableRow('Origins', product.origins),
            _buildTableRow('Manufacturing Places', product.manufacturingPlaces),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Nutritional Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'This table provides nutritional information including serving size and scores.',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        _buildTable(
          [
            _buildTableRow('Serving Size', product.servingSize),
            _buildTableRow(
                'Serving Quantity', product.servingQuantity?.toString()),
            _buildTableRow('Nutriments', _formatNutriments(product.nutriments)),
            _buildTableRow('Nova Group', product.novaGroup?.toString()),
            _buildTableRow('Nutri-Score', product.nutriscore),
            _buildTableRow('Eco-Score Grade', product.ecoscoreGrade),
            _buildTableRow(
                'Eco-Score Score', product.ecoscoreScore?.toString()),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Additives and Allergens',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'This table lists any additives and allergens present in the product.',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        _buildTable(
          [
            _buildTableRow('Additives', product.additives?.names.join(', ')),
            _buildTableRow('Allergens', product.allergens?.names.join(', ')),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Additional Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'This table contains additional product details such as ingredients and expiration date.',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
        _buildTable(
          [
            _buildTableRow('Ingredients', product.ingredientsText),
            _buildTableRow('Stores', product.stores),
            _buildTableRow('Traces', product.tracesTags?.join(', ')),
            _buildTableRow(
                'Packaging Quantity', product.packagingQuantity?.toString()),
            _buildTableRow('Expiration Date', product.expirationDate),
          ],
        ),
      ],
    );
  }

  Widget _buildTable(List<TableRow> rows) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: rows,
    );
  }

  TableRow _buildTableRow(String title, String? value) {
    return TableRow(
      children: [
        _buildTableCell(title),
        _buildTableCell(value ?? 'N/A'),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  String _formatNutriments(Nutriments? nutriments) {
    if (nutriments == null) return 'N/A';

    final Map<String, dynamic> nutrientMap = nutriments.toJson();
    return nutrientMap.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join('\n');
  }
}
