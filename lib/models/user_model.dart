import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: prefer_typing_uninitialized_variables
  var firebaseuser;
  // ignore: prefer_collection_literals
  Map<String, dynamic> userdata = Map();

  bool isLoading = false;

  void singOut() async {
    await _auth.signOut();
    userdata = {};
    firebaseuser = null;
    notifyListeners();
  }

  void singUp(Map<String, dynamic> userdata, String pass,
      VoidCallback onSuccess, VoidCallback onFail) async {
    isLoading = true;
    notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userdata["email"], password: pass)
        .then((user) async {
      firebaseuser = user;

      await _saveUserData(userdata);

      onSuccess();

      isLoading = false;

      notifyListeners();
    }).catchError((error) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void singIn(String email, String pass, VoidCallback onSuccess,
      VoidCallback onFacil) async {
    isLoading = true;
    notifyListeners();
    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      firebaseuser = user;

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFacil();
      isLoading = false;
      notifyListeners();
    });
  }

  void recoverPass() {}

  bool isLoadingIn() {
    return firebaseuser != null;
  }

  Future _saveUserData(Map<String, dynamic> userData) async {
    userdata = userData;
    await FirebaseFirestore.instance.collection("users").doc().set(userData);
  }
}
