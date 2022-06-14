import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swipperdeneme/slidder.dart';
import 'package:swipperdeneme/slidder_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  List<SlidderModel> dataList = [];

  @override
  Widget build(BuildContext context) {
    dataList = [
      SlidderModel(
          title: "Emre",
          description:
              "Developer asdasd dsdsd asfasas fffdf 3ew wew xfcsfa sfasdasf asfasfasf asasdw qqwd casczx asce",
          url:
              "https://source.unsplash.com/collection/345710/640x960?${Random().nextInt(1000)}"),
      SlidderModel(
          title: "Ahmet",
          description: "Developer",
          url:
              "https://source.unsplash.com/collection/345710/640x960?${Random().nextInt(1000)}"),
      SlidderModel(
          title: "Burak",
          description: "Developer",
          url:
              "https://source.unsplash.com/collection/345710/640x960?${Random().nextInt(1000)}")
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(title: const Text("Slidder Example")),
          body: Center(
              child: Slidder(
            data: dataList,
            onTap: (SlidderModel item) => debugPrint("tapped ${item.title}"),
            onChange: (item) => debugPrint("changed ${item.title}"),
          ))),
    );
  }
}
