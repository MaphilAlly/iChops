import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ichops/models/fav_item.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const PHONE = "phone";
  static const EMAIL = "email";
  static const CART = "cart";
  static const FAVOURITE = "favourite";

  String id;
  String name;
  String phone;
  String email;
  List<CartItemModel> cart;
  List<FavouriteItemModel> favourite;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.cart,
    this.favourite,
    this.phone,
  });

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()[NAME];
    phone = snapshot.data()[PHONE];
    email = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
    cart = _convertCartItems(snapshot.data()[CART] ?? []);
    favourite = _convertFavouriteItems(snapshot.data()[FAVOURITE] ?? []);
  }

  List<CartItemModel> _convertCartItems(List cartFromDb) {
    List<CartItemModel> _result = [];
    if (cartFromDb.length > 0) {
      cartFromDb.forEach((element) {
        _result.add(CartItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List cartItemsToJson() => cart.map((item) => item.toJson()).toList();

//favourite method and functions
  List<FavouriteItemModel> _convertFavouriteItems(List favouriteFromDb) {
    List<FavouriteItemModel> _result = [];
    if (favouriteFromDb.length > 0) {
      favouriteFromDb.forEach((element) {
        _result.add(FavouriteItemModel.fromMap(element));
      });
    }
    return _result;
  }

  List favouriteItemsToJson() =>
      favourite.map((item) => item.toJson()).toList();
}
