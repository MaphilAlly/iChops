import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ichops/constants/constraints.dart';
import 'package:ichops/constants/controllers.dart';
import 'package:ichops/screens/authentication/widgets/resetPassword.dart';
import 'package:ichops/screens/authentication/widgets/signup.dart';
import 'package:ichops/screens/home/home.dart';
import 'package:ichops/widgets/bezierContainer.dart';

final _loginKey = GlobalKey<FormState>();

bool isLoading = false;

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _formField() {
    return Form(
        key: _loginKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                obscureText: true,
                controller: userController.password,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: myPrimaryColor,
                    ),
                    hintText: "Enter your registered password",
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
        ));
  }

  Widget _submitButton() {
    return isLoading
        ? CircularProgressIndicator(
            color: myPrimaryColor,
          )
        : TextButton.icon(
            label: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            icon: Icon(FontAwesomeIcons.signInAlt),
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
              if (_loginKey.currentState.validate() ||
                  FirebaseAuth.instance.currentUser?.uid == null) {
                setState(() {
                  isLoading = true;
                });
                try {
                  await userController.signIn().then(
                    ((dynamic result) {
                      if (result != null) {
                        print('Logged in successfully.');
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

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () async => Get.offAll(() => SignUpPage()),
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xFF035AA6),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
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
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xFF06D410),
          ),
          children: [
            TextSpan(
              text: 'Ch',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ops',
              style: TextStyle(color: Color(0xFFB63400), fontSize: 30),
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
      child: DoubleBack(
        message: "Press back again to close iChops",
        background: myRed,
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
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.to(() => ResetPassword()),
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        _divider(),
                        SizedBox(height: 10),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
