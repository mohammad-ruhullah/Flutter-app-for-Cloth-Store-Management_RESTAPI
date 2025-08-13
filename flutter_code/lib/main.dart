import 'package:flutter/material.dart';

import 'Screen/show_item_list.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rest API Practice",
      debugShowCheckedModeBanner: false, // to remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: false
      ),
      home: ShowItem()
    );
  }
}
