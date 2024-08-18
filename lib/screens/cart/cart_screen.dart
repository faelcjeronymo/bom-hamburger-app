import 'package:bom_hamburger_app/widgets/cart_product.dart';
import 'package:bom_hamburger_app/widgets/payment_details.dart';
import 'package:bom_hamburger_app/widgets/product.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      Product('Lanche', ProductType.sandwich,
                          CardType.removeFromCart),
                      Divider(
                        thickness: 1,
                      ),
                      Product('Lanche', ProductType.sandwich,
                          CardType.removeFromCart),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 48),
                  child: Column(
                    children: [
                      Container(
                        child: PaymentDetail('Sub Total', 1.50),
                        margin: EdgeInsets.only(bottom: 18),
                      ),
                      // TODO -  Exibiçao condicional de desconto
                      Container(
                        child: PaymentDetail('Discount', 0.00),
                        margin: EdgeInsets.only(bottom: 18),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 18),
                        child: Divider(
                          thickness: 1,
                          height: 24,
                        ),
                      ),
                      Container(
                        child: PaymentDetail('Total', 0.00),
                        margin: EdgeInsets.only(bottom: 18),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
