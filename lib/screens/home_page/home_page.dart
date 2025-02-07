import 'package:adminpanel/constants/routes.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/categories_view/categories_view.dart';
import 'package:adminpanel/screens/home_page/widgets/single_dash_item.dart';
import 'package:adminpanel/screens/order_list/order_list.dart';
import 'package:adminpanel/screens/product_view/product_view.dart';
import 'package:adminpanel/screens/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    await appProvider.callBackFunction();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body:
          // isLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :
          Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
              ),
              const SizedBox(height: 12),
              const Text(
                "MY HUNG",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Text(
                "phumyhung2003@gmail.com",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(top: 12),
                crossAxisCount: 2,
                children: [
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getUserListFunc().toString() == null
                        ? appProvider.getUserListFunc().toString()
                        : appProvider.getUserList.length.toString(),
                    subtitle: "Người dùng",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const UserView(), context: context);
                    },
                  ),
                  SingleDashItem(
                    title:
                        // ignore: unnecessary_null_comparison
                        appProvider.getCategoriesListFunc().toString() != null
                            ? appProvider.getCategoriesList.length.toString()
                            : appProvider.getCategoriesListFunc().toString(),
                    // title: appProvider.getCategoriesListFunc().toString(),

                    subtitle: "Danh mục",
                    onPressed: () {
                      Routes.instance.push(
                          widget: const CategoriesView(), context: context);
                    },
                  ),
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getProduct().toString() == null
                        ? appProvider.getProduct().toString()
                        : appProvider.getProducts.length.toString(),
                    // title: appProvider.getProduct().toString(),
                    subtitle: "Sản phẩm",
                    onPressed: () {
                      Routes.instance
                          .push(widget: const ProductView(), context: context);
                    },
                  ),
                  SingleDashItem(
                    // ${appProvider.getTotalEarning}
                    title: "\$${appProvider.getTotalEarning}",
                    subtitle: "Tổng tiền",
                    onPressed: () {},
                  ),
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getPendingOrder().toString() != null
                        ? appProvider.getPendingOrderList.length.toString()
                        : appProvider.getPendingOrder().toString(),
                    subtitle: "Đơn chờ xử lý",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "đang xử lý",
                            orderModelList: appProvider.getPendingOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getDeliveryOrder().toString() == null
                        ? appProvider.getDeliveryOrder().toString()
                        : appProvider.getDeliveryOrderList.length.toString(),
                    subtitle: "Đơn giao nhận",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "giao nhận",
                            orderModelList: appProvider.getDeliveryOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getCancelOrder().toString() == null
                        ? appProvider.getCancelOrder().toString()
                        : appProvider.getCancelOrderList.length.toString(),
                    subtitle: "Đơn từ chối",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "từ chối",
                            orderModelList: appProvider.getCancelOrderList,
                          ),
                          context: context);
                    },
                  ),
                  SingleDashItem(
                    // ignore: unnecessary_null_comparison
                    title: appProvider.getCompletedOrder().toString() == null
                        ? appProvider.getCompletedOrder().toString()
                        : appProvider.getCompletedOrderList.length.toString(),
                    subtitle: "Đơn đã xác nhận",
                    onPressed: () {
                      Routes.instance.push(
                          widget: OrderList(
                            title: "xác nhận",
                            orderModelList: appProvider.getCompletedOrderList,
                          ),
                          context: context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
