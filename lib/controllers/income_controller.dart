import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal_finance_managemnt/model/income.dart';

class IncomeController extends GetxController {
  var incomes = <Income>[].obs;
  late String userEmail;  

  @override
  void onInit() {
    super.onInit();
    _loadUserEmail();  
  }

  // Load the user's email from SharedPreferences
  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('email') ??
        ""; 
    if (userEmail.isNotEmpty) {
      loadIncomes();  
    }
  }

  // Add income
  void addIncome(double amount, String source, String description) {
    final newIncome = Income(
        amount: amount,
        source: source,
        description: description,
        date: DateTime.now());
    incomes.add(newIncome);
    saveIncomes();  
  }

  // Edit income
  void editIncome(int index, double amount, String source, String description) {
    incomes[index] = Income(
        amount: amount,
        source: source,
        description: description,
        date: incomes[index].date);
    saveIncomes(); 
  }

  // Delete income
  void deleteIncome(int index) {
    incomes.removeAt(index);
    saveIncomes();  
  }

  // Save incomes to SharedPreferences
  Future<void> saveIncomes() async {
    final prefs = await SharedPreferences.getInstance();
    if (userEmail.isNotEmpty) {
      final incomeListJson =
          jsonEncode(incomes.map((income) => income.toJson()).toList());
      await prefs.setString(
          'incomes_$userEmail', incomeListJson);  
    }
  }

  // Load incomes from SharedPreferences
  Future<void> loadIncomes() async {
    final prefs = await SharedPreferences.getInstance();
    final incomeListJson =
        prefs.getString('incomes_$userEmail');  
    if (incomeListJson != null) {
      final List<dynamic> decodedJson = jsonDecode(incomeListJson);
      final loadedIncomes =
          decodedJson.map((json) => Income.fromJson(json)).toList();
      incomes.assignAll(loadedIncomes); 
    }
  }

  // Get total income
  double getTotalIncome() {
    return incomes.fold(0, (sum, item) => sum + item.amount);
  }
}
