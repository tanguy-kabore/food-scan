import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../history_utils.dart';

import 'product_details.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _productDataList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedProducts();
  }

  Future<void> _loadSavedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    List<Map<String, dynamic>> productDataList = [];

    for (String key in keys) {
      // Ignore keys that are boolean
      if (prefs.get(key) is bool) {
        continue;
      }
      final productDataString = prefs.getString(key);
      if (productDataString != null) {
        final productData =
            jsonDecode(productDataString) as Map<String, dynamic>;
        productData['key'] = key; // Store the key in the product data
        productDataList.add(productData);
      }
    }

    setState(() {
      _productDataList = productDataList;
    });
  }

  Future<void> _deleteProduct(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _loadSavedProducts();
  }

  void _showProductDetails(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: _productDataList.length,
        itemBuilder: (context, index) {
          final productData = _productDataList[index];
          final product = Product.fromJson(productData['product']);
          final createdAt = DateTime.parse(productData['createdAt']);
          final formattedDate =
              DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
          final latitude = productData['location']['latitude'];
          final longitude = productData['location']['longitude'];
          final key =
              productData['key'] as String; // Ensure the key is a string

          return FutureBuilder(
            future: getCityAndCountry(latitude, longitude),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(
                  title: Text(product.productName ?? 'Unknown Product'),
                  subtitle: const Text('Loading location...'),
                  onTap: () => _showProductDetails(product),
                );
              } else {
                return ListTile(
                  leading: product.images != null && product.images!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(7.0),
                          child: CachedNetworkImage(
                            imageUrl: product.images!.first.url!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ))
                      : const Icon(Icons.image_not_supported),
                  title: Text(product.productName ?? 'Unknown Product'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Created At: $formattedDate'),
                      Text('Location: ${snapshot.data}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () => showLocationDialog(
                            context, key, latitude, longitude, _deleteProduct),
                        tooltip: 'Location Options',
                      ),
                    ],
                  ),
                  onTap: () => _showProductDetails(product),
                );
              }
            },
          );
        },
      ),
    );
  }
}
