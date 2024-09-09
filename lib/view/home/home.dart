import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/expense_controller.dart';
import 'package:personal_finance_managemnt/controllers/income_controller.dart';

class HomePage extends StatelessWidget {
  final IncomeController incomeController = Get.put(IncomeController());
  final ExpenseController expenseController = Get.put(ExpenseController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final totalIncome = incomeController.getTotalIncome();
              final totalExpense = expenseController.getTotalExpenses();
              final currentBalance = totalIncome - totalExpense;

              return Column(
                children: [
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: const Text(
                        'Total Income',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      subtitle: Text(
                        '\$${totalIncome.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: const Text(
                        'Total Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        '\$${totalExpense.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Report',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        'Net Balance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              currentBalance >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        '\$${currentBalance.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        'Current Balance',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: currentBalance >= 0
                              ? Colors.blue
                              : Colors.deepOrange,
                        ),
                      ),
                      subtitle: Text(
                        '\$${currentBalance.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
