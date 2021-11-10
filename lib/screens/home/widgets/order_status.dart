import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/home.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myPrimaryColor,
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('orderStatus')
                .doc(userController.userModel.value.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              var orderResponse = snapshot.data;
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: myBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height * .50,
                  width: MediaQuery.of(context).size.width * .85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.trafficLight,
                        size: 60,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        orderResponse["orderstatus"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 200,
                        height: 55,
                        child: TextButton(
                          onPressed: () => Get.off(() => HomeScreen()),
                          child: Text(
                            "OKAY",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            primary: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
