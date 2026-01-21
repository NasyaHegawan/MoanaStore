import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/services/user.dart';
import 'package:toko_onlie_postman/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView>
    with SingleTickerProviderStateMixin {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List roleChoice = ["admin", "kasir"];
  String? role;

  bool isObscure = true;
  double passwordStrength = 0;

  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedOceanBackground(),

          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(position: _slideAnim, child: glassCard()),
            ),
          ),
        ],
      ),
    );
  }

  Widget glassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Moana Store",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 5, 60, 86),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Join the ocean of shopping 🌊",
                  style: TextStyle(color: Color.fromARGB(255, 5, 60, 86)),
                ),
                const SizedBox(height: 24),

                glassField(
                  controller: name,
                  hint: "Nama Lengkap",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),

                glassField(
                  controller: email,
                  hint: "Email",
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 14),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tipe Akun",
                    style: TextStyle(
                      color: Color.fromARGB(255, 5, 60, 86),
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  children: roleChoice.map((r) {
                    bool selected = role == r;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => role = r),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color.fromARGB(
                                        255,
                                        5,
                                        60,
                                        86,
                                      ).withOpacity(0.35)
                                    : const Color.fromARGB(
                                        255,
                                        5,
                                        60,
                                        86,
                                      ).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selected
                                      ? const Color.fromARGB(255, 5, 60, 86)
                                      : const Color.fromARGB(
                                          255,
                                          5,
                                          60,
                                          86,
                                        ).withOpacity(0.4),
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  r == "admin" ? "Admin Toko" : "Kasir",
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : const Color.fromARGB(255, 5, 60, 86),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 14),

                glassField(
                  controller: password,
                  hint: "Password",
                  icon: Icons.lock_outline,
                  obscure: isObscure,
                  suffix: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: const Color.fromARGB(255, 5, 60, 86),
                    ),
                    onPressed: () => setState(() => isObscure = !isObscure),
                  ),
                ),

                const SizedBox(height: 8),

                LinearProgressIndicator(
                  value: passwordStrength,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation(
                    passwordStrength < 0.4
                        ? Color.fromARGB(255, 82, 212, 255)
                        : passwordStrength < 0.7
                        ? const Color.fromARGB(255, 9, 48, 222)
                        : Colors.greenAccent,
                  ),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 5, 60, 86),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate() && role != null) {
                        var data = {
                          "name": name.text,
                          "email": email.text,
                          "role": role,
                          "password": password.text,
                        };

                        var result = await user.registerUser(data);

                        AlertMessage().showAlert(
                          context,
                          result.message,
                          result.status,
                        );
                      }
                    },
                    child: const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget glassField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 5, 60, 86).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color.fromARGB(255, 5, 60, 86).withOpacity(0.45),
              width: 1.2,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            validator: (v) => v!.isEmpty ? "$hint wajib diisi" : null,
            onChanged: hint == "Password"
                ? (v) {
                    setState(() {
                      passwordStrength = v.length / 12;
                      if (passwordStrength > 1) passwordStrength = 1;
                    });
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: Icon(
                icon,
                color: const Color.fromARGB(255, 5, 60, 86),
              ),
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
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
