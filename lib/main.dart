import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/balance_controller.dart';
import 'package:personal_finance_managemnt/controllers/expense_controller.dart';
import 'package:personal_finance_managemnt/controllers/income_controller.dart';
import 'package:personal_finance_managemnt/view/splash/splash.dart';

void main() {
  Get.put(ExpenseController());
  Get.put(IncomeController());
  Get.put(BalanceController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}
