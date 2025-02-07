import 'dart:io';

import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thêm Danh mục",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          image == null
              ? CupertinoButton(
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
            decoration: const InputDecoration(
              hintText: "Tên sản phẩm",
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (image == null && name.text.isEmpty) {
                Navigator.of(context).pop();
              } else if (image != null && name.text.isNotEmpty) {
                appProvider.addCategory(image!, name.text);
                showMessage("Cập nhật thành công");
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
