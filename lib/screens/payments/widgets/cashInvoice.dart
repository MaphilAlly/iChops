import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/home.dart';
import 'package:ichops/screens/payments/widgets/cashSuccces.dart';

class CashInvoice extends StatelessWidget {
  const CashInvoice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("---  INVOICE  ---"),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .95,
                  color: myPrimaryColor,
                  child: Center(
                    child: Text(
                      "CUSTOMER INFORMATION",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: myBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    "Name: ${userController.userModel.value.name}"
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    "MALE",
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    "Phone Number: ${userController.userModel.value.phone}"
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    "EMAIL ADDRESS: ${userController.userModel.value.email}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    "TABLE NUMBER: ${userController.table.text}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .95,
                  color: myPrimaryColor,
                  child: Center(
                    child: Text(
                      "AMOUNT PAYABLE",
                      style: TextStyle(
                        fontSize: 20,
                        color: myBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .80,
                    child: Center(
                      child: Text(
                        "N${cartController.totalPrice.value.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                label: Text(
                  'SUBMIT REQUEST',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                icon: Icon(FontAwesomeIcons.airbnb),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: myRed,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: myPadding * 4,
                  ),
                ),
                onPressed: () async {
                  try {
                    await userController.sendCashPayment(
                      userController.userModel.value.name,
                      userController.userModel.value.email,
                      userController.userModel.value.phone,
                      cartController.totalPrice.value.toStringAsFixed(2),
                      userController.table.text,
                    );
                    Get.off(() => CashSuccess(
                        title:
                            "Your cash payment request is sent successfully, a staff will come for your cash shortly",
                        myPress: () {
                          Get.offAll(() => HomeScreen());
                        }));
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ));
  }
}
