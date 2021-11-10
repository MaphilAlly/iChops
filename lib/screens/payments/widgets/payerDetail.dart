import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';

import 'package:ichops/widgets/bezierContainer.dart';

import 'cashInvoice.dart';

final _payerKey = GlobalKey<FormState>();
String payValue = "";
bool isLoading = false;

//
//
// CART PAYMENT DETAILS
//
//
class PayerDetails extends StatefulWidget {
  @override
  _PayerDetailsState createState() => _PayerDetailsState();
}

class _PayerDetailsState extends State<PayerDetails> {
  String _selectedValue1 = "serve";
  String _selectedValue2 = "no";

  Widget _serveNowField() {
    return Form(
      key: _payerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              validator: (val) =>
                  !val.isNotEmpty ? "Please type the table number" : null,
              controller: userController.table,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: "Table Number",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "Enter your table number",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          SizedBox(
            height: 25,
            child: Text(
              "Do you have any extra request ? ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _radioButtons2(),
          _selectedValue2 == "no"
              ? Container()
              : Container(
                  width: 350,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: userController.request,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    minLines: 3,
                    decoration: InputDecoration(
                        labelText: "Type your request",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: myPrimaryColor,
                        ),
                        hintText: "Tell us what you want",
                        hintStyle: TextStyle(
                          color: Color(0xFF92929B),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        fillColor: Color(0xFFE6E6EE),
                        filled: true),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _deliverField() {
    return Form(
      key: _payerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              maxLines: 5,
              minLines: 3,
              validator: (val) =>
                  !val.isNotEmpty ? "Please type your adddress" : null,
              controller: userController.address,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Delivery Address",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "Enter your address",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          SizedBox(
            height: 25,
            child: Text(
              "Do you have any extra request ? ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _radioButtons2(),
          _selectedValue2 == "no"
              ? Container()
              : Container(
                  width: 350,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    minLines: 3,
                    controller: userController.request,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Type your request",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: myPrimaryColor,
                        ),
                        hintText: "Tell us what you want",
                        hintStyle: TextStyle(
                          color: Color(0xFF92929B),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        fillColor: Color(0xFFE6E6EE),
                        filled: true),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _radioButtons1() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
              groupValue: _selectedValue1,
              value: "serve",
              onChanged: (value) {
                setState(() {
                  _selectedValue1 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue1 = "serve";
                });
              },
              child: Text("Serve Now")),
        ),
        ListTile(
          leading: Radio(
              groupValue: _selectedValue1,
              value: "deliver",
              onChanged: (value) {
                setState(() {
                  _selectedValue1 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue1 = "deliver";
                });
              },
              child: Text("Deliver to my Address")),
        ),
      ],
    );
  }

  Widget _radioButtons2() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
              groupValue: _selectedValue2,
              value: "no",
              onChanged: (value) {
                setState(() {
                  _selectedValue2 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue2 = "no";
                });
              },
              child: Text("No")),
        ),
        ListTile(
          leading: Radio(
              groupValue: _selectedValue2,
              value: "yes",
              onChanged: (value) {
                setState(() {
                  _selectedValue2 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue2 = "yes";
                });
              },
              child: Text("Yes")),
        ),
      ],
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'i',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5507AD),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ops',
              style: TextStyle(color: Color(0xFF04C269), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _subTitle() {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 3,
            color: myRed,
          )),
      child: Center(
        child: Text(
          "How do you want your Order?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: myRed,
          ),
        ),
      ),
    );
  }

  Widget _payWithCard() {
    return isLoading
        ? LinearProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              ' PAY WITH CARD',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.creditCard),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: myPrimaryColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: myPadding * 2.7,
              ),
            ),
            onPressed: () async {
              if (_payerKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                try {
                  await cartPaymentsController.createPaymentMethod().then(
                    ((dynamic result) {
                      Get.showSnackbar(GetBar(
                        showProgressIndicator: true,
                        backgroundColor: mySecondaryColor,
                        duration: Duration(seconds: 6),
                        messageText: Text("Loading, Please wait"),
                      ));
                      if (result != null) {
                        print('Payment Initiated');
                      } else
                        setState(
                          () {
                            isLoading = false;
                          },
                        );
                    }),
                  );
                } catch (e) {
                  print(e);
                }
              }
            },
          );
  }

//Cash payment
  Widget _payCash() {
    return isLoading
        ? LinearProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              ' PAY CASH',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.moneyBill),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: myPrimaryColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: myPadding * 4,
              ),
            ),
            onPressed: () async {
              if (_payerKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                Get.off(() => CashInvoice());
              }
            },
          );
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 30),
                      _subTitle(),
                      _radioButtons1(),
                      _selectedValue1 == "serve"
                          ? _serveNowField()
                          : _deliverField(),
                      SizedBox(height: 20),
                      _payWithCard(),
                      SizedBox(height: 10),
                      _payCash(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
// FAVOURITE PAYMENT DETAILS
//
//

class PayerDetails2 extends StatefulWidget {
  @override
  _PayerDetailsState2 createState() => _PayerDetailsState2();
}

class _PayerDetailsState2 extends State<PayerDetails2> {
  String _selectedValue1 = "serve";
  String _selectedValue2 = "no";

  Widget _serveNowField() {
    return Form(
      key: _payerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              validator: (val) =>
                  !val.isNotEmpty ? "Please type the table number" : null,
              controller: userController.table,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: "Table Number",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "Enter your table number",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          SizedBox(
            height: 25,
            child: Text(
              "Do you have any extra request ? ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _radioButtons2(),
          _selectedValue2 == "no"
              ? Container()
              : Container(
                  width: 350,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: userController.request,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    minLines: 3,
                    decoration: InputDecoration(
                        labelText: "Type your request",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: myPrimaryColor,
                        ),
                        hintText: "Tell us what you want",
                        hintStyle: TextStyle(
                          color: Color(0xFF92929B),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        fillColor: Color(0xFFE6E6EE),
                        filled: true),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _deliverField() {
    return Form(
      key: _payerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 350,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              maxLines: 5,
              minLines: 3,
              validator: (val) =>
                  !val.isNotEmpty ? "Please type your adddress" : null,
              controller: userController.address,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Delivery Address",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "Enter your address",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          SizedBox(
            height: 25,
            child: Text(
              "Do you have any extra request ? ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _radioButtons2(),
          _selectedValue2 == "no"
              ? Container()
              : Container(
                  width: 350,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    minLines: 3,
                    controller: userController.request,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "Type your request",
                        labelStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: myPrimaryColor,
                        ),
                        hintText: "Tell us what you want",
                        hintStyle: TextStyle(
                          color: Color(0xFF92929B),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        border: InputBorder.none,
                        fillColor: Color(0xFFE6E6EE),
                        filled: true),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _radioButtons1() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
              groupValue: _selectedValue1,
              value: "serve",
              onChanged: (value) {
                setState(() {
                  _selectedValue1 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue1 = "serve";
                });
              },
              child: Text("Serve Now")),
        ),
        ListTile(
          leading: Radio(
              groupValue: _selectedValue1,
              value: "deliver",
              onChanged: (value) {
                setState(() {
                  _selectedValue1 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue1 = "deliver";
                });
              },
              child: Text("Deliver to my Address")),
        ),
      ],
    );
  }

  Widget _radioButtons2() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
              groupValue: _selectedValue2,
              value: "no",
              onChanged: (value) {
                setState(() {
                  _selectedValue2 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue2 = "no";
                });
              },
              child: Text("No")),
        ),
        ListTile(
          leading: Radio(
              groupValue: _selectedValue2,
              value: "yes",
              onChanged: (value) {
                setState(() {
                  _selectedValue2 = value;
                });
              }),
          title: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue2 = "yes";
                });
              },
              child: Text("Yes")),
        ),
      ],
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'i',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5507AD),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ops',
              style: TextStyle(color: Color(0xFF04C269), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _subTitle() {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 3,
            color: myRed,
          )),
      child: Center(
        child: Text(
          "How do you want your Order?",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: myRed,
          ),
        ),
      ),
    );
  }

  Widget _payWithCard() {
    return isLoading
        ? LinearProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              ' PAY WITH CARD',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.creditCard),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: myPrimaryColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: myPadding * 2.7,
              ),
            ),
            onPressed: () async {
              if (_payerKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                try {
                  await favPaymentsController.createPaymentMethod().then(
                    ((dynamic result) {
                      Get.showSnackbar(GetBar(
                        showProgressIndicator: true,
                        backgroundColor: mySecondaryColor,
                        duration: Duration(seconds: 6),
                        messageText: Text("Loading, Please wait"),
                      ));
                      if (result != null) {
                        print('Payment Initiated');
                      } else
                        setState(
                          () {
                            isLoading = false;
                          },
                        );
                    }),
                  );
                } catch (e) {
                  print(e);
                }
              }
            },
          );
  }

//Cash payment
  Widget _payCash() {
    return isLoading
        ? LinearProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              ' PAY CASH',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.moneyBill),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: myPrimaryColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: myPadding * 4,
              ),
            ),
            onPressed: () async {
              if (_payerKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });

                Get.off(() => CashInvoice());
              }
            },
          );
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 30),
                      _subTitle(),
                      _radioButtons1(),
                      _selectedValue1 == "serve"
                          ? _serveNowField()
                          : _deliverField(),
                      SizedBox(height: 20),
                      _payWithCard(),
                      SizedBox(height: 10),
                      _payCash(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


