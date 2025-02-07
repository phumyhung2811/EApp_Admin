import 'package:adminpanel/models/product_model/product_model.dart';

class OrderModel {
  OrderModel({
    required this.payment,
    required this.orderId,
    required this.products,
    required this.status,
    required this.totalPrice,
    required this.userId,
  });

  String payment;
  String status;
  List<ProductModel> products;
  String orderId;
  double totalPrice;
  String userId;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      products: productMap.map((i) => ProductModel.fromJson(i)).toList(),
      payment: json['payment'],
      totalPrice: json['totalPrice'],
      status: json['status'],
    );
  }
}
