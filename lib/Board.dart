import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:open_board/widget/drawingBoard.dart';

class OpenBoardScreen extends StatefulWidget {
  @override
  _OpenBoardScreenState createState() => _OpenBoardScreenState();
}

class _OpenBoardScreenState extends State<OpenBoardScreen> {
  double strokeWidth = 5;
  bool isSwitched = false;

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
              top: 13,
              left: 10,
              child: Column(
                children: [
                  FlutterSwitch(
                    // width: 100.0,
                    // height: 55.0,
                    // toggleSize: 45.0,
                    value: isSwitched,
                    borderRadius: 30.0,
                    padding: 2.0,
                    activeToggleColor: Color(0xFF6E40C9),
                    inactiveToggleColor: Color(0xFF2F363D),
                    activeSwitchBorder: Border.all(
                      color: Color(0xFF3C1E70),
                      width: 6.0,
                    ),
                    inactiveSwitchBorder: Border.all(
                      color: Color(0xFFD1D5DA),
                      width: 6.0,
                    ),
                    activeColor: Color(0xFF271052),
                    inactiveColor: Colors.white,
                    activeIcon: Icon(
                      Icons.nightlight_round,
                      color: Color(0xFFF8E3A1),
                    ),
                    inactiveIcon: Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFFDF5D),
                    ),
                    onToggle: (val) {
                      setState(() {
                        isSwitched = val;

                        if (val==true) {
                          AdaptiveTheme.of(context).setDark();
                        } else if(val==false) {
                          AdaptiveTheme.of(context).setLight();
                        }else{
                           AdaptiveTheme.of(context).setSystem();
                        }
                      });
                    },
                  ),
                ],
              ),
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
