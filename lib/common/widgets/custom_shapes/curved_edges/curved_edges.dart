import 'package:flutter/material.dart';

class FCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);

    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final lineStart = Offset(0, size.height - 20);
    final lineEnd = Offset(size.width - 30, size.height - 20);

    path.quadraticBezierTo(lineStart.dx, lineStart.dy, lineEnd.dx, lineEnd.dy);

    final secondfirstCurve = Offset(size.width, size.height - 20);
    final secondlastCurve = Offset(size.width, size.height);

    path.quadraticBezierTo(secondfirstCurve.dx, secondfirstCurve.dy,
        secondlastCurve.dx, secondlastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
