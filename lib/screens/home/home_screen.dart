import 'dart:convert';

import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:bom_hamburger_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> productObject = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    try {
      final String productsJsonString =
          await rootBundle.loadString('assets/data/products.json');
      final Map<String, dynamic> productsJsonData =
          json.decode(productsJsonString);

      setState(() {
        productObject = productsJsonData;
        isLoading = false; // Define que o carregamento foi concluído
      });
    } catch (e) {
      // Tratamento de erro, se necessário
      print("Erro ao carregar os produtos: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bom Hamburger'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: const Text(
                      'Sandwiches',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  // TODO - Add Products
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Extras',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                // TODO - Add Products
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'cartBtn',
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
