import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/models/product.dart';
import 'package:ichops/screens/home/widgets/searchWidget.dart';

import 'package:ichops/screens/home/widgets/single_product.dart';

class FoodWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.3,
            mainAxisSpacing: 1.0,
            children: foodController.products.map((ProductModel product) {
              return SingleProductWidget(
                product: product,
              );
            }).toList()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: myPrimaryColor,
          ),
          height: 50,
          width: double.infinity,
          child: SearchWidget(
              collectionString: "food", searchHint: "Search for food"),
        ),
      ]),
    );
  }
}

class DrinksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.3,
            mainAxisSpacing: 1.0,
            children: drinksController.products.map((ProductModel product) {
              return SingleProductWidget(
                product: product,
              );
            }).toList()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: myPrimaryColor,
          ),
          height: 50,
          width: double.infinity,
          child: SearchWidget(
              collectionString: "drinks", searchHint: "Search for drinks"),
        ),
      ]),
    );
  }
}

class SnacksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.3,
            mainAxisSpacing: 1.0,
            children: snacksController.products.map((ProductModel product) {
              return SingleProductWidget(
                product: product,
              );
            }).toList()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: myPrimaryColor,
          ),
          height: 50,
          width: double.infinity,
          child: SearchWidget(
              collectionString: "snacks", searchHint: "Search for snacks"),
        ),
      ]),
    );
  }
}

class MeatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.3,
            mainAxisSpacing: 1.0,
            children: meatController.products.map((ProductModel product) {
              return SingleProductWidget(
                product: product,
              );
            }).toList()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: myPrimaryColor,
          ),
          height: 50,
          width: double.infinity,
          child: SearchWidget(
              collectionString: "meat", searchHint: "Search for meat"),
        ),
      ]),
    );
  }
}

class OthersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2.3,
            mainAxisSpacing: 1.0,
            children: othersController.products.map((ProductModel product) {
              return SingleProductWidget(
                product: product,
              );
            }).toList()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: myPrimaryColor,
          ),
          height: 50,
          width: double.infinity,
          child: SearchWidget(
              collectionString: "others", searchHint: "Search for others"),
        ),
      ]),
    );
  }
}
