import 'package:aprendendo_shared_preferences/pages/login_page.dart';
import 'package:aprendendo_shared_preferences/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _prefs;
  String? emailLogado = '';

  @override
  initState() {
    _iniciarPreferences();
    super.initState();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      emailLogado = _prefs.getString('emailLogado');
    });
    if (emailLogado == null) {
      push(
        context,
        LoginPage(),
        replace: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      body: Column(
        children: [
          Text('$emailLogado'),
          ElevatedButton(
            onPressed: () async {
              await _prefs.remove('emailLogado');
              push(
                context,
                LoginPage(),
                replace: true,
              );
            },
            child: Text('SAIR'),
          ),
        ],
      ),
    );
  }
}
