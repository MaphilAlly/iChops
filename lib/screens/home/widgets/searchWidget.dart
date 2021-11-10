import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/screens/home/widgets/searchbox.dart';

class SearchWidget extends StatelessWidget {
  final String collectionString;
  final String searchHint;
  const SearchWidget({
    Key key,
    @required this.collectionString,
    @required this.searchHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          height: 40,
          child: Center(
            child: GestureDetector(
              onTap: () => Get.to(
                  () => SearchItem(searchCollectionName: collectionString)),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Icon(
                        Icons.search,
                        color: myBackgroundColor,
                        size: 30,
                      ),
                    ),
                    Text(
                      searchHint,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: myBackgroundColor,
                      ),
                    ),
                  ],
                ),
                height: 48,
                width: 350,
                decoration: BoxDecoration(
                  color: myBackgroundColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
