import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lista_de_contatos/shared/theme/colors.dart';

class MyThemes{
  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorSchemeSeed: AppColors.primary,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColors.text,
        fontSize: 16
      )
    ),
  );
  static final lightTheme  = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColors.text,
        fontSize: 16
      )
    ),
  );

  static ThemeData selectTheme(){
  var theme = SchedulerBinding.instance.window.platformBrightness.name;

    if(theme == 'dark' ){
      return darkTheme;
    }else{
      return lightTheme;
    }
  }
}
