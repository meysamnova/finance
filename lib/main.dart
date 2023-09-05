import 'package:finance/models/money.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/main_screen.dart';
import 'package:finance/theme/theme_manager.dart';

void main() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MoneyAdapter());
    await Hive.openBox<Money>('moneyBox');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  static void getData() {
    HomeScreen.moneyList.clear();
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');
    for (var element in hiveBo  x.values) {
      HomeScreen.moneyList.add(element);
    }
  }

  static bool isDark = false;
  static toggleTheme() {
    isDark = !isDark;
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: MainApp.isDark ? ThemeMode.dark : ThemeMode.light,
        home: const MaimScreen());
  }
}
