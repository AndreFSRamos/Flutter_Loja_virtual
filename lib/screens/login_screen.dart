// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/models/user_model.dart';
import 'package:loja_uzzubiju/screens/singup_screen.dart';
import 'package:loja_uzzubiju/widgets/circular_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 21, 125),
        title: const Text("ENTRAR"),
        centerTitle: true,
        actions: [
          FlatButton(
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 16),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SingUpScreen()),
              );
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const CircularIndicator();
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@")) {
                        return "E-mail Invalido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: const InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Senha invalida";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty) {
                          _scafoldKey.currentState!.showSnackBar(const SnackBar(
                            content: Text("Insira seu email para recuperação!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recoverPass(_emailController.text, _onFail);
                          _scafoldKey.currentState!.showSnackBar(const SnackBar(
                            content: Text("Confira seu email!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const Text(
                        "Esqueci minha senha!",
                        textAlign: TextAlign.right,
                      ),
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        model.singIn(_emailController.text,
                            _passController.text, _onSuccess, _onFail);
                      }
                    },
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail(String textError) {
    _scafoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(textError),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
