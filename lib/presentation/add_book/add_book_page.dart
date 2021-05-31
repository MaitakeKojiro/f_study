import 'package:example/domain/book.dart';
import 'package:example/presentation/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {

    // 比較演算子で入れてtrue/falseを代入
    final bool isUpdate = book != null;
    final textEditingController = TextEditingController(); // テキストフィールドの内容を改変するクラス


    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // 三項演算子でタイトルを変える nullの場合はfalseなので、本を追加になる
          title: Text(isUpdate ? '本を編集' : '本を追加'),
        ),
        body: Consumer<AddBookModel>(builder: (context, model, child) {
          return Column(
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  model.bookTitle = text;
                },
                controller: textEditingController,
              ),
              ElevatedButton(
                  child: Text(isUpdate ? '更新する' : '追加'),
                  onPressed: () async {
                    if (isUpdate) {
                      // firestoreの本を更新
                      await updateBook(context, model);
                    } else {
                      // firestoreに本を追加
                      await addBook(context, model);
                    }
                  })
            ],
          );
        }),
      ),
    );
  }

  // firestoreにデータを追加
  Future addBook(
    BuildContext context,
    AddBookModel model,
  ) async {
    try {
      await model.addBookToFireBase();
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('追加しました。'),
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
          });
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e),
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
          });
    }
  }

  // データの更新
  Future updateBook(
    BuildContext context,
    AddBookModel model,
  ) async {
    try {
      await model.updateBook(book);
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('保存しました。'),
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
          });
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e),
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
          });
    }
  }
}
