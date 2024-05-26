import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../constants/images.dart';
import '../../../menus.dart';
import '../home_utils.dart';
import '../widgets/image_carousel.dart';
import '../widgets/product_details_table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  Product? _product;
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final _apiKey = dotenv.env['GEMINI_API_KEY'];

  @override
  void initState() {
    super.initState();
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'foodscan');
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey!,
    );
    _chat = _model.startChat();
  }

  Future<void> _scanBarcode() async {
    try {
      final ScanResult scanResult = await BarcodeScanner.scan(
        options: const ScanOptions(
          autoEnableFlash: true,
        ),
      );
      final String barcode = scanResult.rawContent;

      if (barcode.isNotEmpty) {
        await _getProduct(barcode);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scan failed: $e')),
      );
    }
  }

  Future<void> _getProduct(String barcode) async {
    setState(() {
      _isLoading = true;
    });

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
        setState(() {
          _product = result.product;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Product not found, please insert data for $barcode');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exception: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('foodscan'),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return ActionMenu.buildMenu('home');
              },
              onSelected: (value) {
                if (value == 'settings') {
                  Navigator.pushNamed(context, '/settings');
                }
                if (value == 'logout') {
                  logout(context);
                }
              },
            ),
          ],
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (_product == null)
                          Image.asset(
                            Images.logo3,
                            height: 200,
                          ),
                        const Text(
                          'Click on the camera icon to scan the product barcode.',
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                        if (_product != null) ...[
                          const SizedBox(height: 20),
                          if (_product!.images != null &&
                              _product!.images!.isNotEmpty)
                            ImageCarousel(images: _product!.images!),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.restart_alt),
                                onPressed: () => resetProduct(context, () {
                                  setState(() {
                                    _product = null;
                                  });
                                }),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () =>
                                    showAIAnalysis(context, _product, _chat),
                                child: const Text('Analyze with AI'),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () =>
                                    shareOnWhatsApp(context, _product, _chat),
                                child: const Text('Share on WhatsApp'),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () =>
                                    saveProduct(context, _product!),
                                child: const Text('Save Product'),
                              ),
                            ],
                          ),
                          ProductDetailsTable(product: _product!),
                        ],
                      ],
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _scanBarcode,
          tooltip: 'Scan Barcode',
          child: const Icon(Icons.camera_alt),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
