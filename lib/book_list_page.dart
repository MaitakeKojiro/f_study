
import 'package:example/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      // ..はカスケード演算子。同じオブジェクトに対して複数の処理を行うときに使う。BookListModelをcreate引数に指定して、fetchBooks()メソッドも同時に行う
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            // modelから、
            final books = model.books;
            // Bookを格納したリストをListTileに変換。 なぜかリロードしないと取得出来ない。
            final listTiles = books.map((book) => ListTile(title: Text(book.title))).toList();
            // ListTileを表示
            return ListView(
              children: listTiles,
            );
          }
        ),
      ),
    );
  }
}