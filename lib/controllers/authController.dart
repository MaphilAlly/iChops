import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ichops/constants/app_constants.dart';
import 'package:ichops/constants/controllers.dart';

import 'package:ichops/constants/firebase.dart';
import 'package:ichops/models/user.dart';
import 'package:ichops/screens/authentication/widgets/loginPage.dart';

import 'package:ichops/screens/home/widgets/success.dart';
import 'package:ichops/screens/home/home.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController vPassword = TextEditingController();
  TextEditingController table = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController request = TextEditingController();
  TextEditingController search = TextEditingController();

  String usersCollection = "users";

  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    try {
      if (user == null) {
        Get.offAll(() => LoginPage());
      } else {
        userModel.bindStream(listenToUser());
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      print(e);
    }
  }

  signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
      });
    } on FirebaseAuthException catch (e) {
      var message = "";
      switch (e.code) {
        case 'EMAIL_NOT_FOUND':
          message = 'There is no user account with the email address provided.';
          break;
        case 'EMAIL_EXISTS':
          message = 'The email address is already in use by another account.';
          break;
        case 'INVALID_PASSWORD':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "${e.message}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 5));
    }
  }

  signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
      });
    } on FirebaseAuthException catch (e) {
      var message = "";
      switch (e.code) {
        case 'EMAIL_NOT_FOUND':
          message = 'There is no user account with the email address provided.';
          break;
        case 'EMAIL_EXISTS':
          message = 'The email address is already in use by another account.';
          break;
        case 'INVALID_PASSWORD':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      debugPrint(e.toString());
      Get.snackbar(
        "SignUp Failed",
        "${e.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  }

  void signOut() async {
    auth.signOut();
  }

  resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: email.text).then((result) {
        _clearControllers();
        Get.offAll(() => Success(
            title: "Reset Link sent to your registered email address",
            myPress: () => Get.offAll(() => LoginPage())));
      });
    } catch (e) {
      print(e.toString());
      debugPrint(e.toString());
      Get.snackbar(
        "Sending Reset link failed.",
        "${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    }
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "phone": phone.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cart": [],
      "favourite": []
    });
  }

  sendRatingtoCloud(
    String productName,
    String productImage,
    String userId,
    String userComment,
    int rating,
  ) {
    firebaseFirestore.collection("usersRating").doc().set({
      "product": productName,
      "image": productImage,
      "comment": userComment,
      "name": userController.userModel.value.name,
      "rating": rating,
    });
  }

  sendProductScore(
    String productName,
    double rating,
  ) {
    firebaseFirestore.collection("ratingScores").doc().set({
      "product": productName,
      "score": rating,
    });
  }

  sendCashPayment(
    String name,
    String email,
    String phone,
    String amount,
    String table,
  ) {
    firebaseFirestore.collection("cashPaymentRequest").doc().set({
      "customerName": name,
      "email": email,
      "phone": phone,
      "amountPayable": amount,
      "table": table
    });
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
