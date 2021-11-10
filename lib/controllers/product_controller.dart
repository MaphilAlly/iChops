import 'dart:async';
import 'package:get/get.dart';
import 'package:ichops/constants/firebase.dart';
import 'package:ichops/models/product.dart';

class FoodController extends GetxController {
  static FoodController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "food";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }
  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}

class DrinksController extends GetxController {
  static DrinksController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "drinks";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}

class SnacksController extends GetxController {
  static SnacksController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "snacks";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}

class MeatController extends GetxController {
  static MeatController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "meat";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}

class OthersController extends GetxController {
  static OthersController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collection = "others";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<ProductModel>> getAllProducts() =>
      firebaseFirestore.collection(collection).snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
