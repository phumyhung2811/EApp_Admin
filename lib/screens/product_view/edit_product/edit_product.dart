import 'dart:io';

import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:adminpanel/models/product_model/product_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;
  const EditProduct(
      {super.key, required this.productModel, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Chỉnh sửa sản phẩm",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? widget.productModel.image!.isNotEmpty
                  ? CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(widget.productModel.image!),
                      ),
                    )
                  : CupertinoButton(
                      onPressed: () {
                        takePicture();
                      },
                      child: const CircleAvatar(
                        radius: 60,
                        child: Icon(Icons.camera_alt),
                      ),
                    )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          const SizedBox(height: 12),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.productModel.name,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: description,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: widget.productModel.description,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "\$${widget.productModel.price.toString()}",
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (image == null &&
                  name.text.isEmpty &&
                  description.text.isEmpty &&
                  price.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null) {
                String imageUrl = await FirebaseStorageHelper.instance
                    .uploadUserImage(widget.productModel.id, image!);
                ProductModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  image: imageUrl,
                  name: name.text.isEmpty ? null : name.text,
                  price: price.text.isEmpty ? null : price.text,
                );
                appProvider.updateProductList(widget.index, productModel);
                showMessage("Cập nhật thành công");
                Navigator.of(context).pop();
              } else {
                ProductModel productModel = widget.productModel.copyWith(
                  description:
                      description.text.isEmpty ? null : description.text,
                  name: name.text.isEmpty ? null : name.text,
                  price: price.text.isEmpty ? null : price.text,
                );
                appProvider.updateProductList(widget.index, productModel);
                showMessage("Cập nhật thành công");
                Navigator.of(context).pop();
              }

              // appProvider.updateUserInfoFirebase(context, userModel, image);
            },
            child: const Text("Cập nhật"),
          ),
        ],
      ),
    );
  }
}
