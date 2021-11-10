import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/home/home.dart';
import 'package:ichops/widgets/bezierContainer.dart';

import 'loginPage.dart';

final _formKey = GlobalKey<FormState>();

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  Widget _formField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              validator: (val) => !val.isNotEmpty ? "Please type a name" : null,
              controller: userController.name,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "eg: Philemon Dogo",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              validator: (val) =>
                  !RegExp(r"/^WS{1,2}:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:56789/i")
                          .hasMatch(val)
                      ? null
                      : "Please type a correct email address",
              controller: userController.email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "eg: ichops@gmail.com",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              validator: (val) =>
                  val.length != 11 ? "Number must be 11 characters long" : null,
              controller: userController.phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "eg: 07064332211",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              validator: (val) =>
                  val.length < 6 ? "Password must be 6 characters long" : null,
              obscureText: true,
              controller: userController.password,
              decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
                  ),
                  hintText: "Atleast 6 Characters long",
                  hintStyle: TextStyle(
                    color: Color(0xFF92929B),
                  ),
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  fillColor: Color(0xFFE6E6EE),
                  filled: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              validator: (val) =>
                  userController.vPassword.text != userController.password.text
                      ? "Passwords does not match"
                      : null,
              controller: userController.vPassword,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Retype Password",
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: myPrimaryColor,
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

  Widget _submitButton() {
    return isLoading
        ? CircularProgressIndicator()
        : TextButton.icon(
            label: Text(
              'Register Now',
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
              if (_formKey.currentState.validate() ||
                  FirebaseAuth.instance.currentUser?.uid == null) {
                setState(() {
                  isLoading = true;
                });
                try {
                  await userController.signUp().then(
                    ((dynamic result) {
                      if (result != null) {
                        Get.offAll(() => HomeScreen());
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

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () => Get.offAll(() => LoginPage()),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xFF035AA6),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'i',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xFF035AA6),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            TextSpan(
              text: 'ops',
              style: TextStyle(color: Color(0xFF791919), fontSize: 40),
            ),
          ]),
    );
  }

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
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 40,
                      ),
                      _formField(),
                      SizedBox(
                        height: 10,
                      ),
                      _submitButton(),
                      _loginAccountLabel(),
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
