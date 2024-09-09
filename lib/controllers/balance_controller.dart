import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/expense_controller.dart';
import 'package:personal_finance_managemnt/controllers/income_controller.dart';
 

class BalanceController extends GetxController {
  final ExpenseController expenseController = Get.find();
  final IncomeController incomeController = Get.find();

  double get currentBalance {
    return incomeController.getTotalIncome() -
        expenseController.getTotalExpenses();
  }
}
