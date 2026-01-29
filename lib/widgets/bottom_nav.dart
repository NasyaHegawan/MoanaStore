import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/models/user_login.dart';

class BottomNav extends StatefulWidget {
  int activePage;
  BottomNav(this.activePage);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  UserLogin userLogin = UserLogin();
  String? role;
  getDataLogin() async {
    var user = await userLogin!.getUserLogin();
    if (user!.status != false) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataLogin();
  }

  void getLink(index) {
    if (role == "admin") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/produk');
      }
    } else if (role == "kasir") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/transaksi');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role == null) return const SizedBox();

    List<BottomNavigationBarItem> items = role == "admin"
        ? const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_copy),
              label: 'Produk',
            ),
          ]
        : const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard),
              label: 'Transaksi',
            ),
          ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(22),
        topRight: Radius.circular(22),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.25)),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: widget.activePage,
            onTap: (index) => getLink(index),
            selectedItemColor: const Color.fromARGB(255, 5, 60, 86),
            unselectedItemColor: const Color(0xFF06B6D4),
            items: items,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
