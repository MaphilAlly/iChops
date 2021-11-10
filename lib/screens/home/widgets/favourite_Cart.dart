import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/payments/widgets/payerDetail.dart';
import 'package:ichops/widgets/custom_btn.dart';
import 'package:ichops/widgets/custom_text.dart';
import 'fav_item.dart';

class FavouriteWidget extends StatelessWidget {
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
                text: "My Favourite(s)",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.favourite
                      .map((favouriteItem) => FavouriteItemWidget(
                            favouriteItem: favouriteItem,
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
                          "PAY \N${favouriteController.totalPrice.value.toStringAsFixed(2)} ",
                      onTap: () {
                        if (favouriteController.totalPrice.value == 0.00) {
                          return Get.snackbar(
                            "Oops! your Favourite List  is empty",
                            "Add item(s) before paying",
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 5),
                            isDismissible: true,
                            dismissDirection: SnackDismissDirection.HORIZONTAL,
                            backgroundColor: mySecondaryColor,
                          );
                        }
                        Get.to(() => PayerDetails2());
                      }),
                )))
      ],
    );
  }
}
