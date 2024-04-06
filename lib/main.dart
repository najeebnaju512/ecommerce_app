import 'package:ecommerce_test/presentation/bottom_nav_bar/view/bottom_nav.dart';
import 'package:ecommerce_test/presentation/customer_screen/controller/customer_controller.dart';
import 'package:ecommerce_test/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/bottom_nav_bar/controller/bottom_nav_controller.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavigationController()),
    ChangeNotifierProvider(create: (context) => HomeController()),
     ChangeNotifierProvider(create: (context) => CustomerController()),
    // ChangeNotifierProvider(create: (context) => ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
