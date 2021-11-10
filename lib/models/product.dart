class ProductModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const SCORE = "score";

  String id;
  String image;
  String name;
  String description;
  double price;
  int score;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.description,
    this.price,
    this.score,
  });

  ProductModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    description = data[DESCRIPTION];
    price = data[PRICE].toDouble();
    score = data[SCORE].toInt();
  }
}
