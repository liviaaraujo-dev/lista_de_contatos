import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

var theme = SchedulerBinding.instance.window.platformBrightness.name;

class AppColors {
  static Color primary = const Color(0xFFAC14F4);
  static Color background =
      theme == 'dark' ? Colors.black : const Color(0xFFF2F2F2);
  static Color background2 =
      theme == 'dark' ? const Color(0XFF1E1E1E) : Colors.white;
  static Color backgroundPurple =
      theme == 'dark' ? Color(0xFF211529) : Color(0xFFECE6F0);
  static Color text = theme == 'dark' ? Colors.white : Colors.black;
}
