import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/home.dart';

import 'widgets/payment_widget.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Get.offAll(() => HomeScreen());
            }),
        backgroundColor: myPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Cart Payment History",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: cartPaymentsController.payments
                .map((payment) => PaymentWidget(
                      paymentsModel: payment,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
