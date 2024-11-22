import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 92, 139, 132),
);
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 48, 41));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData().copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor:
                WidgetStatePropertyAll(kDarkColorScheme.primaryContainer),
          ),
        ),
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          color: kDarkColorScheme.primary,
          foregroundColor: kDarkColorScheme.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        scaffoldBackgroundColor: kDarkColorScheme.surface,
        floatingActionButtonTheme: const FloatingActionButtonThemeData()
            .copyWith(
                backgroundColor: kDarkColorScheme.primaryContainer,
                foregroundColor: kDarkColorScheme.onPrimaryContainer),
        textTheme: const TextTheme().copyWith(
            titleLarge: const TextStyle(letterSpacing: 1.3),
            bodyMedium: TextStyle(color: kDarkColorScheme.onPrimaryContainer),
            titleSmall:
                TextStyle(color: kDarkColorScheme.onSecondaryContainer)),
        iconTheme: const IconThemeData()
            .copyWith(color: kDarkColorScheme.onPrimaryContainer),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide.none,
          ),
          fillColor: kDarkColorScheme.primaryContainer,
          filled: true,
          border: InputBorder.none,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(kColorScheme.primaryContainer),
          ),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          color: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        scaffoldBackgroundColor: kColorScheme.surface,
        floatingActionButtonTheme: const FloatingActionButtonThemeData()
            .copyWith(
                backgroundColor: kColorScheme.primaryContainer,
                foregroundColor: kColorScheme.onPrimaryContainer),
        textTheme: const TextTheme().copyWith(
          titleLarge: const TextStyle(letterSpacing: 1.3),
          bodyMedium: TextStyle(color: kColorScheme.onPrimaryContainer),
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(23),
            borderSide: BorderSide.none,
          ),
          fillColor: kColorScheme.primaryContainer,
          filled: true,
          border: InputBorder.none,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}
