import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ichops/constants/constraints.dart';

class Success extends StatelessWidget {
  final String title;
  final Function myPress;

  const Success({
    Key key,
    @required this.title,
    @required this.myPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myPrimaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Center(
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
                  FontAwesomeIcons.checkCircle,
                  size: 60,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  title,
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
                    onPressed: myPress,
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
        ),
      ),
    );
  }
}
