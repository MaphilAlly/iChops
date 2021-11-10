import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/widgets/favourite_Cart.dart';
import 'package:ichops/screens/home/widgets/ratings.dart';

import 'package:ichops/screens/home/widgets/shopping_cart.dart';
import 'package:ichops/screens/home/widgets/order_status.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Obx(
            () => DrawerHeader(
                child: Column(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: myPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        userController.userModel.value.name ?? "",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      //SHOW EMAIL AT DRAWER MENU
                      Text(
                        userController.userModel.value.email ?? "",
                        textScaleFactor: .98,
                      ),

                      Text(
                        userController.userModel.value.phone ?? "",
                        textScaleFactor: .98,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                        color: Colors.white, child: FavouriteWidget()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.gratipay,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "My Favourites",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () {
                showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                        color: Colors.white, child: ShoppingCartWidget()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.shoppingCart,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () {
                Get.to(() => OrderStatus());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.trafficLight,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "Check order status",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () async {
                cartPaymentsController.getPaymentHistory();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.shoppingBag,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "Order History",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () => Get.to(() => RatingMethod()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.smileBeam,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "See Users Ratings",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: myBackgroundColor,
                primary: Colors.black,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: "About iChops",
                  middleText:
                      "iChops offers you a great means of ordering food in the shortest possible time. Find your favorite food with just a few clicks.Your order history is also saved so that reordering is just one click away. Enjoy!!",
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  trailing: Icon(
                    FontAwesomeIcons.infoCircle,
                    size: 20,
                    color: myPrimaryColor,
                  ),
                  title: Text(
                    "About iChops",
                    style: TextStyle(
                      fontSize: 17,
                      color: myPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              icon: Icon(
                FontAwesomeIcons.powerOff,
                color: Colors.white,
              ),
              style: TextButton.styleFrom(
                backgroundColor: myPrimaryColor,
                primary: Colors.black,
              ),
              onPressed: () async {
                try {
                  userController.signOut();
                } catch (e) {
                  print(e);
                }
              },
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
