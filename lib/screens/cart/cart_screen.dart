import 'dart:convert';
import 'dart:math';

import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:bom_hamburger_app/widgets/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class CartScreen extends StatefulWidget {
  const CartScreen(this.selectedProducts, {Key? key}) : super(key: key);

  final List<int> selectedProducts;

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
                      //TODO - Exibir os produtos selecionados
                      // ProductCard('Lanche', ProductType.sandwich,
                      //     CardType.removeFromCart),
                      Divider(
                        thickness: 1,
                      ),
                      // ProductCard('Lanche', ProductType.sandwich,
                      //     CardType.removeFromCart),
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
                        child: PaymentDetails('Sub Total', 1.50),
                        margin: EdgeInsets.only(bottom: 18),
                      ),
                      // TODO -  Exibiçao condicional de desconto
                      Container(
                        child: PaymentDetails('Discount', 0.00),
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
                        child: PaymentDetails('Total', 0.00),
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
                        showPaymentModal(context, widget.selectedProducts);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
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

void showPaymentModal(BuildContext context, List<int> selectedProducts) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final TextEditingController _textFieldController =
            TextEditingController();

        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 48),
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: _textFieldController,
                            decoration: const InputDecoration(
                                labelText: 'Your Name',
                                labelStyle: TextStyle(fontSize: 18)),
                            cursorColor: AppColor.primaryColor,
                            validator: (customerName) => customerName!.isEmpty
                                ? 'Please, enter your name.'
                                : null),
                      ),
                    ),
                  ),
                  PaymentDetails('Total', 0.00),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Edit Order',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
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
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final String payerName =
                                        _textFieldController.text;

                                    //TODO - Colocar o valor total da soma dos produtos do carrinho
                                    createOrder(
                                        0.00, selectedProducts, payerName);
                                  }
                                },
                                child: Text('Pay Now'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
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

void createOrder(double total, List<int> productsId, String payerName) async {
  final String orderId = Random().nextInt(99999).toString();

  Map<String, dynamic> data = {
    'order': {
      'id': orderId,
      'total': total,
      'products_id': productsId,
      'payerName': payerName
    }
  };

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(orderId, jsonEncode(data));
}

//TODO - criar uma função que faz todas as somas necessárias
/** 
 * Como posso fazer?
 * 
 * Recupero os id's dos produtos e carrego o JSON e pra cada produto eu vejo o valor
 * e faço as somas.
 * 
 * no retorno eu retornaria o total e valor com desconto.
 * 
 * A logica do desconto eu poderia fazer com varias variaveis auxiliares booleanas e varios ifs
 */
