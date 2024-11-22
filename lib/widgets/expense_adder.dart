import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseAdder extends StatefulWidget {
  final List<Expense> _registeredExpenses;
  final Function() refresher;
  const ExpenseAdder(this._registeredExpenses, this.refresher, {super.key});

  @override
  State<ExpenseAdder> createState() => _ExpenseAdderState();
}

class _ExpenseAdderState extends State<ExpenseAdder> {
  var titleContoller = TextEditingController();
  var amountContoller = TextEditingController();
  Categorry _selectedCategory = Categorry.leisure;
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final now = DateTime.now();

    final dateSelected = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year, now.month + 1, now.day),
    );

    setState(() {
      _selectedDate = dateSelected;
    });
  }

  void dispose() {
    titleContoller.dispose();
    amountContoller.dispose();
    super.dispose();
  }

  void _validateData() {
    double? amount = double.tryParse(amountContoller.text);
    final amountIsValid = amount != null && amount > 0;
    if (amountIsValid &&
        // ignore: unnecessary_null_comparison
        titleContoller.text != null &&
        _selectedDate != null &&
        _selectedCategory != null) {
      Expense myExpense = Expense(
        amount: amount,
        dateTime: _selectedDate!,
        title: titleContoller.text,
        category: _selectedCategory!,
      );
      widget._registeredExpenses.add(myExpense);
      widget.refresher();
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          content: const Text('Invalid values entered'),
          title: Icon(
            Icons.error,
            color: kColorScheme.primary,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final overflowed = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, overflowed),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                maxLength: 50,
                controller: titleContoller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    hintText: 'Enter Title',
                    hintStyle: TextStyle()),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountContoller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee),
                        hintText: 'Enter Amount',
                      ),
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    _selectedDate == null
                        ? 'No Date Selected'
                        : dateformatter.format(_selectedDate!),
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 40,
                    ),
                  ),
                ],
              ),
              DropdownButton(
                  // style: const TextStyle(
                  //     fontWeight: FontWeight.bold, color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  underline: const SizedBox.shrink(),
                  dropdownColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                  value: _selectedCategory,
                  items: Categorry.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .foregroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // DropDownButton(),
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton(
                      onPressed: () {
                        _validateData();
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
