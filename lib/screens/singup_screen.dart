// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loja_uzzubiju/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 21, 125),
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Nome Comleto",
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Nome Invalido";
                  }
                  return null;
                },
              ),
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
                  if (text!.isEmpty || text.length < 6) {
                    return "Senha invalida";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  hintText: "Endereço",
                ),
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Endereço Invalido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> userdata = {
                      "name": _nameController.text,
                      "email": _emailController.text,
                      "address": _addressController.text,
                    };

                    model.singUp(
                        userdata, _passController.text, _onSuccess, _onFail);
                  }
                },
                child: const Text(
                  "CRIAR CONTA",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    _scafoldKey.currentState!.showSnackBar(SnackBar(
      content: const Text("Usuario criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 2),
    ));
    Future.delayed(const Duration(seconds: 2)).then((__) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scafoldKey.currentState!.showSnackBar(const SnackBar(
      content: Text("Falha ao cria usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
