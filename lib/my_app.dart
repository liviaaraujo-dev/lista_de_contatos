import 'package:flutter/material.dart';
import 'package:lista_de_contatos/pages/home/home_page.dart';
import 'package:lista_de_contatos/shared/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemes.selectTheme(),
      home: const HomePage(),
    );
  }
}
