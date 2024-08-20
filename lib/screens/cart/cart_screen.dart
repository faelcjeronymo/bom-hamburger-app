import 'dart:convert';
import 'dart:math';

import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:bom_hamburger_app/screens/home/home_screen.dart';
import 'package:bom_hamburger_app/widgets/payment_details.dart';
import 'package:bom_hamburger_app/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKey = GlobalKey<FormState>();

class CartScreen extends StatefulWidget {
  CartScreen(this.selectedProducts, {Key? key}) : super(key: key);

  final List<Map<String, dynamic>> selectedProducts;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double subTotal = 0.00;
  double discount = 0.00;
  double total = 0.00;

  void calcValues() {
    subTotal = 0.00;
    discount = 0.00;

    //Discount check auxiliar variables
    bool hasSandwich = widget.selectedProducts
        .any((element) => element['product_type'] == 'sandwich');
    bool hasFries = widget.selectedProducts
        .any((element) => element['product_type'] == 'fries');
    bool hasSoftDrink = widget.selectedProducts
        .any((element) => element['product_type'] == 'soft_drink');

    //Calculating values

    //Subtotal
    for (var selectedProduct in widget.selectedProducts) {
      subTotal += selectedProduct['product_value'];
    }

    //Checking discount
    if (hasSandwich && hasFries && hasSoftDrink) {
      discount = 0.20;
    } else if (hasSandwich && hasSoftDrink) {
      discount = 0.15;
    } else if (hasSandwich && hasFries) {
      discount = 0.10;
    }

    if (discount > 0) {
      total = (subTotal - (subTotal * discount));
    } else {
      total = subTotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    calcValues();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
                      SizedBox(
                        height: 330,
                        child: ListView.builder(
                          itemCount: widget.selectedProducts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ProductCard(
                                    widget.selectedProducts[index]
                                        ['product_name'],
                                    ProductCardType.removeFromCart,
                                    widget.selectedProducts[index]
                                        ['product_image'],
                                    widget.selectedProducts[index]
                                        ['product_value'], () {
                                  setState(() {
                                    widget.selectedProducts.removeAt(index);
                                  });
                                }),
                                const Divider(
                                  thickness: 1,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 48),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        child: PaymentDetails('Sub Total', subTotal),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        child:
                            PaymentDetails('Discount', (subTotal * discount)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        child: const Divider(
                          thickness: 1,
                          height: 24,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        child: PaymentDetails('Total', total),
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
                        showPaymentModal(
                            context, total, widget.selectedProducts);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text(
                        'Order now',
                        style: TextStyle(color: Colors.white),
                      ),
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

void showPaymentModal(
    BuildContext context, double orderTotal, List<Map> selectedProducts) {
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
                  PaymentDetails('Total', orderTotal),
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

                                    createOrder(orderTotal, selectedProducts,
                                        payerName);

                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text(''),
                                              content:
                                                  const Text('Order Created!'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.of(context).popUntil((predicate) => predicate.isFirst),
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .primaryColor),
                                                    ))
                                              ],
                                            ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14))),
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(color: Colors.white),
                                ),
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

void createOrder(double total, List<Map> products, String payerName) async {
  //Create the order and save at the local storage

  final String orderId = Random().nextInt(99999).toString();

  Map<String, dynamic> data = {
    'order': {
      'id': orderId,
      'total': total,
      'products': products,
      'payerName': payerName
    }
  };

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(orderId, jsonEncode(data));
}
