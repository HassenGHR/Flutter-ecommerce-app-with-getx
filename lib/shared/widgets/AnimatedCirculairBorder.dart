import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math' as math;

class AnimatedCircularBorderLogo extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;

  const AnimatedCircularBorderLogo({
    Key? key,
    required this.imagePath,
    this.width = 250,
    this.height = 250,
  }) : super(key: key);

  @override
  _AnimatedCircularBorderLogoState createState() =>
      _AnimatedCircularBorderLogoState();
}

class _AnimatedCircularBorderLogoState extends State<AnimatedCircularBorderLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Border
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: CircularBorderPainter(
                  progress: _animation.value,
                  borderColor: Colors.white,
                  borderWidth: 12.0,
                ),
                child: Container(),
              );
            },
          ),

          // Logo
          Center(
            child: ElasticIn(
              duration: const Duration(milliseconds: 1500),
              child: Image.asset(
                widget.imagePath,
                width: 180,
                height: 180,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularBorderPainter extends CustomPainter {
  final double progress;
  final Color borderColor;
  final double borderWidth;

  CircularBorderPainter({
    required this.progress,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = borderColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw full circle border
    canvas.drawCircle(center, radius, paint);

    // Draw animated fill
    final fillPaint = Paint()
      ..color = borderColor.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    // Create an arc that fills from top to bottom based on progress
    final rect = Rect.fromCircle(center: center, radius: radius);
    final startAngle = -math.pi / 2; // Start from top
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(CircularBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
