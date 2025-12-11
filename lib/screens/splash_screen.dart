import 'dart:async';
import 'package:ev_assist/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), _goToHome);
  }

  void _goToHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final image = isDark
        ? 'assets/welcome_dark.png'
        : 'assets/welcome_bright.png';

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A) // Matches Dark background
          : const Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
