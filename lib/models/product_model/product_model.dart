import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavorite,
    required this.sluong,
  });

  String? image;
  String id;
  String categoryId;
  bool isFavorite;
  String name;
  double price;
  String description;

  int? sluong;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"].toString(),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["categoryId"] ?? "",
        isFavorite: false,
        price: double.parse(json["price"].toString()),
        sluong: json["sluong"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'categoryId': categoryId,
        'isFavorite': isFavorite,
        'price': price,
        'Sluong': sluong,
      };

  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? description,
    String? price,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        isFavorite: false,
        price: price != null ? double.parse(price) : this.price,
        image: image ?? this.image,
        sluong: 1,
      );
}
