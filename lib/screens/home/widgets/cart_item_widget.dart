import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/models/cart_item.dart';
import 'package:ichops/widgets/custom_text.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.network(
                cartItem.image,
                width: 65,
                height: 70,
              ),
            ),
            Expanded(
                child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    cartItem.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.minusCircle,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {
                          cartController.decreaseQuantity(cartItem);
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: cartItem.quantity.toString(),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.green,
                          size: 20,
                        ),
                        onPressed: () {
                          cartController.increaseQuantity(cartItem);
                        }),
                  ],
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(14),
              child: CustomText(
                text: "\N${cartItem.cost}",
                size: 16,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
