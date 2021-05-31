import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/domain/book.dart';
import 'package:flutter/material.dart';

// Firestoreに値を追加するモデル
class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  Future addBookToFireBase() async {
    // タイトルが空の場合は例外を返す。
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください。');
    }
    // booksコレクションの
    FirebaseFirestore.instance.collection('books').add({
      // titleドキュメントへ追加
      'title': bookTitle,
      // データを追加した時間も追加
      'createdAt': Timestamp.now(),
    });
  }

  // firesotreの値を更新
  Future updateBook(Book book) async {
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);
    await document.update({
      'title': bookTitle,
      'updateAt': Timestamp.now(),
    });
  }
}
