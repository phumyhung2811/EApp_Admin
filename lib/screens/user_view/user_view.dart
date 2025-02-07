import 'package:adminpanel/models/user_model/user_model.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/user_view/widgets/single_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý người dùng"),
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.getUserList.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              UserModel userModel = value.getUserList[index];
              return SingleUserCard(
                userModel: userModel,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
