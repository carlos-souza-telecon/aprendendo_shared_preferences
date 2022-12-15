import 'package:aprendendo_shared_preferences/pages/home_page.dart';
import 'package:aprendendo_shared_preferences/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget paginaInicial =
      prefs.getString('emailLogado') == null ? LoginPage() : HomePage();

  runApp(MyApp(paginaInicial));
}

class MyApp extends StatelessWidget {
  Widget paginaInicial;

  MyApp(this.paginaInicial, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: paginaInicial,
    );
  }
}
