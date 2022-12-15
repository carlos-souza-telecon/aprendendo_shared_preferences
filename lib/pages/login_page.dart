import 'package:aprendendo_shared_preferences/pages/home_page.dart';
import 'package:aprendendo_shared_preferences/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _textEmail = TextEditingController();
  var _textSenha = TextEditingController();
  var _formLoginKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;

  @override
  initState() {
    _iniciarPreferences();
    super.initState();
  }

  _iniciarPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('emailLogado') != null) {
      push(
        context,
        HomePage(),
        replace: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Form(
          key: _formLoginKey,
          child: SizedBox(
            width: 300,
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                  elevation: 16.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                          controller: _textEmail,
                          validator: _validarEmail,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Senha',
                          ),
                          controller: _textSenha,
                          obscureText: true,
                          validator: _validarSenha,
                        ),
                        ElevatedButton.icon(
                          onPressed: _logar,
                          icon: Icon(Icons.login),
                          label: Text('LOGIN'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validarSenha(value) {
    if (value == null || value.isEmpty) {
      return 'Preencha a sua senha';
    }
    if (value.length < 8) {
      return 'A senha deve ter ao menos 8 caracteres';
    }
    return null;
  }

  String? _validarEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o seu e-mail';
    }
    if (value.length < 10 || !value.contains('@')) {
      return 'Preencha com um e-mail válido';
    }
    return null;
  }

  void _logar() async {
    if (_formLoginKey.currentState!.validate()) {
      var emailCerto = 'ronaldo@gmail.com';
      var senhaCerta = 'copadomundo';

      var emailDigitado = _textEmail.text;
      var senhaDigitada = _textSenha.text;

      if (emailDigitado == emailCerto && senhaDigitada == senhaCerta) {
        await _prefs.setString('emailLogado', emailDigitado);

        push(
          context,
          HomePage(),
          replace: true,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Usuário e/ou senha incorretos'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }
}
