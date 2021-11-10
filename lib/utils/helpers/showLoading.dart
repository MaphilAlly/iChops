import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading() {
  Get.defaultDialog(
      title: "Loading...",
      content: CircularProgressIndicator(
        strokeWidth: 2,
      ),
      barrierDismissible: false);
}
ismissLoadingWidget() {
  Get.back();
}
