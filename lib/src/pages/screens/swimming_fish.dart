import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/fish_widget.dart';

class SwimmingFish extends StatefulWidget {
  const SwimmingFish({super.key});

  @override
  State<SwimmingFish> createState() => _SwimmingFishState();
}

class _SwimmingFishState extends State<SwimmingFish>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double verticalPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    verticalPosition = 200 + Random().nextInt(350).toDouble();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    _animation = Tween<double>(
      begin: -100, // start off the screen to the left
      end: screenWidth + 100, // end off the screen to the right
    ).animate(_controller);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value,
          top: verticalPosition,
          child: const FishWidget(),
        );
      },
    );
  }
}
