import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:share/share.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../../home/widgets/image_carousel.dart';
import '../../home/widgets/product_details_table.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _apiKey = dotenv.env['GEMINI_API_KEY'];
  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey!,
    );
    _chat = _model.startChat();
  }

  Future<void> _shareOnWhatsApp(BuildContext context) async {
    String productName = widget.product.productName ?? 'Unknown Product';
    String productDescription =
        widget.product.ingredientsText ?? 'No description available';
    String productDetails = '''
      Product Name: $productName
      Description: $productDescription
      ''';

    try {
      String aiResponse = await _sendToAIForAnalysis(productDetails);
      await Share.share(aiResponse, subject: 'Product Analysis');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to analyze product: $e')),
        );
      }
    }
  }

  Future<String> _sendToAIForAnalysis(String productDetails) async {
    try {
      var response = await _chat.sendMessage(
        Content.text(
            'Analyze the following product details and provide a brief summary:\n$productDetails'),
      );

      var text = response.text;
      if (text == null) {
        throw Exception('No response from API.');
      }
      return _correctAndFormatText(text);
    } catch (e) {
      throw Exception('Failed to get response from AI: $e');
    }
  }

  String _correctAndFormatText(String text) {
    text = text.replaceAll('\n', '\n');
    text = text.replaceAll('Product Name:', 'Nom du Produit:');
    text = text.replaceAll('Description:', 'Description:');
    return text;
  }

  Future<void> _showAIAnalysis(BuildContext context) async {
    String productName = widget.product.productName ?? 'Unknown Product';
    String productDescription =
        widget.product.ingredientsText ?? 'No description available';
    String productDetails = '''
      Product Name: $productName
      Description: $productDescription
      ''';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('AI Analysis'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Veuillez patienter que nous analysions les résultats...')
            ],
          ),
        );
      },
    );

    try {
      String aiResponse = await _sendToAIForAnalysis(productDetails);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AI Analysis'),
            content: SingleChildScrollView(
              child: Text(aiResponse),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to analyze product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.productName ?? 'Product Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.product.images != null &&
                    widget.product.images!.isNotEmpty)
                  ImageCarousel(images: widget.product.images!),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _showAIAnalysis(context),
                      icon: const Icon(Icons.analytics),
                      tooltip: 'AI Analysis',
                    ),
                    IconButton(
                      onPressed: () => _shareOnWhatsApp(context),
                      icon: const Icon(Icons.share),
                      tooltip: 'Share on WhatsApp',
                    ),
                  ],
                ),
                ProductDetailsTable(product: widget.product),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
