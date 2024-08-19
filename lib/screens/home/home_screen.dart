import 'dart:convert';

import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:bom_hamburger_app/screens/cart/cart_screen.dart';
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

  List<int> selectedProducts = [];

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

  void addProductToCart(int productId) {
    if (selectedProducts.contains(productId)) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Product already added to cart.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: AppColor.primaryColor),
                      ))
                ],
              ));

      return;
    }

    selectedProducts.add(productId);
    final snackBar = SnackBar(content: Text('Added to cart!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  ProductCard(
                      'X Bacon',
                      ProductCardType.addToCart,
                      'https://plus.unsplash.com/premium_photo-1675252371648-7a6481df8226?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      5.00, () {
                    addProductToCart(1);
                  }),
                  // TODO - Products List (CASO NAO DE CERTO RENDERIZE OS WIDGETS NA MAO SÓ PRA FUNCIONAR)
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
                  // TODO - Products List (CASO NAO DE CERTO RENDERIZE OS WIDGETS NA MAO SÓ PRA FUNCIONAR)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'cartBtn',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(selectedProducts),
              ));
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
