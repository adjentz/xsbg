import 'dart:async';
import 'dart:math';
import 'package:dartx/dartx.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:xsbg/models/draw_settings.dart';
import 'package:xsbg/models/battle_stroke.dart';
import 'package:xsbg/state/battle_grid_state.dart';

class GridDrawings extends StatefulWidget {
  final DrawSettings drawSettings;
  final bool erasing;

  GridDrawings({this.drawSettings, this.erasing = false});

  @override
  State<StatefulWidget> createState() => _GridDrawingsState();
}

class _GridDrawingsState extends State<GridDrawings> {
  List<BattleStroke> strokes = [];
  BattleStroke currentStroke;
  int tick = 0;

  void _updateTick(Timer _timer) {
    final temporaryStrokes = strokes.where((element) => element.temporary);
    if (temporaryStrokes.isEmpty) {
      return;
    }

    setState(() {
      tick++;
    });

    final expiredStrokes = temporaryStrokes.where((element) =>
        DateTime.now().difference(element.timestamp).inSeconds > 5);
    if (expiredStrokes.isEmpty) {
      return;
    }
    context.read<BattleGridState>().removeStrokeRange(expiredStrokes);
  }

  @override
  initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), _updateTick);
  }

  Point<double> _drawSnapped(DragUpdateDetails details) {
    final squareSize = 100;
    final gridXIndex = (details.localPosition.dx / squareSize).round();
    final gridYIndex = (details.localPosition.dy / squareSize).round();
    final x = gridXIndex * squareSize;
    final y = gridYIndex * squareSize;

    return Point(x.toDouble(), y.toDouble());
  }

  Point<double> _drawFree(DragUpdateDetails details) {
    final x = details.localPosition.dx;
    final y = details.localPosition.dy;

    return Point(x.toDouble(), y.toDouble());
  }

  void _draw(DragUpdateDetails details) {
    if (currentStroke == null) {
      return;
    }

    final newPoint = widget.drawSettings.gridSnap
        ? _drawSnapped(details)
        : _drawFree(details);

    final isDifferent = currentStroke.points.isNotEmpty &&
        newPoint != currentStroke.points.last;

    final shouldAddPoint = currentStroke.points.isEmpty || isDifferent;
    if (!shouldAddPoint) {
      return;
    }

    setState(() {
      if (currentStroke == null) {
        return;
      }
      currentStroke.points.add(newPoint);
    });
  }

  void _erase(DragUpdateDetails details) {
    final givenPoint =
        Point(details.localPosition.dx, details.localPosition.dy);
    final threshold = 75;
    final closeStrokes = strokes
        .where((stroke) => stroke.points.any((point) {
              final distance = point.distanceTo(givenPoint);
              return distance < threshold;
            }))
        .toList();

    if (closeStrokes.isEmpty) {
      return;
    }
    context.read<BattleGridState>().removeStrokeRange(closeStrokes);
  }

  void _spotTapped(TapUpDetails details) {
    if (widget.erasing) {
      return;
    }

    final squareSize = 100;
    final gridXIndex = (details.localPosition.dx / squareSize).floor();
    final gridYIndex = (details.localPosition.dy / squareSize).floor();

    final normalizedInSquareX =
        (details.localPosition.dx - (gridXIndex * squareSize)) / squareSize;
    final normalizedInSquareY =
        (details.localPosition.dy - (gridYIndex * squareSize)) / squareSize;

    final closeToVerticalLine =
        normalizedInSquareX <= 0.25 || normalizedInSquareX >= 0.75;
    final closeToHorizontalLine =
        normalizedInSquareY <= 0.25 || normalizedInSquareY >= 0.75;

    final closeToLine = closeToVerticalLine || closeToHorizontalLine;
    if (!closeToLine) {
      return;
    }

    final distanceToLeft = normalizedInSquareX;
    final distanceToRight = 1.0 - normalizedInSquareX;
    final distanceToTop = normalizedInSquareY;
    final distanceToBottom = 1.0 - normalizedInSquareY;

    final distances = [
      distanceToLeft,
      distanceToRight,
      distanceToTop,
      distanceToBottom
    ];
    final smallestDistance = distances.min();
    final smallestIndex = distances.indexOf(smallestDistance);

    final stroke = BattleStroke()
      ..color = widget.drawSettings.colorHex
      ..width = widget.drawSettings.strokeWidth
      ..timestamp = DateTime.now();

    switch (smallestIndex) {
      case 0:
        final x = gridXIndex * squareSize;
        final topY = gridYIndex * squareSize;
        final bottomY = topY + squareSize;

        stroke.points = [
          Point<double>(x.toDouble(), topY.toDouble()),
          Point<double>(x.toDouble(), bottomY.toDouble()),
        ];
        break;
      case 1:
        final x = gridXIndex * squareSize + squareSize;
        final topY = gridYIndex * squareSize;
        final bottomY = topY + squareSize;
        stroke.points = [
          Point<double>(x.toDouble(), topY.toDouble()),
          Point<double>(x.toDouble(), bottomY.toDouble()),
        ];
        break;
      case 2:
        final leftX = gridXIndex * squareSize;
        final rightX = leftX + squareSize;
        final topY = gridYIndex * squareSize;

        stroke.points = [
          Point<double>(leftX.toDouble(), topY.toDouble()),
          Point<double>(rightX.toDouble(), topY.toDouble()),
        ];
        break;
      case 3:
        final leftX = gridXIndex * squareSize;
        final rightX = leftX + squareSize;
        final topY = gridYIndex * squareSize;
        final bottomY = topY + squareSize;

        stroke.points = [
          Point<double>(leftX.toDouble(), bottomY.toDouble()),
          Point<double>(rightX.toDouble(), bottomY.toDouble()),
        ];
        break;
      default:
        return;
    }
    context.read<BattleGridState>().addStroke(stroke);
  }

  BattleStroke _strokeForSettings() {
    return BattleStroke()
      ..color = widget.drawSettings.colorHex
      ..width = widget.drawSettings.strokeWidth
      ..temporary = widget.drawSettings.temporary
      ..timestamp = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    strokes = context.select((BattleGridState value) => value?.strokes);
    if (strokes == null) {
      return Text('Connecting...');
    }
    final size = MediaQuery.of(context).size;
    final paint = CustomPaint(
      willChange: true,
      size: size,
      painter: _PathPainter([
        ...strokes,
        if (currentStroke != null) currentStroke,
      ], tick),
    );

    return GestureDetector(
      child: paint,
      onTapUp: _spotTapped,
      onPanStart: (_) {
        setState(() {
          currentStroke = _strokeForSettings();
        });
      },
      onPanUpdate: (details) {
        if (widget.erasing) {
          _erase(details);
          return;
        }

        _draw(details);
      },
      onPanEnd: (DragEndDetails details) {
        if (currentStroke == null || currentStroke.points.isEmpty) {
          return;
        }

        context.read<BattleGridState>().addStroke(currentStroke);
        setState(() {
          currentStroke = null;
        });
      },
    );
  }
}

class _PathPainter extends CustomPainter {
  final Iterable<BattleStroke> strokes;
  final int ticks;
  _PathPainter(this.strokes, this.ticks);

  @override
  void paint(Canvas canvas, Size size) {
    if (strokes.isEmpty) {
      return;
    }

    strokes
        .whereType<BattleStroke>()
        .sortedBy((element) => element.timestamp)
        .forEach((element) => _drawStroke(element, canvas));
  }

  double _calculateOpacity(BattleStroke stroke) {
    final deltaTime = DateTime.now().difference(stroke.timestamp);

    final fullyTransparent = 5000; // milliseconds until fully transparent.

    final opacity = (deltaTime.inMilliseconds / fullyTransparent).clamp(0, 1.0);
    return 1.0 - opacity;
  }

  void _drawStroke(BattleStroke stroke, Canvas canvas) {
    if (stroke.points.length < 2) {
      return;
    }
    final path = Path()..moveTo(stroke.points.first.x, stroke.points.first.y);

    for (var point in stroke.points.skip(1)) {
      path.lineTo(point.x, point.y);
    }

    final opacity = stroke.temporary ? _calculateOpacity(stroke) : 1.0;

    final paint = Paint()
      ..color = Color(stroke.color).withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke.width.toDouble();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
