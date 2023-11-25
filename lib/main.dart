import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meuapp/core/themes.dart';
import 'package:meuapp/view/login_page.dart';

void main() {
  initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu AppFlutter',
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: LoginPage(),
    );
  }
}
