import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ProductCardType {
  addToCart,
  removeFromCart,
}

class ProductCard extends StatelessWidget {
  const ProductCard(this.productName, this.productCardType, this.productImage,
      this.productValue, this.cardBtnOnPressed,
      {super.key});

  final String productName;
  final ProductCardType productCardType;
  final String productImage;
  final double productValue;
  final VoidCallback cardBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 2,
    );

    String formatedProductValue = formatter.format(productValue);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text('$productName',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Text(
                    '\$ $formatedProductValue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              (productCardType == ProductCardType.addToCart)
                  ? AddToCartBtn(cardBtnOnPressed)
                  : RemoveFromCartBtn(cardBtnOnPressed)
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn(this.onPressed, {Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Ink(
        decoration: ShapeDecoration(
            color: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        child: SizedBox(
          width: 36,
          height: 36,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            iconSize: 24,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class RemoveFromCartBtn extends StatelessWidget {
  const RemoveFromCartBtn(this.onPressed, {Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.close),
      iconSize: 24,
      color: Colors.black,
    );
  }
}
