import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/app_constants.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/constants/firebase.dart';
import 'package:ichops/models/payments.dart';
import 'package:ichops/screens/home/home.dart';
import 'package:ichops/screens/payments/payments.dart';
import 'package:ichops/utils/helpers/showLoading.dart';

import 'package:stripe_payment/stripe_payment.dart';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

//
//
// CART PAYMENT CONTROLLER
//
//
class CartPaymentsController extends GetxController {
  static CartPaymentsController instance = Get.find();
  String collection = "payments";
  PaymentsModel paymentsModel;
  String url =
      'https://us-central1-sneex-cbc6a.cloudfunctions.net/createPaymentIntent';
  List<PaymentsModel> payments = [];

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_vdof9EwWNjWX6gglW2xjji3Y00mLAezzRK",
        androidPayMode: 'test'));
  }

  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null);
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();

    int amount =
        (double.parse(cartController.totalPrice.value.toStringAsFixed(2)) * 100)
            .toInt();

    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=NGN&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        await StripePayment.completeNativePayRequest();
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        _addToOrderStatus(paymentStatus: status, paymentId: paymentMethod.id);
        userController.updateUserData({
          "cart": [],
        });
        Get.defaultDialog(
            backgroundColor: myGreen,
            content: Text(
              "Payment Successful!, your order will be processed in a short while, you can check your Order status in the app drawer",
              style: TextStyle(
                fontSize: 18,
                color: myTextColor,
                height: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: myTextColor,
                    primary: snacksSecondaryColor,
                  ),
                  onPressed: () => Get.offAll(() => HomeScreen()),
                  child: Text(
                    "Okay",
                    style: TextStyle(color: myBackgroundColor),
                  ),
                ),
              ),
            ]);
      } else {
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        _addToOrderStatus(paymentStatus: status, paymentId: paymentMethod.id);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        backgroundColor: myRed,
        content: Text(
          "Payment failed, try again or change your debit card",
          style: TextStyle(
            fontSize: 18,
            color: myBackgroundColor,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: myTextColor,
                primary: snacksSecondaryColor,
              ),
              onPressed: () => Get.back(),
              child: Text(
                "Okay",
                style: TextStyle(color: myBackgroundColor),
              ),
            ),
          ),
        ]);
  }

  _addToCollection({String paymentStatus, String paymentId}) {
    String id = Uuid().v4();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": userController.userModel.value.id,
      "status": paymentStatus,
      "orderstatus": "Awaiting Action",
      "paymentId": paymentId,
      "table": userController.table.text,
      "receiver": userController.userModel.value.name,
      "address": userController.address.text,
      "request": userController.request.text,
      "cart": userController.userModel.value.cartItemsToJson(),
      "amount": cartController.totalPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  _addToOrderStatus({String paymentStatus, String paymentId}) {
    String id = userController.userModel.value.id;
    firebaseFirestore.collection("orderStatus").doc(id).set({
      "id": id,
      "status": paymentStatus,
      "orderstatus": "Awaiting Action",
      "paymentId": paymentId,
      "table": userController.table.text,
      "receiver": userController.userModel.value.name,
      "address": userController.address.text,
      "request": userController.request.text,
      "cart": userController.userModel.value.cartItemsToJson(),
      "favourite": userController.userModel.value.favouriteItemsToJson(),
      "amount": cartController.totalPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() async {
    showLoading();
    payments.clear();
    try {
      await firebaseFirestore
          .collection(collection)
          .where("clientId", isEqualTo: userController.userModel.value.id)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          PaymentsModel payment = PaymentsModel.fromMap(doc.data());
          payments.add(payment);
        });

        logger.i("length ${payments.length}");
        Get.to(() => PaymentsScreen());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

//
//
// FAVOURITE PAYMENT CONTROLLER
//
//

class FavPaymentsController extends GetxController {
  static FavPaymentsController instance = Get.find();
  String collection = "payments";
  PaymentsModel paymentsModel;
  String url =
      'https://us-central1-sneex-cbc6a.cloudfunctions.net/createPaymentIntent';
  List<PaymentsModel> payments = [];

  @override
  void onReady() {
    super.onReady();
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_vdof9EwWNjWX6gglW2xjji3Y00mLAezzRK",
        androidPayMode: 'test'));
  }

  Future<void> createPaymentMethod() async {
    StripePayment.setStripeAccount(null);
    //step 1: add card
    PaymentMethod paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Error Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : _showPaymentFailedAlert();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();

    int amount =
        (double.parse(favouriteController.totalPrice.value.toStringAsFixed(2)) *
                100)
            .toInt();

    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=NGN&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        await StripePayment.completeNativePayRequest();
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        _addToOrderStatus(paymentStatus: status, paymentId: paymentMethod.id);
        userController.updateUserData({
          "cart": [],
        });
        Get.defaultDialog(
            backgroundColor: myGreen,
            content: Text(
              "Payment Successful!, your order will be processed in a short while, you can check your Order status in the app drawer",
              style: TextStyle(
                fontSize: 18,
                color: myTextColor,
                height: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: myTextColor,
                    primary: snacksSecondaryColor,
                  ),
                  onPressed: () => Get.offAll(() => HomeScreen()),
                  child: Text(
                    "Okay",
                    style: TextStyle(color: myBackgroundColor),
                  ),
                ),
              ),
            ]);
      } else {
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        _addToOrderStatus(paymentStatus: status, paymentId: paymentMethod.id);
      }
    } else {
      //case A
      StripePayment.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        backgroundColor: myRed,
        content: Text(
          "Payment failed, try again or change your debit card",
          style: TextStyle(
            fontSize: 18,
            color: myBackgroundColor,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: myTextColor,
                primary: snacksSecondaryColor,
              ),
              onPressed: () => Get.back(),
              child: Text(
                "Okay",
                style: TextStyle(color: myBackgroundColor),
              ),
            ),
          ),
        ]);
  }

  _addToCollection({String paymentStatus, String paymentId}) {
    String id = Uuid().v4();
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": userController.userModel.value.id,
      "status": paymentStatus,
      "paymentId": paymentId,
      "table": userController.table.text,
      "receiver": userController.userModel.value.name,
      "address": userController.address.text,
      "request": userController.request.text,
      "cart": userController.userModel.value.cartItemsToJson(),
      "favourite": userController.userModel.value.favouriteItemsToJson(),
      "amount": cartController.totalPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  _addToOrderStatus({String paymentStatus, String paymentId}) {
    String id = userController.userModel.value.id;
    firebaseFirestore.collection("orderStatus").doc(id).set({
      "id": id,
      "status": paymentStatus,
      "orderstatus": "Awaiting Action",
      "paymentId": paymentId,
      "table": userController.table.text,
      "receiver": userController.userModel.value.name,
      "address": userController.address.text,
      "request": userController.request.text,
      "cart": userController.userModel.value.cartItemsToJson(),
      "favourite": userController.userModel.value.favouriteItemsToJson(),
      "amount": cartController.totalPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() async {
    showLoading();
    payments.clear();
    try {
      await firebaseFirestore
          .collection(collection)
          .where("clientId", isEqualTo: userController.userModel.value.id)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          PaymentsModel payment = PaymentsModel.fromMap(doc.data());
          payments.add(payment);
        });

        logger.i("length ${payments.length}");
        Get.to(() => PaymentsScreen());
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
