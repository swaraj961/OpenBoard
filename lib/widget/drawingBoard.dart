import 'dart:ui';

import 'package:flutter/material.dart';

class DrawingBoardPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;
    List<Offset> offsetsList = [];

  DrawingBoardPainter(this.drawingPoints);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i].offset, drawingPoints[i + 1].offset,
            drawingPoints[i].paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        offsetsList.clear();
        offsetsList.add(drawingPoints[i].offset);

        canvas.drawPoints(
            PointMode.points, offsetsList, drawingPoints[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingBoardPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset offset;
  Paint paint;
  DrawingPoint({this.offset, this.paint});
}