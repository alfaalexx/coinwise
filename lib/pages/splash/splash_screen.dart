import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({required this.onInitializationComplete});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Misalnya, timer 3 detik sebelum memanggil onInitializationComplete
    Timer(const Duration(seconds: 3), widget.onInitializationComplete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan gambar logo atau asset splash screen Anda dengan border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  20.0), // Sesuaikan nilai border radius sesuai kebutuhan
              child: Image.asset(
                'assets/images/logo_coinwise.png', // Sesuaikan dengan path dan nama file gambar logo Anda
                width: 100.0, // Sesuaikan ukuran gambar sesuai kebutuhan
                height: 100.0,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF023E8A)),
            ),
          ],
        ),
      ),
    );
  }
}
