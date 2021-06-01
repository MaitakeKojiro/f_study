import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/domain/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Firestoreに値を追加するモデル
class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }
  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFireBase() async {
    // タイトルが空の場合は例外を返す。
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください。');
    }
    final imageURL = await _uploadImage();

    // booksコレクションの
    FirebaseFirestore.instance.collection('books').add({
      // titleドキュメントへ追加
      'title': bookTitle,
      'imageURL': imageURL,
      // データを追加した時間も追加
      'createdAt': Timestamp.now(),
    });
  }

  // firesotreの値を更新
  Future updateBook(Book book) async {
    final imageURL = await _uploadImage();
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);
    await document.update(
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'updateAt': Timestamp.now(),
      },
    );
  }

  Future<String> _uploadImage() async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("books/$bookTitle")
        .putFile(imageFile);
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
