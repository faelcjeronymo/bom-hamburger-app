import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:bom_hamburger_app/data/products.dart';
import 'package:bom_hamburger_app/screens/cart/cart_screen.dart';
import 'package:bom_hamburger_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bom Hamburger',
          style: TextStyle(color: Colors.white),
        ),
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
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: sandwiches.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            sandwiches[index]['product_name'],
                            ProductCardType.addToCart,
                            sandwiches[index]['product_image'],
                            sandwiches[index]['product_value'], () {
                          addProductToCart(sandwiches[index]);
                        });
                      },
                    ),
                  )
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
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: extras.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          extras[index]['product_name'],
                          ProductCardType.addToCart,
                          extras[index]['product_image'],
                          extras[index]['product_value'], () {
                        addProductToCart(extras[index]);
                      });
                    },
                  ),
                )
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
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }

  void addProductToCart(Map<String, dynamic> productMap) {
    String productTypeToSearch =
        (productMap.isNotEmpty) ? productMap['product_type'] : '';

    Map<String, dynamic>? findProduct = {};

    if (selectedProducts.isNotEmpty) {
      findProduct = selectedProducts.firstWhere(
        (selectedProduct) =>
            selectedProduct['product_type'] == productTypeToSearch,
        orElse: () => {},
      );
    }

    if (findProduct.isNotEmpty) {
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

    selectedProducts.add(productMap);

    final snackBar = SnackBar(content: Text('Added to cart!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
