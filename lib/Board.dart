import 'package:flutter/material.dart';

class OpenBoardScreen extends StatefulWidget {
  @override
  _OpenBoardScreenState createState() => _OpenBoardScreenState();
}

class _OpenBoardScreenState extends State<OpenBoardScreen> {


  Color selectedColor = Colors.black;
  List<Color> allColorsList = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.pink,
    Colors.blue,
    Colors.orange,
    Colors.deepPurple,
  ];

  List<DrawingPoint> drawingPoints =[


  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomPaint(
        painter:  DrawingBoardPainter(),
        child: Container(
          height: size.height,
          width: size.width
        )
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
      onPanStart: (details){
        drawingPoints.add(DrawingPoint(offset: details.localPosition, paint: Paint()));
      },
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
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


class DrawingBoardPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(DrawingBoardPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(DrawingBoardPainter oldDelegate) => true;
}


class DrawingPoint {
  Offset offset;
  Paint paint;
  DrawingPoint({
    this.offset, this.paint
  });
  
}