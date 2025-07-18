import 'dart:io';

import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/models/order_model/order_model.dart';
import 'package:adminpanel/models/product_model/product_model.dart';
import 'package:adminpanel/models/user_model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/foundation.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<List<UserModel>> getUserList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("users").get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("categories").get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();

      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<String> deleteSingleUser(String id) async {
    try {
      await _firebaseFirestore.collection("users").doc(id).delete();
      return "Xóa thành công";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUser(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(userModel.id)
          .update(userModel.toJson());
    } catch (e) {}
  }

  Future<String> deleteSingleCategory(String id) async {
    try {
      await _firebaseFirestore.collection("categories").doc(id).delete();
      return "Xóa thành công";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleCategory(CategoryModel categoryModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } catch (e) {}
  }

  Future<CategoryModel> addSingleCategory(File image, String name) async {
    DocumentReference reference =
        _firebaseFirestore.collection("categories").doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    CategoryModel addCategory = CategoryModel(
      image: imageUrl,
      id: reference.id,
      name: name,
    );
    await reference.set(addCategory.toJson());
    return addCategory;
  }

  // Products
  Future<List<ProductModel>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup("products").get();
    List<ProductModel> productList =
        querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    return productList;
  }

  Future<String> deleteProduct(String categoryId, String productId) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(categoryId)
          .collection("products")
          .doc(productId)
          .delete();
      return "Xóa thành công";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateSingleProduct(ProductModel productModel) async {
    try {
      await _firebaseFirestore
          .collection("categories")
          .doc(productModel.categoryId)
          .collection("products")
          .doc(productModel.id)
          .update(productModel.toJson());
    } catch (e) {}
  }

  Future<ProductModel> addSingleProduct(
    File image,
    String name,
    String categoryId,
    String price,
    String description,
  ) async {
    DocumentReference reference = _firebaseFirestore
        .collection("categories")
        .doc(categoryId)
        .collection("products")
        .doc();
    String imageUrl = await FirebaseStorageHelper.instance
        .uploadUserImage(reference.id, image);
    ProductModel addProduct = ProductModel(
      image: imageUrl,
      id: reference.id,
      name: name,
      categoryId: categoryId,
      description: description,
      isFavorite: false,
      price: double.parse(price),
      sluong: 1,
    );
    await reference.set(addProduct.toJson());
    return addProduct;
  }

  Future<List<OrderModel>> getCompletedOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> completedOrder =
          await _firebaseFirestore
              .collection("orders")
              .where("status", isEqualTo: "Xác nhận")
              .get();
      List<OrderModel> completedOrderList = completedOrder.docs
          .map((e) => OrderModel.fromJson(e.data()))
          .toList();

      return completedOrderList;
    } catch (e) {
      print("Error fetching completed orders: $e");
      return [];
    }
  }

  Future<List<OrderModel>> getCancelOrder() async {
    QuerySnapshot<Map<String, dynamic>> cancelOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Hủy")
        .get();
    List<OrderModel> cancelOrderList =
        cancelOrder.docs.map((e) => OrderModel.fromJson(e.data())).toList();

    return cancelOrderList;
  }

  Future<List<OrderModel>> getPendingOrder() async {
    QuerySnapshot<Map<String, dynamic>> pendingOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Đang xử lý")
        .get();
    List<OrderModel> pendingOrderList =
        pendingOrder.docs.map((e) => OrderModel.fromJson(e.data())).toList();

    return pendingOrderList;
  }

  Future<List<OrderModel>> getDeliveryOrder() async {
    QuerySnapshot<Map<String, dynamic>> deliveryOrder = await _firebaseFirestore
        .collection("orders")
        .where("status", isEqualTo: "Đang vận chuyển")
        .get();
    List<OrderModel> deliveryOrderList =
        deliveryOrder.docs.map((e) => OrderModel.fromJson(e.data())).toList();

    return deliveryOrderList;
  }

  Future<void> updateOrder(OrderModel orderModel, String status) async {
    await _firebaseFirestore
        .collection("usersOrders")
        .doc(orderModel.userId)
        .collection("orders")
        .doc(orderModel.orderId)
        .update(
      {
        "status": status,
      },
    );

    await _firebaseFirestore
        .collection("orders")
        .doc(orderModel.orderId)
        .update(
      {
        "status": status,
      },
    );
  }
}
