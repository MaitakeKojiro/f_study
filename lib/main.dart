import 'package:example/main_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
// StatelessWidgetは状態を持たない
// ビルドしたときの値から変えられない。

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("セカンドルート"),
          ),
          // Consumerで囲んだ部分だけ、再描画される
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.maiText,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  TextButton(
                    // ボタンを押したときに変数maiTextの値を変える
                    onPressed: () {
                      //todo ここで何か
                      model.changeMaiText();
                    },
                    child: Text('ボタン'),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
