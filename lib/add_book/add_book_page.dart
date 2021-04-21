import 'package:example/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('本を追加'),
        ),
        body: Consumer<AddBookModel>(builder: (context, model, child) {
          return Column(
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  model.bookTitle = text;
                },
              ),
              ElevatedButton(
                  child: Text('追加'),
                  onPressed: () async {
                    // firestoreに本を追加
                    // 追加する値がemptyだとエラー
                    try {
                      await model.addBookToFireBase();
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
                  })
            ],
          );
        }),
      ),
    );
  }
}
