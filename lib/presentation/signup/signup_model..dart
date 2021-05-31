import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Firestoreに値を追加するモデル
class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  Future signUp() async {
    if (mail.isEmpty) {
      throw('メールアドレスを入力してください。');
    }

    if (password.isEmpty) {
      throw('パスワードを入力してください。');
    }

    // todo
      // メールアドレスで新規登録
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mail,
          password: password,
      );
      
      final email = userCredential.user.email;

      // Firestoreにユーザーデータを追加
      FirebaseFirestore.instance.collection('books').add({
        'email': email,
        'createdAt': Timestamp.now(),
      });
  }
}
