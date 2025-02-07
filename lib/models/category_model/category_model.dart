import 'dart:convert';

CategoryModel productModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String productModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.image,
    required this.id,
    required this.name,
  });

  String image;
  String name;
  String id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        image: json["image"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'id': id,
        'name': name,
      };
  CategoryModel copyWith({
    String? name,
    String? image,
  }) =>
      CategoryModel(
        id: id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  // Override phương thức so sánh
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
