import 'package:bom_hamburger_app/core/app_colors.dart';
import 'package:flutter/material.dart';

enum ProductType {
  sandwich,
  fries,
  softDrink,
}

enum CardType {
  addToCart,
  removeFromCart,
}

class Product extends StatelessWidget {
  const Product(this.productName, this.type, this.productCardType, {super.key});

  final ProductType type;
  final String productName;
  final CardType productCardType;

  @override
  Widget build(BuildContext context) {
    //Setting card image
    String productImage = '';

    switch (type) {
      case ProductType.sandwich:
        productImage =
            'https://plus.unsplash.com/premium_photo-1675252371648-7a6481df8226?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
        break;
      case ProductType.fries:
        productImage =
            'https://plus.unsplash.com/premium_photo-1683121324474-83460636b0ed?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
        break;
      case ProductType.softDrink:
        productImage =
            'https://images.unsplash.com/photo-1716800586014-fea19e9453fb?q=80&w=2034&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
        break;
      default:
    }

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
                    child: Text('Lanche',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Text(
                    '\$ 5,00',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              (productCardType == CardType.addToCart)
                  ? AddToCartBtn()
                  : RemoveFromCartBtn()
            ],
          ),
        ],
      ),
    );
  }
}

class AddToCartBtn extends StatelessWidget {
  const AddToCartBtn({Key? key}) : super(key: key);

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
            // TODO - Criar onpressed
            onPressed: () {},
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
  const RemoveFromCartBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // TODO - Criar onpressed
      onPressed: () {},
      icon: Icon(Icons.close),
      iconSize: 24,
      color: Colors.black,
    );
  }
}
