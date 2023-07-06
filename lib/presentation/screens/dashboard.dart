import 'package:coinwatcher/constants/themes.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key, required this.theme});

  LightMode theme;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: widget.theme.mainBackground);
  }
}
