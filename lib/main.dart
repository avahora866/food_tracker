import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/today_screen.dart';

void main() => runApp(const ProviderScope(child: FoodTrackerApp()));

class FoodTrackerApp extends StatelessWidget {
  const FoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness b) => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: b),
      visualDensity: VisualDensity.compact,
    );
    return MaterialApp(
      title: 'Food Tracker',
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: const TodayScreen(),
    );
  }
}
