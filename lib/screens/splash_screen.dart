import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'admin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 3));

    Widget next = const LoginScreen();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final role = await AuthService().loadUserData(user.uid);
        next = role == 'admin' ? const AdminScreen() : const HomeScreen();
      } catch (_) {
        // Gagal ambil data (misal offline) -> tetap ke halaman login
      }
    }

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFF6B00),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 100, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'MenuPedia',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rekomendasi Kuliner Terbaikmu',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}