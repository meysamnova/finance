import 'package:flutter/material.dart';
import 'info_screen.dart';
import 'home_screen.dart';

class MaimScreen extends StatefulWidget {
  const MaimScreen({super.key});

  @override
  State<MaimScreen> createState() => _MaimScreenState();
}

class _MaimScreenState extends State<MaimScreen> {
  int ss = 0;
  List<Widget> rout = const [HomeScreen(), InfoScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: rout[ss],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: ss,
            onTap: (index) {
              setState(() {
                ss = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: ''),
            ]),
      ),
    );
  }
}
