import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/payments/widgets/payerDetail.dart';
import 'package:ichops/widgets/custom_btn.dart';
import 'package:ichops/widgets/custom_text.dart';

import 'cart_item_widget.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: CustomText(
                text: "My Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.cart
                      .map((cartItem) => CartItemWidget(
                            cartItem: cartItem,
                          ))
                      .toList(),
                )),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: Obx(
                  () => CustomButton(
                      text:
                          "PAY \N${cartController.totalPrice.value.toStringAsFixed(2)} ",
                      onTap: () {
                        if (cartController.totalPrice.value == 0.00) {
                          return Get.snackbar(
                            "Oops! your Cart is empty",
                            "Add items to your cart before paying",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 5),
                            isDismissible: true,
                            dismissDirection: SnackDismissDirection.HORIZONTAL,
                            backgroundColor: mySecondaryColor,
                          );
                        }
                        Get.to(() => PayerDetails());
                      }),
                )))
      ],
    );
  }
}
