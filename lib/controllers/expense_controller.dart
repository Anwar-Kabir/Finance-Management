import 'package:get/get.dart';
import 'package:personal_finance_managemnt/model/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExpenseController extends GetxController {
  var expenses = <Expense>[].obs;
  String? userEmail;  

  @override
  void onInit() {
    super.onInit();
    loadUserEmail();  
  }

  // Add expense
  void addExpense(double amount, String category, String description) {
    final expense = Expense(
      amount: amount,
      category: category,
      description: description,
      date: DateTime.now(),
    );
    expenses.add(expense);
    saveExpenses();
  }

  // Edit expense
  void editExpense(
      int index, double amount, String category, String description) {
    final expense = expenses[index];
    expenses[index] = Expense(
      amount: amount,
      category: category,
      description: description,
      date: expense.date,
    );
    saveExpenses();
  }

  // Delete expense
  void deleteExpense(int index) {
    expenses.removeAt(index);
    saveExpenses();
  }

  // Get total expenses
  double getTotalExpenses() {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  // Save expenses to SharedPreferences based on the user email
  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail != null) {
      final List<String> jsonExpenses =
          expenses.map((expense) => jsonEncode(expense.toJson())).toList();
      await prefs.setStringList('expenses_$userEmail', jsonExpenses);
    }
  }

  // Load expenses from SharedPreferences based on the user email
  Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail != null) {
      final List<String>? jsonExpenses =
          prefs.getStringList('expenses_$userEmail');
      if (jsonExpenses != null) {
        expenses.value = jsonExpenses
            .map((expenseString) => Expense.fromJson(jsonDecode(expenseString)))
            .toList();
      }
    }
  }

  // Load the user's email from SharedPreferences and load their expenses
  Future<void> loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('email');
    if (userEmail != null) {
      loadExpenses();
    }
  }
}

