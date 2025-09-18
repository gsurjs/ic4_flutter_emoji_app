//Robert Stanley
//In-Class 04 - Emoji Drawing App
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatelessWidget {
  const ShapesDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ShapesDemoScreen(),
    );
  }
}

class ShapesDemoScreen extends StatefulWidget {
  const ShapesDemoScreen({super.key});

  @override
  State<ShapesDemoScreen> createState() => _ShapesDemoScreenState();
}

class _ShapesDemoScreenState extends State<ShapesDemoScreen> {
  String selectedEmoji = 'Smiley Face';
  
  final List<String> emojiOptions = [
    'Smiley Face',
    'Party Face',
    'Heart'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes Drawing Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task 1: Basic Shapes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: BasicShapesPainter(),
                size: const Size(double.infinity, 200),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Task 2: Combined Shapes (Abstract Design)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: CombinedShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Task 3: Styled Shapes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: CustomPaint(
                painter: StyledShapesPainter(),
                size: const Size(double.infinity, 300),
              ),
            ),
            const SizedBox(height: 20),
            // Added emoji selection section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pink],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Select Emoji: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedEmoji,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      items: emojiOptions.map((String emoji) {
                        return DropdownMenuItem<String>(
                          value: emoji,
                          child: Text(emoji),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedEmoji = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Task 4: Interactive Emoji Drawing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 400,
              child: CustomPaint(
                painter: EmojiPainter(selectedEmoji),
                size: const Size(double.infinity, 400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Determine the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX + 160, centerY);

    // Draw a square
    final squarePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );

    // Draw a circle
    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circleOffset, 30, circlePaint);

    // Draw an arc
    final arcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      0, // start angle in radians
      2.1, // sweep angle in radians (about 120 degrees)
      false, // whether to use center
      arcPaint,
    );

    // Draw a rectangle
    final rectPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: rectOffset, width: 80, height: 40),
      rectPaint,
    );

    // Draw a line
    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);

    // Draw an oval
    final ovalPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Background gradient
    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.blue.shade100, Colors.white],
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = backgroundGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Draw a sun (circle with rays)
    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY - 40), 40, sunPaint);

    // Sun rays (lines)
    final rayPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4); // Use pi from dart:math
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(
        Offset(centerX, centerY - 40),
        Offset(centerX + dx, centerY - 40 + dy),
        rayPaint,
      );
    }

    // Draw a house (square with triangle roof)
    final housePaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 40), width: 80, height: 80),
      housePaint,
    );

    final roofPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, roofPaint);

    // Draw a door (rectangle)
    final doorPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX, centerY + 60), width: 30, height: 50),
      doorPaint,
    );

    // Draw windows (squares)
    final windowPaint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX - 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(centerX + 25, centerY + 20), width: 20, height: 20),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw a gradient-filled rectangle
    final rectGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, Colors.blue],
    );

    final rect = Rect.fromCenter(center: Offset(centerX, centerY - 100), width: 200, height: 60);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = rectGradient.createShader(rect)
        ..style = PaintingStyle.fill,
    );

    // Draw a circle with a border
    final circlePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final circleBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circlePaint);
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circleBorderPaint);

    // Draw a transparent oval
    final ovalPaint = Paint()
      ..color = Colors.purple.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX + 80, centerY), width: 100, height: 60),
      ovalPaint,
    );

    // Draw a dashed line using a custom path effect
    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // We draw a series of short lines and spaces
    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);

    // Draw a gradient arc
    final arcGradient = SweepGradient(
      center: Alignment.centerRight,
      startAngle: 0,
      endAngle: pi, // Use pi from dart:math
      colors: [Colors.red, Colors.yellow, Colors.green],
    );

    final arcRect = Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 120, height: 120);

    final arcPaint = Paint()
      ..shader = arcGradient.createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(center: Offset(centerX, centerY + 100), width: 100, height: 100),
      0, // start angle
      2.5, // sweep angle
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// Added new EmojiPainter class for the assignment requirements
class EmojiPainter extends CustomPainter {
  final String emojiType;

  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    switch (emojiType) {
      case 'Smiley Face':
        drawSmileyFace(canvas, Offset(centerX, centerY));
        break;
      case 'Party Face':
        drawPartyFace(canvas, Offset(centerX, centerY));
        break;
      case 'Heart':
        drawHeart(canvas, Offset(centerX, centerY));
        break;
    }
  }

  void drawSmileyFace(Canvas canvas, Offset center) {
    // Draw the face
    final facePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 80, facePaint);

    // Face border
    final borderPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, 80, borderPaint);

    // Fill the left eye
    final leftEyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx - 25, center.dy - 20), 8, leftEyePaint);

    // Fill the right eye
    final rightEyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx + 25, center.dy - 20), 8, rightEyePaint);

    // Draw the smile (this is an arc)
    final smilePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(center.dx, center.dy + 10), width: 60, height: 40),
      0,
      pi,
      false,
      smilePaint,
    );
  }

  void drawPartyFace(Canvas canvas, Offset center) {
    // Draw the face
    final facePaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 80, facePaint);

    // Party hat (triangle)
    final hatPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;
    final hatPath = Path()
      ..moveTo(center.dx - 30, center.dy - 70)
      ..lineTo(center.dx + 30, center.dy - 70)
      ..lineTo(center.dx, center.dy - 120)
      ..close();
    canvas.drawPath(hatPath, hatPaint);

    // Hat pom-pom
    final pomPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx, center.dy - 120), 8, pomPaint);

    // Eyes (excited)
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    // Left eye
    final leftEyePath = Path()
      ..moveTo(center.dx - 35, center.dy - 20)
      ..quadraticBezierTo(center.dx - 25, center.dy - 30, center.dx - 15, center.dy - 20);
    canvas.drawPath(leftEyePath, eyePaint);

    // Right eye
    final rightEyePath = Path()
      ..moveTo(center.dx + 15, center.dy - 20)
      ..quadraticBezierTo(center.dx + 25, center.dy - 30, center.dx + 35, center.dy - 20);
    canvas.drawPath(rightEyePath, eyePaint);

    // Big smile
    final smilePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(center.dx, center.dy + 15), width: 70, height: 50),
      0,
      pi,
      false,
      smilePaint,
    );

    // Confetti (different colors and shapes)
    final confettiColors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.pink];
    final confettiPaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < 15; i++) {
      confettiPaint.color = confettiColors[i % confettiColors.length];
      final angle = (i * 2 * pi) / 15;
      final radius = 120 + (i % 3) * 15;
      final confettiX = center.dx + cos(angle) * radius;
      final confettiY = center.dy + sin(angle) * radius;
      
      if (i % 3 == 0) {
        canvas.drawCircle(Offset(confettiX, confettiY), 4, confettiPaint);
      } else {
        canvas.drawRect(
          Rect.fromCenter(center: Offset(confettiX, confettiY), width: 6, height: 6),
          confettiPaint,
        );
      }
    }
  }

  void drawHeart(Canvas canvas, Offset center) {
    // Heart shape using gradient
    final heartGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.red.shade300, Colors.red.shade700],
    );
    
    final heartPath = Path();
    final heartWidth = 120.0;
    final heartHeight = 100.0;
    
    heartPath.moveTo(center.dx, center.dy + heartHeight * 0.3);
    
    // Left curve
    heartPath.cubicTo(
      center.dx - heartWidth * 0.5, center.dy - heartHeight * 0.1,
      center.dx - heartWidth * 0.5, center.dy - heartHeight * 0.5,
      center.dx - heartWidth * 0.2, center.dy - heartHeight * 0.5
    );
    
    // Top left arc
    heartPath.cubicTo(
      center.dx - heartWidth * 0.1, center.dy - heartHeight * 0.6,
      center.dx + heartWidth * 0.1, center.dy - heartHeight * 0.6,
      center.dx + heartWidth * 0.2, center.dy - heartHeight * 0.5
    );
    
    // Right curve
    heartPath.cubicTo(
      center.dx + heartWidth * 0.5, center.dy - heartHeight * 0.5,
      center.dx + heartWidth * 0.5, center.dy - heartHeight * 0.1,
      center.dx, center.dy + heartHeight * 0.3
    );
    
    heartPath.close();
    
    final heartRect = Rect.fromCenter(center: center, width: heartWidth, height: heartHeight);
    final heartPaint = Paint()
      ..shader = heartGradient.createShader(heartRect)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(heartPath, heartPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}