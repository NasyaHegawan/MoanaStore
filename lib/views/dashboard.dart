import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/models/user_login.dart';
import 'package:toko_onlie_postman/widgets/bottom_nav.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  UserLogin userLogin = UserLogin();
  String? nama;
  String? role;

  getUserLogin() async {
    var user = await userLogin.getUserLogin();
    if (user.status != false) {
      setState(() {
        nama = user.nama_user;
        role = user.role;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedOceanBackground(),

          SafeArea(
            child: Column(
              children: [
                topBar(),

                const SizedBox(height: 26),

                welcomeCard(),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child: infoCard(Icons.person, "Profile")),
                      const SizedBox(width: 14),
                      Expanded(child: infoCard(Icons.shopping_bag, "Orders")),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child: infoCard(Icons.settings, "Settings")),
                      const SizedBox(width: 14),
                      Expanded(child: infoCard(Icons.support_agent, "Support")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(0),
    );
  }

  // ================= TOP BAR =================

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Moana Store",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ================= WELCOME CARD =================

  Widget welcomeCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                "Welcome, ${nama ?? 'Sailor'} 🌊",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Role: ${role ?? '-'}",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= MINI GLASS CARD =================

  Widget infoCard(IconData icon, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: const Color.fromARGB(255, 5, 60, 86),
                size: 32,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================== ANIMATED OCEAN BACKGROUND ===================

class AnimatedOceanBackground extends StatefulWidget {
  const AnimatedOceanBackground({super.key});

  @override
  State<AnimatedOceanBackground> createState() =>
      _AnimatedOceanBackgroundState();
}

class _AnimatedOceanBackgroundState extends State<AnimatedOceanBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (_, __) {
        return CustomPaint(
          size: Size.infinite,
          painter: OceanWavePainter(_waveController.value),
        );
      },
    );
  }
}

class OceanWavePainter extends CustomPainter {
  final double animationValue;
  OceanWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF020617), Color(0xFF0284C7), Color(0xFF06B6D4)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    drawWave(canvas, size, 0.0, 0.25, 20, 0.5);
    drawWave(canvas, size, pi / 2, 0.35, 25, 0.35);
    drawWave(canvas, size, pi, 0.45, 30, 0.2);
  }

  void drawWave(
    Canvas canvas,
    Size size,
    double phase,
    double heightFactor,
    double amplitude,
    double opacity,
  ) {
    final path = Path();
    final yBase = size.height * heightFactor;
    final wavePaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      double y =
          yBase +
          sin((x / size.width * 2 * pi) + animationValue * 2 * pi + phase) *
              amplitude;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant OceanWavePainter oldDelegate) => true;
}
