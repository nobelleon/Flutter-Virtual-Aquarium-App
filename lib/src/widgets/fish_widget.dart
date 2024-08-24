import 'dart:math';

import 'package:flutter/material.dart';

class FishWidget extends StatefulWidget {
  const FishWidget({super.key});

  @override
  State<FishWidget> createState() => _FishWidgetState();
}

class _FishWidgetState extends State<FishWidget> {
  List<String> fishes = [
    "assets/img/fish1.png",
    "assets/img/fish2.png",
    "assets/img/fish3.png",
    "assets/img/fish4.png",
    "assets/img/fish5.png",
    "assets/img/fish6.png",
    "assets/img/fish7.png",
    "assets/img/fish8.png",
    "assets/img/fish9.png",
    "assets/img/fish10.png",
    "assets/img/fish11.png",
    "assets/img/fish12.png",
    "assets/img/fish13.png",
    "assets/img/fish14.png",
    "assets/img/fish15.png",
    "assets/img/fish16.png",
    "assets/img/fish17.png",
    "assets/img/fish18.png",
    "assets/img/fish19.png",
    "assets/img/fish20.png",
    "assets/img/fish21.png",
    "assets/img/fish22.png",
    "assets/img/fish23.png",
    "assets/img/fish24.png",
    "assets/img/fish25.png",
    "assets/img/fish26.png",
    "assets/img/fish27.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 80,
      child: Image.asset(fishes[Random().nextInt(fishes.length)]),
    );
  }
}
