import 'package:expense_tracker/widgets/expense_list/expenses_item.dart';

import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.requiredList, required this.expenseRemover});

  final List<Expense> requiredList;
  final void Function(Expense expense) expenseRemover;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: requiredList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Dismissible(
          background: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(141, 244, 67, 54),
            ),
          ),
          key: ValueKey(requiredList[index]),
          onDismissed: (direction) {
            expenseRemover(requiredList[index]);
          },
          child: ExpenseItem(
            expense: requiredList[index],
          ),
        ),
      ),
    );
  }
}
