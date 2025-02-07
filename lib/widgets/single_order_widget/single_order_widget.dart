import 'package:adminpanel/helpers/firebase_firestore_helper/firebase_firestore.dart';
import 'package:adminpanel/models/order_model/order_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleOrderWidget extends StatefulWidget {
  final OrderModel orderModel;
  const SingleOrderWidget({super.key, required this.orderModel});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        collapsedShape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2.3,
          ),
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2.3,
          ),
        ),
        title: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.grey.withOpacity(0.5),
                  child: Image.network(widget.orderModel.products[0].image!),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderModel.products[0].name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      widget.orderModel.products.length > 1
                          ? Column(
                              children: [
                                Text(
                                  "Số lượng: ${widget.orderModel.products[0].sluong.toString()}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            )
                          : SizedBox.fromSize(),
                      Text(
                        "Tổng tiền: \$${widget.orderModel.totalPrice.toString()}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Trạng thái: ${widget.orderModel.status}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      widget.orderModel.status == "Đang xử lý"
                          ? CupertinoButton(
                              onPressed: () async {
                                await FirebaseFirestoreHelper.instance
                                    .updateOrder(
                                        widget.orderModel, "Đang vận chuyển");
                                widget.orderModel.status = "Đang vận chuyển";
                                appProvider
                                    .updatePendingOrder(widget.orderModel);
                                setState(() {});
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                height: 48,
                                width: 160,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Gửi đến vận chuyển",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.fromSize(),
                      const SizedBox(height: 12),
                      widget.orderModel.status == "Đang xử lý" ||
                              widget.orderModel.status == "Đang vận chuyển"
                          ? CupertinoButton(
                              onPressed: () async {
                                if (widget.orderModel.status == "Đang xử lý") {
                                  widget.orderModel.status = "Hủy";
                                  await FirebaseFirestoreHelper.instance
                                      .updateOrder(widget.orderModel, "Hủy");
                                  appProvider.updateCancelPendingOrder(
                                      widget.orderModel);
                                } else {
                                  widget.orderModel.status = "Hủy";
                                  await FirebaseFirestoreHelper.instance
                                      .updateOrder(widget.orderModel, "Hủy");
                                  appProvider.updateCancelDeliveryOrder(
                                      widget.orderModel);
                                }
                                setState(() {});
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                height: 48,
                                width: 160,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Hủy đơn hàng",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.fromSize()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        children: widget.orderModel.products.length > 1
            ? [
                const Text("Chi tiết"),
                const Divider(color: Colors.red),
                ...widget.orderModel.products.map((singleProduct) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 6),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              color: Colors.red.withOpacity(0.5),
                              child: Image.network(singleProduct.image!),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 140,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Số lượng: ${singleProduct.sluong.toString()}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                      ),
                                      Text(
                                        "Tổng tiền: \$${singleProduct.price.toString()}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.red),
                      ],
                    ),
                  );
                }),
              ]
            : [],
      ),
    );
  }
}
