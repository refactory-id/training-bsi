import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/providers/base_provider.dart';
import 'package:flutter_firebase/states/base_state.dart';

class AuthProvider extends BaseProvider {
  final FirebaseAuth _auth;
  final CollectionReference _reference;

  AuthProvider(this._auth, this._reference);

  String name = "", email = "", password = "";

  bool get isLogged => _auth.currentUser != null;

  void register(
      String name, String email, String password, Function onSuccess) async {
    this.name = name;
    this.email = email;
    this.password = password;

    state = Loading();

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _reference.doc(credential.user?.uid).set({
        "id": credential.user?.uid,
        "name": name,
        "email": email,
        "token": ""
      });

      print(credential.user?.uid);

      state = Success();

      onSuccess();
    } catch (e) {
      handleException(e);
    }
  }

  void login(String email, String password, Function onSuccess) async {
    this.email = email;
    this.password = password;

    state = Loading();

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(credential.user?.uid);

      state = Success();

      onSuccess();
    } catch (e) {
      handleException(e);
    }
  }
}
