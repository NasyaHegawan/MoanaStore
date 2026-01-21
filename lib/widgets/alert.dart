import 'dart:ui';
import 'package:flutter/material.dart';

class AlertMessage {
  showAlert(BuildContext context, String message, bool status) {
    Color borderColor = status ? Colors.greenAccent : Colors.redAccent;
    IconData icon = status ? Icons.check_circle : Icons.error_rounded;
    Color iconColor = status ? Colors.greenAccent : Colors.redAccent;

    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),

      content: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.03),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor.withOpacity(0.8),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withOpacity(0.4),
                  blurRadius: 18,
                  spreadRadius: 1,
                )
              ],
            ),

            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 26),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
