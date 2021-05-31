import 'package:example/presentation/signup/signup_model..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController(); // テキストフィールドの内容を改変するクラス
    final passwordController = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // 三項演算子でタイトルを変える nullの場合はfalseなので、本を追加になる
          title: Text('ログイン'),
        ),
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'address123@example.com',
                ),
                controller: mailController,
                onChanged: (text) {
                  model.mail = text;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'パスワード',
                ),
                controller: passwordController,
                onChanged: (text) {
                  model.password = text;
                },
              ),
              ElevatedButton(
                  child: Text('ログインする'),
                  onPressed: () async {
                    try {
                      await model.signUp();
                      _showDialog(context, 'ログインしました');
                    } catch (e) {
                      _showDialog(context, e.toString());
                    }
                  }),

            ],
          );
        }),
      ),
    );
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ) {
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
