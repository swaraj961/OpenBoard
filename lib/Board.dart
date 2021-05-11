import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_board/widget/drawingBoard.dart';

class OpenBoardScreen extends StatefulWidget {
  @override
  _OpenBoardScreenState createState() => _OpenBoardScreenState();
}

class _OpenBoardScreenState extends State<OpenBoardScreen> {
  double strokeWidth = 5;

  Color selectedColor = Colors.black;
  List<Color> allColorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.pink,
    Colors.blue,
  ];

  List<DrawingPoint> drawingPoints = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  drawingPoints.add(DrawingPoint(
                      offset: details.localPosition,
                      paint: Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round
                        ..strokeWidth = strokeWidth));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  drawingPoints.add(DrawingPoint(
                      offset: details.localPosition,
                      paint: Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeCap = StrokeCap.round
                        ..strokeWidth = strokeWidth));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  drawingPoints.add(null);
                });
              },
              child: CustomPaint(
                  painter: DrawingBoardPainter(drawingPoints),
                  child: Container(height: size.height, width: size.width)),
            ),
            Positioned(
                top: 40,
                right: 30,
                child: Row(
                  children: [
                    Slider(
                        min: 0,
                        max: 40,
                        value: strokeWidth,
                        onChanged: (value) {
                          setState(() {
                            strokeWidth = value;
                          });
                        }),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          drawingPoints = [];
                        });
                      },
                      icon: Icon(Icons.clear),
                      label: Text("Clear Board"),
                    )
                  ],
                ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[350],
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(allColorsList.length,
                  (index) => buildColorsContainer(allColorsList[index]))),
        ));
  }

  Widget buildColorsContainer(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        height: isSelected ? 50 : 40,
        width: isSelected ? 50 : 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border:
                isSelected ? Border.all(color: Colors.white, width: 5) : null),
      ),
    );
  }
}
