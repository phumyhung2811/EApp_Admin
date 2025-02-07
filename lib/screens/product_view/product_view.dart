import 'package:adminpanel/constants/routes.dart';
import 'package:adminpanel/models/product_model/product_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/product_view/add_product/add_product.dart';
import 'package:adminpanel/screens/product_view/widgets/single_product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const AddProduct(), context: context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sản phẩm",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: appProvider.getProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (ctx, index) {
                  ProductModel singleProduct = appProvider.getProducts[index];
                  return SingleProductView(
                    singleProduct: singleProduct,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
