import 'package:adminpanel/models/product_model/product_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/product_view/edit_product/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({
    super.key,
    required this.singleProduct,
    required this.index,
  });

  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Card(
      color: Colors.brown.withOpacity(0.7),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        // alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.singleProduct.image!,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 12.0),
                Text(
                  textAlign: TextAlign.center,
                  widget.singleProduct.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Giá: \$${widget.singleProduct.price}"),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        appProvider
                            .deleteProductFromFirebase(widget.singleProduct);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  GestureDetector(
                    onTap: () {
                      Routes.instance.push(
                          widget: EditProduct(
                            productModel: widget.singleProduct,
                            index: widget.index,
                          ),
                          context: context);
                    },
                    child: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
