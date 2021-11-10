import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/home.dart';
import 'package:ichops/screens/home/widgets/ratings.dart';

import 'package:rating_dialog/rating_dialog.dart';
import 'package:share/share.dart';

class ProductDetails extends StatelessWidget {
  final productfeature;

  ProductDetails({
    Key key,
    this.productfeature,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ProductDetailsFrame(
        myProduct: productfeature,
        price: productfeature.price,
        title: productfeature.name,
        image: productfeature.image,
        description: productfeature.description,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: myBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Get.back(),
      ),
      title: GestureDetector(
        onTap: () => Get.back(),
        child: Text(
          "Back".toUpperCase(),
          style: Theme.of(context).textTheme.button,
        ),
      ),
      actions: [],
    );
  }
}

class ProductDetailsFrame extends StatelessWidget {
  final myProduct;
  final String title;
  final String image;
  final String description;
  final double price;
  ProductDetailsFrame({
    Key key,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.price,
    @required this.myProduct,
  });

  @override
  Widget build(BuildContext context) {
    void _showRatingDialog() {
      final _dialog = RatingDialog(
        commentHint: "Tell us what you think...",

        // your app's name?
        title: 'Rate $title',
        // encourage your user to leave a high rating?
        message:
            'Tap a star to set your rating. Add more description here if you want.',
        // your app's logo?
        image: Image.network(
          image,
          fit: BoxFit.contain,
          height: 150,
          width: 150,
        ),

        submitButton: 'Submit',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) async {
          print('rating: ${response.rating}, comment: ${response.comment}');

          if (response.rating >= 1.0) {
            // send their comments to your email or anywhere you wish
            // ask the user to contact you instead of leaving a bad review
            try {
              await userController.sendRatingtoCloud(
                title,
                image,
                userController.userModel.value.id,
                response.comment,
                response.rating,
              );
            } catch (e) {
              print(e);
            }
          } else {}
        },
      );

      // show the dialog
      showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) => _dialog,
      );
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: size.height * .30,
              color: myBackgroundColor,
              child: Stack(
                children: [
                  //Entry point for the title
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 40,
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: myPrimaryColor,
                          ),
                          color: myBackgroundColor,
                          borderRadius: BorderRadius.circular(600),
                        ),
                        height: 165,
                        width: 165,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        )),
                  ),

//Entry point for ShareButton
                  Positioned(
                    left: 145,
                    right: 145,
                    top: 205,
                    child: GestureDetector(
                      onTap: () {
                        Share.share("Enjoy $title at iChops " + "$image");
                      },
                      child: Container(
                        width: 110,
                        height: 40,
                        decoration: BoxDecoration(
                          color: myPrimaryColor,
                          border: Border.all(
                            color: myPrimaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: Text("SHARE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                            ),
                            Icon(
                              FontAwesomeIcons.shareAlt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Entry point for the price
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Center(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "N$price",
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 240,
                    bottom: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton.extended(
                        icon: Icon(
                          FontAwesomeIcons.smileBeam,
                          color: Colors.black,
                        ),
                        backgroundColor: mySecondaryColor,
                        onPressed: _showRatingDialog,
                        label: Text(
                          "Rate",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 240,
                    bottom: 8,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton.extended(
                        icon: Icon(
                          FontAwesomeIcons.comments,
                          color: Colors.black,
                        ),
                        backgroundColor: mySecondaryColor,
                        onPressed: () => Get.to(() => RatingMethod()),
                        label: Text(
                          "View",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: myPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.4,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: size.height * .20,
              color: myPrimaryColor,
              child: SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Get.off(() => HomeScreen());
                    cartController.addProductToCart(myProduct);
                  },
                  icon: Icon(FontAwesomeIcons.cartPlus),
                  label: Text(
                    " ADD TO CART",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: 1.6,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: mySecondaryColor,
                    primary: Colors.black,
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
