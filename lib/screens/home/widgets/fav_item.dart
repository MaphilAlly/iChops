import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/models/fav_item.dart';

import 'package:ichops/screens/home/widgets/single_product.dart';
import 'package:ichops/widgets/custom_text.dart';

class FavouriteItemWidget extends StatefulWidget {
  final FavouriteItemModel favouriteItem;

  const FavouriteItemWidget({
    Key key,
    this.favouriteItem,
  }) : super(key: key);

  @override
  _FavouriteItemWidgetState createState() => _FavouriteItemWidgetState();
}

class _FavouriteItemWidgetState extends State<FavouriteItemWidget> {
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Image.network(
                widget.favouriteItem.image,
                width: 65,
                height: 70,
              ),
            ),
            Expanded(
                child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    widget.favouriteItem.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1.2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.minusCircle,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {
                          favouriteController
                              .decreaseQuantity(widget.favouriteItem);
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: widget.favouriteItem.quantity.toString(),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.green,
                          size: 20,
                        ),
                        onPressed: () {
                          favouriteController
                              .increaseQuantity(widget.favouriteItem);
                        }),
                  ],
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(14),
              child: CustomText(
                text: "\N${widget.favouriteItem.cost}",
                size: 16,
                weight: FontWeight.bold,
              ),
            ),
            Checkbox(
              value: isChanged,
              onChanged: (bool value) {
                setState(() {
                  isChanged = value;
                  if (value == true) {
                    print("Added ${widget.favouriteItem.cost} ");
                  } else
                    print("Removed ${widget.favouriteItem.cost} ");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
