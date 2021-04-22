// modelからFirestoreのデータを取得する
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/domain/book.dart';
import 'package:flutter/material.dart';

// Firestoreからデータを取得するモデル（ドメインモデル、ロジック）
// ChangeNotifierを付けることで、ChangeNotifierProviderのcreate引数に指定出来る
// ChangeNotifierProviderに変数の変更があったときに通知できる仕組み（これにより、StatefulWidgetを使わずに済む）
class BookListModel extends ChangeNotifier {
  List<Book> books = [];
  /*Firestoreのメソッドを呼んでbooks変数に値を挿入*/
  Future fetchBooks() async {
    // Firestoreからbooksコレクションを取得
    final docs = await FirebaseFirestore.instance.collection('books').get();
    // titleドキュメントを取得、要素をbook型に変換してリストに格納
    final books = docs.docs.map((doc) => Book(doc)).toList();  // map関数でdoc型をBook型に変換
    this.books = books;
  }
}
