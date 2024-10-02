 

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_managemnt/controllers/income_controller.dart';
import 'package:personal_finance_managemnt/model/income.dart';
import 'package:personal_finance_managemnt/view/widget/confirm_dialog.dart';
 

class IncomeView extends StatelessWidget {
  final IncomeController incomeController = Get.put(IncomeController());

  IncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final totalIncome = incomeController.getTotalIncome();
              return Text(
                'Total Income: ৳${totalIncome.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              return incomeController.incomes.isEmpty
                  ? const Center(
                      child: Text('No income added'),
                    )
                  : ListView.builder(
                      itemCount: incomeController.incomes.length,
                      itemBuilder: (context, index) {
                        final income = incomeController.incomes[index];
                        final formattedDate =
                            DateFormat.yMMMd().format(income.date);

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            tileColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.all(12.0),
                            title: Text(
                              '৳${income.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              '${income.source} - ${income.description}\nDate: $formattedDate',
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    _showAddEditIncomeSheet(context,
                                        editMode: true,
                                        index: index,
                                        income: income);
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
            _showAddEditIncomeSheet(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Show custom delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: 'Confirm Deletion',
          content: 'Are you sure you want to delete this income entry?',
          confirmText: 'Delete',
          cancelText: 'Cancel',
          onConfirmed: () {
            incomeController.deleteIncome(index);
            Get.back();
          },
        );
      },
    );
  }

  void _showAddEditIncomeSheet(BuildContext context,
      {bool editMode = false, int? index, Income? income}) {
    final amountController =
        TextEditingController(text: editMode ? income?.amount.toString() : '');
    final sourceController =
        TextEditingController(text: editMode ? income?.source : '');
    final descriptionController =
        TextEditingController(text: editMode ? income?.description : '');

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
                    controller: sourceController,
                    decoration: const InputDecoration(labelText: 'Source'),
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
                        final source = sourceController.text;
                        final description = descriptionController.text;

                        if (editMode && index != null) {
                          incomeController.editIncome(
                              index, amount, source, description);
                        } else {
                          incomeController.addIncome(
                              amount, source, description);
                        }
                        Get.back();
                      },
                      child: Text(editMode ? 'Edit Income' : 'Add Income'),
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
}
