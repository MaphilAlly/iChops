import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/models/product.dart';
import 'package:ichops/screens/home/widgets/details.dart';

class SingleProductWidget extends StatelessWidget {
  final ProductModel product;

  const SingleProductWidget({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onDoubleTap: () {
        cartController.addProductToCart(product);
      },
      onTap: () {
        Get.to(() => ProductDetails(
              productfeature: product,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: myPrimaryColor,
          borderRadius: BorderRadius.circular(26),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: myPadding,
          vertical: myPadding / 2,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //MENU FRAME WITH BLUE BACKGROUND
            Container(
              height: 142,
              decoration: BoxDecoration(
                  boxShadow: [myShadow],
                  borderRadius: BorderRadius.circular(22),
                  color: myPrimaryColor),

              //Menu Background Color WHITE
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: myBackgroundColor,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            //MENU PICTURE
            Positioned(
              top: 9,
              left: 175,
              right: 40,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: myPrimaryColor,
                    ),
                    color: myBackgroundColor,
                    borderRadius: BorderRadius.circular(600),
                  ),
                  height: 138,
                  width: 138,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                    ),
                  )),
            ),

            //ITEM TITLE NAME AND POSITION
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 130,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: myPadding,
                        vertical: 2,
                      ),
                      child: Text(
                        product.name,
                        textScaleFactor: 1.3,
                        style: TextStyle(
                            color: myPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),

                    //PRICE WIDGET
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: myPadding / 5,
                        horizontal: myPadding * 1,
                      ),
                      decoration: BoxDecoration(
                        color: myPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text("N${product.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),

            //ADD ITEM TO CART METHOD
            Positioned(
              right: 8,
              top: 5,
              child: InkWell(
                splashFactory: InkSplash.splashFactory,
                onTap: () {
                  cartController.addProductToCart(product);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(20),
                      ),
                      color: myPrimaryColor),
                  child: Icon(
                    FontAwesomeIcons.cartPlus,
                    color: myBackgroundColor,
                  ),
                ),
              ),
              height: 40,
              width: 40,
            ),

            //ADD ITEM TO FAVOURITES
            Positioned(
              right: 8,
              top: 110.5,
              child: InkWell(
                splashFactory: InkSplash.splashFactory,
                onTap: () {
                  favouriteController.addProductToFavourite(product);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(20),
                    ),
                    color: myPrimaryColor,
                  ),
                  child: Icon(
                    FontAwesomeIcons.gratipay,
                    color: myBackgroundColor,
                  ),
                ),
              ),
              height: 40,
              width: 40,
            ),

            //Ratings Method
            Positioned(
              left: 20,
              bottom: 5,
              child: RatingBar.builder(
                itemSize: 25,
                initialRating: value,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (ratingScore) async {
                  try {
                    await userController.sendProductScore(
                      product.name,
                      ratingScore,
                    );
                  } catch (e) {
                    print(e);
                  }
                  print(ratingScore);
                  print(product.name);

                  var collection =
                      FirebaseFirestore.instance.collection('ratingScores');
                  var querySnapshot = await collection.get();
                  for (var doc in querySnapshot.docs) {
                    Map<String, dynamic> data = doc.data();
                    var name = data['product'];
                    var score = data['score'];
                    // print("Fetched Name " + name);
                    // print("Fetched Score " + score.toString());

                    if (name == product.name) {
                      double totalRatingScore =
                          score * name.length / name.length;
                      print("YOUR SCORE IS " + "$totalRatingScore");
                      value = totalRatingScore;
                    }
                  }
                  print("The value is $value");
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double value = 3.0;
