import 'package:adminpanel/models/order_model/order_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/widgets/single_order_widget/single_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  List<OrderModel> orderModelList;
  final String title;
  OrderList({super.key, required this.title, required this.orderModelList});

  List<OrderModel> getOrderList(AppProvider appProvider) {
    if (title == "Đang xử lý") {
      return appProvider.getPendingOrderList;
    } else if (title == "Xác nhận") {
      return appProvider.getCompletedOrderList;
    } else if (title == "Hủy") {
      return appProvider.getCancelOrderList;
    } else if (title == "Đang vận chuyển") {
      return appProvider.getDeliveryOrderList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng $title"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child:
            // getOrderList(appProvider).isEmpty
            //     ? const Center(
            //         child: Text("Rỗng"),
            //       )
            //     :
            ListView.builder(
          // itemCount: getOrderList(appProvider).length,
          // itemBuilder: (context, index) {
          //   OrderModel orderModel = getOrderList(appProvider)[index];
          //   return SingleOrderWidget(orderModel: orderModel);
          // },
          itemCount: orderModelList.length,
          itemBuilder: (context, index) {
            OrderModel orderModel = orderModelList[index];
            return SingleOrderWidget(orderModel: orderModel);
          },
        ),
      ),
    );
  }
}
