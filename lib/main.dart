import 'package:flutter/material.dart';
import 'package:open_board/Board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OpenBoardScreen()
    );
  }
}

