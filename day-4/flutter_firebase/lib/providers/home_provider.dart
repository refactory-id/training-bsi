import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/providers/base_provider.dart';
import 'package:flutter_firebase/states/base_state.dart';
import 'package:provider/provider.dart';

class HomeProvider extends BaseProvider {
  static HomeProvider unListen(BuildContext context) =>
      Provider.of<HomeProvider>(context, listen: false);

  final FirebaseMessaging _firebaseMessaging;
  final CollectionReference _reference;
  final FirebaseAuth _auth;
  final Dio _dio;

  HomeProvider(this._firebaseMessaging, this._auth, this._reference, this._dio);

  void logout() async {
    await _auth.signOut();
    await _reference.doc(_auth.currentUser.uid).update({"token": ""});
  }

  void getToken() {
    _firebaseMessaging.getToken().then((token) =>
        _reference.doc(_auth.currentUser.uid).update({"token": token}));
  }

  void sendMessage(String message, UserModel user, Function onSuccess) async {
    try {
      await _dio.post("fcm/send", data: {
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sender": _auth.currentUser.email,
          "image": _auth.currentUser.photoURL,
          "message": message
        },
        "to": user.token
      });

      state = Success();

      onSuccess();

      changeToIdle();
    } catch (e) {
      handleException(e);
    }
  }

  Stream<QuerySnapshot> get allUserStream => _reference
      .where("id", isNotEqualTo: _auth.currentUser?.uid ?? "")
      .snapshots(includeMetadataChanges: true);
}
