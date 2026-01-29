import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/views/dashboard.dart';
import 'package:toko_onlie_postman/widgets/bottom_nav.dart';

/// ================= MODEL PRODUK =================
class Product {
  final String name;
  final String price;
  final String image;
  final String location;
  final String estimate;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.location,
    required this.estimate,
  });
}

class ProdukView extends StatefulWidget {
  const ProdukView({super.key});

  @override
  State<ProdukView> createState() => _ProdukViewState();
}

class _ProdukViewState extends State<ProdukView> {
  /// ================= DATA PRODUK =================
  final List<Product> products = [
    Product(
      name: "Toys Kingdom Disney Princess Boneka Moana 2 Simea",
      price: "Rp289.900",
      image: "assets/bonekamoana.png",
      location: "Kota Bandung",
      estimate: "2-4 Hari",
    ),
    Product(
      name: "Sea Salt Series Drift Bottle Key Chain Handmade",
      price: "Rp21.199",
      image: "assets/keychain.png",
      location: "Kab. Tangerang",
      estimate: "< 2 Hari",
    ),
    Product(
      name: "Loungefly Disney Moana Ocean Wave Handle Crossbody",
      price: "Rp1.279.000",
      image: "assets/bag.png",
      location: "Kab. Tangerang",
      estimate: "2-3 Hari",
    ),
    Product(
      name: "LEGO Disney 43270 Moana's Adventure Canoe",
      price: "Rp1.133.670",
      image: "assets/lego.png",
      location: "Kota Jakarta Utara",
      estimate: "3-4 Hari",
    ),
    Product(
      name: "Gramedia Depok - Laut Bercerita Karya Leila Chudori",
      price: "Rp97.750",
      image: "assets/novel.png",
      location: "Kota Depok",
      estimate: "< 3 Hari",
    ),
    Product(
      name: "Smiggle Bracelet Moana with Charms Embrace Adventure",
      price: "Rp335.400",
      image: "assets/gelang.png",
      location: "Kota Jakarta Selatan",
      estimate: "3-4 Hari",
    ),
    Product(
      name: "Sea Turtle Snow Globe Ever Greater Store",
      price: "Rp247.900",
      image: "assets/snowglobe.png",
      location: "Singapore",
      estimate: "> 7 Hari",
    ),
    Product(
      name: "Smiggle Keyring Moana Ocean Vibes Disney",
      price: "Rp159.200",
      image: "assets/keychain2.png",
      location: "Kota Jakarta Selatan",
      estimate: "3-4 Hari",
    ),
  ];

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
                const SizedBox(height: 20),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        return productCard(products[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }

  /// ================= TOP BAR =================
  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Moana Products 🌊",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Icon(Icons.shopping_cart, color: Colors.white),
        ],
      ),
    );
  }

  /// ================= PRODUCT CARD =================
  Widget productCard(Product product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= IMAGE + BADGE =================
              Stack(
                children: [
                  Container(
                    height: 194,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      image: DecorationImage(
                        image: AssetImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: badge("Mall", Colors.redAccent),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: badge("-20%", Colors.orange),
                  ),
                ],
              ),

              /// ================= PRODUCT INFO =================
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      product.price,
                      style: const TextStyle(
                        color: Color(0xFF06B6D4),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 12, color: Colors.white70),
                        const SizedBox(width: 4),
                        Text(
                          product.location,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.local_shipping,
                            size: 12, color: Colors.white70),
                        const SizedBox(width: 4),
                        Text(
                          product.estimate,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= BADGE =================
  Widget badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
}

/// ================== ANIMATED OCEAN BACKGROUND ===================

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

  void drawWave(Canvas canvas, Size size, double phase, double heightFactor,
      double amplitude, double opacity) {
    final path = Path();
    final yBase = size.height * heightFactor;
    final wavePaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      double y = yBase +
          sin((x / size.width * 2 * pi) +
                  animationValue * 2 * pi +
                  phase) *
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
