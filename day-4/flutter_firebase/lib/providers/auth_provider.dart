import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/providers/base_provider.dart';
import 'package:flutter_firebase/states/base_state.dart';

class AuthProvider extends BaseProvider {
  final FirebaseAuth _auth;
  final CollectionReference _reference;

  AuthProvider(this._auth, this._reference);

  String _name = "", _email = "", _password = "";
  
  set name(String value) => _name = value ?? "";
  set email(String value) => _email = value ?? "";
  set password(String value) => _password = value ?? "";

  String get name => _name;
  String get email => _email;
  String get password => _password;

  bool get isLogged => _auth.currentUser != null;

  void register(
      String name, String email, String password, Function onSuccess) async {
    _name = name;
    _email = email;
    _password = password;

    state = Loading();

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _reference.doc(credential.user.uid).set({
        "id": credential.user.uid,
        "name": name,
        "email": email,
        "token": ""
      });

      print(credential.user.uid);

      state = Success();

      onSuccess();
    } catch (e) {
      handleException(e);
    }
  }

  void login(String email, String password, Function onSuccess) async {
    _email = email;
    _password = password;

    state = Loading();

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print(credential.user.uid);

      state = Success();

      onSuccess();
    } catch (e) {
      handleException(e);
    }
  }
}
