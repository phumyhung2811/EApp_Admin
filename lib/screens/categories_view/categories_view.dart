import 'package:adminpanel/constants/routes.dart';
import 'package:adminpanel/models/category_model/category_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/categories_view/add_category/add_category.dart';
import 'package:adminpanel/screens/categories_view/widgets/single_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const AddCategory(), context: context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Danh sách",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: value.getCategoriesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          value.getCategoriesList[index];
                      return SingleCategoryItem(
                        singleCategory: categoryModel,
                        index: index,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
