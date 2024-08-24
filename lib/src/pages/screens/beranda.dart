import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:virtual_aquarium/src/pages/screens/swimming_fish.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with SingleTickerProviderStateMixin {
  List<Widget> fishWidgets = [];
  List<Widget> decorationWidgets = [];

  final TransformationController _controller = TransformationController();

  List<String> aquaBgs = [
    'assets/img/aquarium_background.jpg',
    'assets/img/aquarium_background2.jpg',
    'assets/img/aquarium_background3.jpg'
  ];
  int aquaBgCurrentIndex = 0;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Offset _tapPosition;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _pulseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reset();
      }
    });

    _tapPosition = const Offset(0, 0);

    _initializeAquarium();
  }

  @override
  void dispose() {
    super.dispose();
    _pulseController.dispose();
  }

  void _startPloofAnimation(Offset position) {
    setState(() {
      _tapPosition = position;
    });
    _pulseController.forward();
  }

  void _initializeAquarium() {
    _scheduleFishAdding();
  }

  void _scheduleFishAdding() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Future.delayed(const Duration(seconds: 3), () {
        _addNewFish();
      });
      Future.delayed(const Duration(seconds: 6), () {
        setState(() {
          aquaBgCurrentIndex = Random().nextInt(aquaBgs.length);
        });
      });
    });
  }

  void _addNewFish() {
    setState(() {
      fishWidgets.add(const SwimmingFish());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final bg in aquaBgs) {
      precacheImage(AssetImage(bg), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          _startPloofAnimation(details.globalPosition);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                transformationController: _controller,
                constrained: false,
                child: Image.asset(aquaBgs[0], fit: BoxFit.cover),
              ),
            ),
            ...decorationWidgets,
            ...fishWidgets,
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size.infinite,
                painter: RipplePainter(
                    animation: _pulseAnimation, tapPosition: _tapPosition),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final Animation<double> animation;
  final Offset tapPosition;

  RipplePainter({required this.animation, required this.tapPosition})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.5 * (1 - animation.value));

    canvas.drawCircle(tapPosition, animation.value * size.width * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
