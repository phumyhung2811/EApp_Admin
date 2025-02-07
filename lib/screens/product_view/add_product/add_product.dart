import 'dart:io';

import 'package:adminpanel/constants/constants.dart';
import 'package:adminpanel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/models/product_model/product_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Thêm sản phẩm",
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
          TextFormField(
            controller: description,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: "Mô tả sản phẩm",
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "\$ Giá sản phẩm",
            ),
          ),
          const SizedBox(height: 24),
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: DropdownButtonFormField<CategoryModel>(
              value: _selectedCategory,
              hint: const Text('Lựa chọn loại sản phẩm'),
              isExpanded: true,
              onChanged: (CategoryModel? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: appProvider.getCategoriesList.map((CategoryModel val) {
                return DropdownMenuItem<CategoryModel>(
                  value: val,
                  child: Text(val.name),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              if (image == null ||
                  _selectedCategory == null ||
                  name.text.isEmpty ||
                  description.text.isEmpty ||
                  price.text.isEmpty) {
                showMessage("Điền đầy đủ thông tin");
              } else {
                appProvider.addProduct(
                  image!,
                  name.text,
                  _selectedCategory!.id,
                  price.text,
                  description.text,
                );

                showMessage("Thêm thành công");
                Navigator.of(context).pop();
              }

              // appProvider.updateUserInfoFirebase(context, userModel, image);
            },
            child: const Text(
              "Thêm sản phẩm",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
DropdownButtonFormField(
  value: _selectedValue,
  hint: Text('choose me'),
  isExpanded: true,
  onChanged: (value){
    setSate((){
      _selectedValue = value;
    })
  },
  onSaved: (value) {
    setSate((){
      _selectedValue = value;
    })
  },
  validator: (String value) {
    if (value.isEmpty){
      return "can't empty";
    }else {
      return null
    }
  },
  items: listOfValue.map((String val) {
    return DropdownMenuItem(
      value: val,
      child: Text(val),
    );
  }).toList(),
  );
)
 */