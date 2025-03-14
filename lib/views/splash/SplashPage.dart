import 'dart:math' as math;
import 'package:day59/controllers/auth/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final AuthController _authController = Get.find();
  late AnimationController _loadingController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  final List<ParticleModel> particles = [];
  final math.Random random = math.Random();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateParticles();
    _initializeSettings();
  }

  void _initializeAnimations() {
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _loadingController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _loadingController.repeat(reverse: true);
  }

  void _generateParticles() {
    for (int i = 0; i < 50; i++) {
      particles.add(ParticleModel(random));
    }
  }

  Future<void> _initializeSettings() async {
    await Future.delayed(const Duration(seconds: 3));
    _authController.checkLoginStatus();
    if (_authController.isLoggedIn.value) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          CustomPaint(
            painter: ParticlePainter(particles, _rotationController),
            child: Container(),
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withOpacity(0.8),
                  Colors.purple.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo Container
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: CustomPaint(
                        painter: LogoPainter(_rotationController),
                        child: Container(
                          width: 200,
                          height: 200,
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Animated Text
                ShimmerText(
                  text: 'Oasis Delivery',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                // Loading Indicator
                SizedBox(
                  width: 200,
                  child: LoadingIndicator(controller: _loadingController),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Particle Model and Painter
class ParticleModel {
  late double x;
  late double y;
  late double speed;
  late double theta;

  ParticleModel(math.Random random) {
    x = random.nextDouble() * Get.width;
    y = random.nextDouble() * Get.height;
    speed = 1.0 + random.nextDouble() * 2.0;
    theta = random.nextDouble() * 2 * math.pi;
  }

  void update() {
    x += speed * math.cos(theta);
    y += speed * math.sin(theta);

    if (x < 0 || x > Get.width) theta = math.pi - theta;
    if (y < 0 || y > Get.height) theta = -theta;
  }
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;
  final Animation<double> animation;

  ParticlePainter(this.particles, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 2.0;

    for (var particle in particles) {
      particle.update();
      canvas.drawCircle(Offset(particle.x, particle.y), 2.0, paint);

      // Draw connections between nearby particles
      for (var otherParticle in particles) {
        final distance = math.sqrt(
          math.pow(particle.x - otherParticle.x, 2) +
              math.pow(particle.y - otherParticle.y, 2),
        );

        if (distance < 100) {
          canvas.drawLine(
            Offset(particle.x, particle.y),
            Offset(otherParticle.x, otherParticle.y),
            paint..color = Colors.white.withOpacity(0.05),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

// Logo Painter for geometric effects
class LogoPainter extends CustomPainter {
  final Animation<double> animation;

  LogoPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    for (var i = 0; i < 3; i++) {
      final rotatedAngle = animation.value * 2 * math.pi + (i * math.pi / 1.5);
      canvas.drawCircle(center, radius - (i * 10), paint);

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(rotatedAngle);
      canvas.translate(-center.dx, -center.dy);

      final rect = Rect.fromCenter(
        center: center,
        width: size.width - (i * 20),
        height: size.height - (i * 20),
      );
      canvas.drawRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(LogoPainter oldDelegate) => true;
}

// Shimmer Text Effect
class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShimmerText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Colors.white,
          Colors.white.withOpacity(0.5),
          Colors.white,
        ],
        stops: const [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: const GradientRotation(math.pi / 4),
      ).createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

// Custom Loading Indicator
class LoadingIndicator extends StatelessWidget {
  final AnimationController controller;

  const LoadingIndicator({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LoadingPainter(controller.value),
          child: const SizedBox(height: 4),
        );
      },
    );
  }
}

class LoadingPainter extends CustomPainter {
  final double progress;

  LoadingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final progressPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    final progressPath = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * progress, size.height / 2);

    canvas.drawPath(path, paint);
    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(LoadingPainter oldDelegate) => true;
}
