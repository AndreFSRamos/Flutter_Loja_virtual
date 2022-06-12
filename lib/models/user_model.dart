import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  Map<String, dynamic> userdata = {};
  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentuser();
  }

  void singOut() async {
    await _auth.signOut();
    userdata = {};
    usuario = null;
    notifyListeners();
  }

  void singUp(Map<String, dynamic> userdata, String pass,
      VoidCallback onSuccess, Function onFail) async {
    try {
      isLoading = true;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: userdata["email"], password: pass);

      _getUser();

      usuario = await _saveUserData(userdata);

      onSuccess();

      isLoading = false;

      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        isLoading = false;
        onFail("Senha muito fraca!");
        notifyListeners();
      } else if (error.code == "email-already-exists") {
        isLoading = false;
        onFail("O email informado já está em uso!");
        notifyListeners();
      } else if (error.code == "internal-error") {
        isLoading = false;
        onFail("Falha ao cria usuário, confira seus dados de login.");
      }
      isLoading = false;
    }
    isLoading = false;
  }

  void singIn(String email, String pass, VoidCallback onSuccess,
      Function onFail) async {
    try {
      isLoading = true;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      _getUser();
      await _loadCurrentuser();

      usuario = _auth.currentUser;
      onSuccess();
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        isLoading = false;
        onFail("Usuário não cadastrado!");
        notifyListeners();
      } else if (error.code == "wrong-password") {
        isLoading = false;
        onFail("Senha incorreta!");
        notifyListeners();
      } else if (error.code == "internal-error") {
        isLoading = false;
        onFail("Falha ao logar, confira seus dados de login.");
      }
      isLoading = false;
    }
    isLoading = false;
  }

  void recoverPass(String email, Function onFail) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      onFail("Falhar ao enviar, confira se o email infomar está correto.");
    }
  }

  bool isLoadingIn() {
    return usuario != null;
  }

  /*_authCheck() {
   _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      notifyListeners();
    });
  }*/

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    userdata = userData;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(usuario!.uid)
        .set(userData);
    //print(userData.toString());
  }

  Future _loadCurrentuser() async {
    // ignore: prefer_conditional_assignment
    if (usuario == null) _getUser();
    //print("User == : ${usuario.toString()}");
    if (usuario != null) {
      //print("User != : ${usuario.toString()}");
      if (userdata["name"] == null) {
        // print("User == : ${userdata["name"]}");
        var docUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(usuario!.uid)
            .get();

        userdata = docUser.data()!;
      }
    }
    notifyListeners();
  }
}
