import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateformatter = DateFormat.yMMMd();

enum Categorry { leisure, others, travel, food }

const iconGiver = {
  Categorry.leisure: Icons.battery_charging_full,
  Categorry.others: Icons.shopify_outlined,
  Categorry.travel: Icons.airplanemode_active,
  Categorry.food: Icons.restaurant
};

class Expense {
  Expense({
    required this.amount,
    required this.dateTime,
    required this.title,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Categorry category;

  String get formattedDate {
    return dateformatter.format(dateTime);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final List<Expense> expenses;
  final Categorry category;

  double get totalExpenses{
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
