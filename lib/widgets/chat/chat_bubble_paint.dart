import 'package:flutter/material.dart';

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final bool leftBubble;
  final bool senderOfNextIsTheSame;

  const ChatBubblePainter({
    required this.color,
    required this.leftBubble,
    required this.senderOfNextIsTheSame,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var margin = 15.0;
    var padding = 8.0;
    var center = Offset(
      (size.width / 2) + (leftBubble ? padding : -padding),
      size.height / 2,
    );

    var roundedRectangle = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: size.width,
        height: size.height,
      ),
      const Radius.circular(16.0),
    );
    var tips = <Offset>[];

    if (leftBubble) {
      tips.addAll([
        Offset(0, size.height),
        Offset(size.width / 2, size.height),
        Offset(margin, (size.height - margin)),
      ]);
    } else {
      tips.addAll([
        Offset(size.width, size.height),
        Offset(size.width / 2, size.height),
        Offset(size.width - margin, (size.height - margin)),
      ]);
    }

    var path = Path()..addRRect(roundedRectangle);

    if (!senderOfNextIsTheSame) {
      path.addPolygon(tips, true);
      path.addPolygon(tips, true);
    }

    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawShadow(path, Colors.black45, 2, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      senderOfNextIsTheSame == true;
}
