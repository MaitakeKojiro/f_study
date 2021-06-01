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
    final textEditingController =
        TextEditingController(); // テキストフィールドの内容を改変するクラス

    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              // 三項演算子でタイトルを変える nullの場合はfalseなので、本を追加になる
              title: Text(isUpdate ? '本を編集' : '本を追加'),
            ),
            body: Consumer<AddBookModel>(builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      height: 160,
                      child: InkWell(
                        onTap: () async {
                          // TODO: カメラロールを開く
                          await model.showImagePicker();
                        },
                        child: model.imageFile != null
                            ? Image.file(model.imageFile)
                            : Container(
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        model.bookTitle = text;
                      },
                      controller: textEditingController,
                    ),
                    ElevatedButton(
                        child: Text(isUpdate ? '更新する' : '追加'),
                        onPressed: () async {
                          model.startLoading();
                          if (isUpdate) {
                            // firestoreの本を更新
                            await updateBook(context, model);
                          } else {
                            // firestoreに本を追加
                            await addBook(context, model);
                          }
                          model.endLoading();
                        },
                    ),
                  ],
                ),
              );
            }),
          ),
          Consumer<AddBookModel>(builder: (context, model, child) {
            return model.isLoading
                ? Container(
                    color: Colors.grey.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox();
          }),
        ],
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
