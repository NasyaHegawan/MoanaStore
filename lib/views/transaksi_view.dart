import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/widgets/bottom_nav.dart';
import 'package:toko_onlie_postman/views/dashboard.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  // ================= DATA TRANSAKSI (BEBAS KAMU UBAH) =================
  final List<Map<String, dynamic>> transaksiList = [
    {
      "toko": "Disney Official Store",
      "badge": "Star+",
      "status": "Selesai",
      "foto": "assets/bonekamoana.png",
      "produk": "Toys Kingdom Disney Princess Boneka Moana 2 Simea",
      "varian": "Princess Moana",
      "qty": 2,
      "harga": "Rp289.900",
      "total": "Rp579.800",
    },
    {
      "toko": "Gramedia Kota Depok",
      "badge": "Star+",
      "status": "Selesai",
      "foto": "assets/novel.png",
      "produk": "Laut Bercerita Karya Leila Chudori",
      "varian": "Soft Cover",
      "qty": 65,
      "harga": "Rp97.750",
      "total": "Rp6.353.750",
    },
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
                const SizedBox(height: 12),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: transaksiList.length,
                      itemBuilder: (context, index) {
                        final data = transaksiList[index];
                        return transaksiCard(data);
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

  // ================= TOP BAR =================
  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Moana Transactions 🌊",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.receipt_long, color: Colors.white),
        ],
      ),
    );
  }

  // ================= TRANSAKSI CARD =================
  Widget transaksiCard(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white.withOpacity(0.12),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== TOKO & STATUS =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            data["badge"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          data["toko"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data["status"],
                      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ===== PRODUK =====
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FOTO
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(data["foto"], fit: BoxFit.cover),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // INFO PRODUK (KIRI)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["produk"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            data["varian"],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // INFO KANAN (QTY + HARGA)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "x${data["qty"]}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data["harga"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ===== TOTAL =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Produk:",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      data["total"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ===== BUTTON =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    outlinedButton("Lihat Penilaian"),
                    const SizedBox(width: 8),
                    filledButton("Beli Lagi"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= BUTTONS =================
  Widget outlinedButton(String text) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white60),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }

  Widget filledButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF06B6D4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}
