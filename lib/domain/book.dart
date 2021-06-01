// モデル（エンティティモデル、要素的なもの。Javaでいうbean）
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc.data()['title'];
    imageURL = doc.data()['imageURL'];
  }
  String documentID;
  String title;
  String imageURL;
}
