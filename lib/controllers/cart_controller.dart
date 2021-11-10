import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/app_constants.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/models/cart_item.dart';
import 'package:ichops/models/product.dart';
import 'package:ichops/models/user.dart';

import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar(
          "Check your cart",
          "${product.name} is already in cart",
          backgroundColor: Colors.yellowAccent,
          duration: Duration(seconds: 5),
           isDismissible: true,
           dismissDirection: SnackDismissDirection.HORIZONTAL,
        );
      } else {
        String itemId = Uuid().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": 1,
              "price": product.price,
              "image": product.image,
              "cost": product.price
            }
          ])
        });
        Get.snackbar(
          "Item added",
          "${product.name} is added to cart",
          backgroundColor: Colors.lightGreenAccent,
          duration: Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Cannot add this item",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
         isDismissible: true,
         dismissDirection: SnackDismissDirection.HORIZONTAL,
      );
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Cannot remove this item",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
      );
      debugPrint(e.message);
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalPrice.value = 0.0;
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalPrice += cartItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userModel.value.cart
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
