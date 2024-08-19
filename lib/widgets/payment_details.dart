import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails(this.paymentDetailLabel, this.paymentDetailValue,
      {Key? key})
      : super(key: key);

  final String paymentDetailLabel;
  final double paymentDetailValue;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 2,
    );

    String formatedPaymentDetailValue = formatter.format(paymentDetailValue);

    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$paymentDetailLabel',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: (paymentDetailLabel == 'Total')
                        ? FontWeight.w600
                        : FontWeight.normal),
              ),
              Text(
                '\$ $formatedPaymentDetailValue',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }
}
