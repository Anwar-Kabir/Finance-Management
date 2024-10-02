 



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_managemnt/controllers/expense_controller.dart';
import 'package:personal_finance_managemnt/model/expense.dart';

class ExpenseView extends StatelessWidget {
  final ExpenseController expenseController = Get.put(ExpenseController());

  ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final totalExpense = expenseController.getTotalExpenses();
              return Text(
                'Total Expenses: ৳${totalExpense.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              return expenseController.expenses.isEmpty
                  ? const Center(child: Text('No expenses added'))
                  : ListView.builder(
                      itemCount: expenseController.expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenseController.expenses[index];
                        final formattedDate =
                            DateFormat.yMMMd().format(expense.date);

                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              '৳${expense.amount.toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${expense.category} - ${expense.description}\nDate: $formattedDate',
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _showAddEditExpenseSheet(context,
                                        editMode: true,
                                        index: index,
                                        expense: expense);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        context, index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90.0),
        child: FloatingActionButton(
          onPressed: () {
            _showAddEditExpenseSheet(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddEditExpenseSheet(BuildContext context,
      {bool editMode = false, int? index, Expense? expense}) {
    final amountController =
        TextEditingController(text: editMode ? expense?.amount.toString() : '');
    final categoryController =
        TextEditingController(text: editMode ? expense?.category : '');
    final descriptionController =
        TextEditingController(text: editMode ? expense?.description : '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount'),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final amount =
                            double.tryParse(amountController.text) ?? 0.0;
                        final category = categoryController.text;
                        final description = descriptionController.text;

                        if (editMode && index != null) {
                          expenseController.editExpense(
                              index, amount, category, description);
                        } else {
                          expenseController.addExpense(
                              amount, category, description);
                        }
                        Get.back();
                      },
                      child: Text(editMode ? 'Edit Expense' : 'Add Expense'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back(); 
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                expenseController.deleteExpense(index);  
                Get.back();  
              },
            ),
          ],
        );
      },
    );
  }
}
