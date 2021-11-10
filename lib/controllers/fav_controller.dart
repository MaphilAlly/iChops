import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/app_constants.dart';
import 'package:ichops/constants/controllers.dart';

import 'package:ichops/models/fav_item.dart';
import 'package:ichops/models/product.dart';
import 'package:ichops/models/user.dart';

import 'package:uuid/uuid.dart';

class FavouriteController extends GetxController {
  static FavouriteController instance = Get.find();
  RxDouble totalPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeFavouriteTotalPrice);
  }

  addProductToFavourite(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar(
          "Check your favourites",
          "${product.name} is already a favourite",
          backgroundColor: Colors.yellowAccent,
          duration: Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
        );
      } else {
        String itemId = Uuid().toString();
        userController.updateUserData({
          "favourite": FieldValue.arrayUnion([
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
          "${product.name} is added to favourites",
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

  void removeFavouriteItem(FavouriteItemModel favouriteItem) {
    try {
      userController.updateUserData({
        "favourite": FieldValue.arrayRemove([favouriteItem.toJson()])
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

  changeFavouriteTotalPrice(UserModel userModel) {
    totalPrice.value = 0.0;
    if (userModel.favourite.isNotEmpty) {
      userModel.favourite.forEach((favouriteItem) {
        totalPrice += favouriteItem.cost;
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userModel.value.favourite
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(FavouriteItemModel item) {
    if (item.quantity == 1) {
      removeFavouriteItem(item);
    } else {
      removeFavouriteItem(item);
      item.quantity--;
      userController.updateUserData({
        "favourite": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(FavouriteItemModel item) {
    removeFavouriteItem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "favourite": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
