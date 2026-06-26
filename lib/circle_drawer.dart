import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CircleDrawerScreen()));

class CircleDrawerScreen extends StatefulWidget {
  const CircleDrawerScreen({super.key});

  @override
  State<CircleDrawerScreen> createState() => _CircleDrawerScreenState();
}

class CircleData {
  CircleData({required this.x, required this.y, required this.radius});

  final double x;
  final double y;
  double radius;

  bool containsPoint(double mouseX, double mouseY) {
    return pow(mouseX - x, 2) + pow(mouseY - y, 2) < pow(radius, 2);
  }
}

class _CircleDrawerScreenState extends State<CircleDrawerScreen> {
  List<CircleData> circles = [];
  List<CircleData> removedCircles = [];

  double mouseX = 0.0;
  double mouseY = 0.0;
  double diameter = 75.0;

  int? indexCircleUnderMouse;
  int? indexCircleSelected;

  void _updateLocation(PointerEvent details) {
    setState(() {
      mouseX = details.localPosition.dx;
      mouseY = details.localPosition.dy;

      for (var i = circles.length - 1; i >= 0; i--) {
        if (circles[i].containsPoint(mouseX, mouseY)) {
          indexCircleUnderMouse = i;

          return;
        }
      }
      indexCircleUnderMouse = null;
    });
  }

  void _redo() {
    if (removedCircles.isNotEmpty) {
      setState(() {
        circles.add(removedCircles.last);
        removedCircles.removeLast();
      });
    }
  }

  void _undo() {
    if (circles.isNotEmpty) {
      setState(() {
        removedCircles.add(circles.last);
        circles.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CircleDraw')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (circles.isNotEmpty) {
                    _undo();
                  }
                },
                child: const Text('Undo'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (removedCircles.isNotEmpty) {
                    _redo();
                  }
                },
                child: const Text('Redo'),
              ),
            ],
          ),
          const SizedBox(height: 16),

          MouseRegion(
            onHover: _updateLocation,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (indexCircleUnderMouse != null) {
                    indexCircleSelected = indexCircleUnderMouse;
                    diameter = circles[indexCircleSelected!].radius * 2;
                  } else {
                    circles.add(
                      CircleData(x: mouseX, y: mouseY, radius: diameter / 2),
                    );
                  }
                });
              },
              child: Container(
                width: 450,
                height: 450,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(155, 203, 232, 255),
                ),
                child: ClipRect(
                  child: Stack(
                    children: circles.indexed
                        .map(
                          (e) => CustomPaint(
                            size: const Size(400, 400),
                            painter: CirclePainter(
                              e.$2,
                              e.$1 == indexCircleUnderMouse,
                              e.$1 == indexCircleSelected,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (indexCircleSelected != null)
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Adjust diameter of circle to size: ${diameter.round()}',
                    ),
                    Slider(
                      value: diameter,
                      min: 10,
                      max: 150,
                      onChanged: (v) {
                        setState(() {
                          diameter = v;
                          var x = circles[indexCircleSelected!].x;
                          var y = circles[indexCircleSelected!].y;

                          circles[indexCircleSelected!] = CircleData(
                            x: x,
                            y: y,
                            radius: diameter / 2,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(this.circle, this.onCircle, this.isSelected);

  final CircleData circle;
  final bool onCircle;
  final bool isSelected;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    if (isSelected) {
      paint.color = const Color.fromARGB(255, 147, 56, 101);
    } else if (onCircle) {
      paint.color = const Color.fromARGB(255, 198, 135, 165);
    } else {
      paint.color = const Color.fromARGB(128, 255, 38, 99);
    }

    final center = Offset(circle.x, circle.y);

    canvas.drawCircle(center, circle.radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
