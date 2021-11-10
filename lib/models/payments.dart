class PaymentsModel {
  static const ID = "id";
  static const PAYMENT_ID = "paymentId";
  static const CART = "cart";
  static const FAVOURITE = "favourite";
  static const AMOUNT = "amount";
  static const STATUS = "status";
  static const ORDERSTATUS = "orderstatus";
  static const TABLE = "table";
  static const RECEIVER = "reciever";
  static const ADDRESS = "address";
  static const REQUEST = "request";
  static const CREATED_AT = "createdAt";

  String id;
  String paymentId;
  String amount;
  String status;
  String orderstatus;
  String table;
  String receiver;
  String address;
  String request;
  int createdAt;
  List cart;
  List favourite;

  PaymentsModel({
    this.id,
    this.paymentId,
    this.amount,
    this.status,
    this.orderstatus,
    this.table,
    this.receiver,
    this.address,
    this.request,
    this.createdAt,
    this.cart,
    this.favourite,
  });

  PaymentsModel.fromMap(Map data) {
    id = data[ID];
    createdAt = data[CREATED_AT];
    paymentId = data[PAYMENT_ID];
    amount = data[AMOUNT];
    status = data[STATUS];
    orderstatus = data[ORDERSTATUS];
    table = data[TABLE];
    receiver = data[RECEIVER];
    address = data[ADDRESS];
    request = data[REQUEST];
    cart = data[CART];
    favourite = data[FAVOURITE];
  }
}
