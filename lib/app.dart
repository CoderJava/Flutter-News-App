import 'package:flutter/material.dart';
import 'package:flutter_news_app/feature/presentation/page/home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: HomePage(),
    );
  }
}
