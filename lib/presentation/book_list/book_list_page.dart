import 'package:example/domain/book.dart';
import 'package:example/presentation/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map(
                  (book) => ListTile(
                    leading: Image.network(book.imageURL != null ?book.imageURL:'https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg'),
                    title: Text(book.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        // todo: 画面遷移

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBookPage(book: book),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                    onLongPress: () async {
                      // todo:　削除
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${book.title}を削除しますか？'),
                            actions: <Widget>[
                              // ボタンを押すと戻る
                              TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // TODO: 削除のAPIを叩く
                                  await deleteBook(context, model, book);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchBooks();
            },
          );
        }),
      ),
    );
  }

  Future deleteBook(
      BuildContext context, BookListModel model, Book book) async {
    try {
      await model.deleteBook(book);
      await model.fetchBooks();
      await _showDialog(context, '削除しました');
    } catch (e) {
      // await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title,) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(title),
          actions: <Widget>[
            // ボタンを押すと戻る
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
