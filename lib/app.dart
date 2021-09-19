import 'package:flutter/material.dart';

import 'screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
