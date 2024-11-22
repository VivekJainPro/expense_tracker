import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_adder.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // ignore: non_constant_identifier_names
  Widget BlankWidget = const Center(
    child: Text(
      'NO EXPENSES TO DISPLAY',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );

  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Boorgir',
      amount: 20.50,
      category: Categorry.food,
      dateTime: DateTime.now(),
    ),
    Expense(
      title: 'Invincible',
      amount: 10.30,
      category: Categorry.leisure,
      dateTime: DateTime.now(),
    )
  ];

  // here's how u undo a performed action (undo logic)
  void refresher() {
    setState(() {});
  }

  void _expenseRemover(Expense expense) {
    int currIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(currIndex, expense);
              },
            );
          },
          key: ValueKey(expense),
        ),
      ),
    );
  }

  void _expenseAdderScreen() {
    showModalBottomSheet(
      useSafeArea: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).shadowColor.withAlpha(150),
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        child: ExpenseAdder(_registeredExpenses, refresher),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _expenseAdderScreen();
            },
          ),
        ],
      ),
      body: currWidth < 450
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: _registeredExpenses.isEmpty
                      ? BlankWidget
                      : ExpenseList(
                          requiredList: _registeredExpenses,
                          expenseRemover: _expenseRemover),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: _registeredExpenses.isEmpty
                      ? BlankWidget
                      : ExpenseList(
                          requiredList: _registeredExpenses,
                          expenseRemover: _expenseRemover),
                ),
              ],
            ),
    );
  }
}
