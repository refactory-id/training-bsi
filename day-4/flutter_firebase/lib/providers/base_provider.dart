import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/states/base_state.dart';

abstract class BaseProvider extends ChangeNotifier {
  ViewState _state = Idle();
  ViewState get state => _state;
  set state(ViewState value) {
    if (_state == value) return;

    _state = value;
    notifyListeners();
  }

  void changeToIdle() {
    Future.delayed((Duration(seconds: 2)), () {
      state = Idle();
    });
  }

  void handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      if (MyApp.isDebug) print(e.message);

      state = Error(e.message ?? "Oops somehing went wrong!");
    } else {
      if (MyApp.isDebug) print(e);

      state = Error(e.message ?? "Oops somehing went wrong!");
    }

    changeToIdle();
  }
}
