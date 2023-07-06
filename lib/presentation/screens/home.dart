import 'package:coinwatcher/constants/themes.dart';
import 'package:coinwatcher/presentation/screens/analytics.dart';
import 'package:coinwatcher/presentation/screens/spendings.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.theme});

  LightMode theme;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Dashboard(),
    Spendings(),
    Analytics(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.mainBackground,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loop),
            label: 'Loop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Bar Chart',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
