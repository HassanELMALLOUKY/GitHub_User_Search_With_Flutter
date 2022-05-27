import 'package:flutter/material.dart';
import 'package:my_app_1/ui/Home.dart';
import 'package:my_app_1/ui/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context)=>Home(),
        "/users":(context)=>User(),
      },
    );
  }
}


