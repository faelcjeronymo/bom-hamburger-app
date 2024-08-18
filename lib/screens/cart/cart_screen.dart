import 'package:bom_hamburger_app/core/app_colors.dart';
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
                  margin: EdgeInsets.only(bottom: 22),
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
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        showPaymentModal(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Order now'),
                    ),
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

void showPaymentModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 280,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                //TODO - Trocar cor da caixa de texto
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 48),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Your Name',
                            labelStyle: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                  PaymentDetail('Total', 0.00),
                  Divider(
                    thickness: 1,
                    height: 42,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit Order',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    shadowColor: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Pay Now'),
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
