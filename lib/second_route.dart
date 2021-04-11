import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  SecondRoute(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("セカンドルート"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(name),
        ),
      ),
    );
  }
}