import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  MyPainter({required this.paths});

  List<Path> paths = [];
  Path path = Path();

  //This is where we can draw on canvas.
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    for (Path p in paths) {
      canvas.drawPath(p, paint);
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}
