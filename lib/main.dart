import 'package:adminpanel/constants/theme.dart';
import 'package:adminpanel/firebase_options.dart';
import 'package:adminpanel/provider/app_provider.dart';
import 'package:adminpanel/screens/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'ADMIN',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const HomePage(),
      ),
    );
  }
}
