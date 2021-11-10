import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';

import 'package:ichops/widgets/bezierContainer.dart';

final _resetKey = GlobalKey<FormState>();

bool isLoading = false;

class ResetPassword extends StatefulWidget {
  ResetPassword({
    Key key,
  }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Widget _formField() {
    return Form(
        key: _resetKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 3,
                    color: myPrimaryColor,
                  )),
              child: Center(
                child: Text(
                  "PASSWORD RESET",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                validator: (val) =>
                    !val.isNotEmpty ? "Please type an email address" : null,
                controller: userController.email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: myPrimaryColor,
                    ),
                    hintText: "Enter your registered Email",
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
              height: 20,
            ),
          ],
        ));
  }

  Widget _submitButton() {
    return isLoading
        ? CircularProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              'Send Reset Link',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.link),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: myPrimaryColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: myPadding * 4.7,
              ),
            ),
            onPressed: () async {
              if (_resetKey.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                try {
                  await userController.resetPassword().then(
                    ((dynamic result) {
                      if (result != null) {
                        print('Reset link successfully.');
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

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'i',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF035AA6),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ops',
              style: TextStyle(color: Color(0xFF035AA6), fontSize: 30),
            ),
          ]),
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
                      SizedBox(height: 50),
                      _formField(),
                      SizedBox(height: 20),
                      _submitButton(),
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
