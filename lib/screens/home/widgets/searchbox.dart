import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/controllers/searchController.dart';
import 'package:ichops/models/product.dart';


import 'details.dart';

class SearchItem extends StatefulWidget {
  final ProductModel product;
  final String searchCollectionName;
  const SearchItem({
    Key key,
    this.product,
    @required this.searchCollectionName,
  }) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: myBackgroundColor,
                child: ListTile(
                  onTap: () {
                    Get.to(Get.to(
                        () => ProductDetails(
                              productfeature: ProductModel(
                                image: snapshotData.docs[index].data()['image'],
                                name: snapshotData.docs[index].data()['name'],
                                description: snapshotData.docs[index]
                                    .data()['description'],
                                price: snapshotData.docs[index]
                                    .data()['price']
                                    .toDouble(),
                              ),
                            ),
                        transition: Transition.downToUp,
                        arguments: snapshotData.docs[index]));
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshotData.docs[index].data()['image']),
                  ),
                  title: Text(
                    snapshotData.docs[index].data()['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: myPrimaryColor),
                  ),
                  subtitle: Text(
                    "N${snapshotData.docs[index].data()['price']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      cartController.addProductToCart(
                        ProductModel(
                          id: snapshotData.docs[index].data()['id'],
                          image: snapshotData.docs[index].data()['image'],
                          name: snapshotData.docs[index].data()['name'],
                          score: snapshotData.docs[index].data()['score'],
                          price: snapshotData.docs[index]
                              .data()['price']
                              .toDouble(),
                        ),
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.cartPlus,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          autofocus: true,
          controller: userController.search,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search Here",
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(.4),
            ),
          ),
        ),
        actions: [
          GetBuilder<SearchController>(
              init: SearchController(
                collectionName: widget.searchCollectionName,
              ),
              builder: (val) {
                return IconButton(
                  onPressed: () {
                    val
                        .queryData(userController.search.text.toUpperCase())
                        .then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  },
                  icon: Icon(Icons.search),
                );
              }),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: isExecuted
          ? searchedData()
          : Center(
              child: Text("No result found."),
            ),
    );
  }
}
