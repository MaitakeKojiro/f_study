import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// Firestoreに値を追加するモデル
class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  Future signUp() async {
    if (mail.isEmpty) {
      throw ('メールアドレスを入力してください。');
    }

    if (password.isEmpty) {
      throw ('パスワードを入力してください。');
    }

    // todo
    // メールアドレスで新規登録
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = result.user.uid;
    // TODO 端末に保存
  }
}
