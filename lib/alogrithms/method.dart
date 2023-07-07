//Put normal functions here that are supposed to run logic

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Methods {
  String getMonthandYear({required DateTime date, bool commaReq = true}) {
    return commaReq
        ? DateFormat('MMMM, yyyy').format(date)
        : DateFormat('MMMM d').format(date);
  }

  String decimalPart(double amount){
    return ".${(amount.ceilToDouble() - amount).toInt().toString().padLeft(2, '0')}";
  }
}
