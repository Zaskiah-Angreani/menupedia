import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'admin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  static const String _adminEmail = 'admin@menupedia.com';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final role = await AuthService().login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
          role == 'admin' ? const AdminScreen() : const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AuthService.errorMessage(e)),
          backgroundColor: Colors.deepOrange,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openRegister() async {
    final result = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );

    if (result != null) {
      setState(() {
        _emailController.text = result['email'] ?? '';
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.restaurant_menu,
                        size: 80,
                        color: Color(0xFFFF6B00),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Masuk ke MenuPedia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Input Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: '@gmail.com',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          // Izinkan email khusus admin
                          if (value.trim() == _adminEmail) {
                            return null;
                          }
                          if (!value.trim().endsWith('@gmail.com')) {
                            return 'Email harus menggunakan @gmail.com';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Input Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (value.length < 8 &&
                              _emailController.text.trim() != _adminEmail) {
                            return 'Password minimal harus 8 karakter/angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Tombol Login
                      ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Navigasi Registrasi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum punya akun?'),
                          TextButton(
                            onPressed: _openRegister,
                            child: const Text(
                              'Daftar Sekarang',
                              style: TextStyle(color: Color(0xFFFF6B00)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}