import 'package:flutter/material.dart';

import '../../constants/themes.dart';

class Analytics extends StatefulWidget {
  Analytics({super.key, required this.theme});

  LightMode theme;

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}