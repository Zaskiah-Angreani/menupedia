import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'admin_screen.dart'; // Tambahan import halaman admin
import '../models/user_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                          if (value.trim() == 'admin@menupedia.com') {
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
                          if (value.length < 8 && _emailController.text.trim() != 'admin@menupedia.com') {
                            return 'Password minimal harus 8 karakter/angka';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Tombol Login
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final inputEmail = _emailController.text.trim();
                            final inputPassword = _passwordController.text;

                            // 1. CEK LOGIN ADMIN KHUSUS
                            if (inputEmail == 'admin@menupedia.com' && inputPassword == 'admin123') {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const AdminScreen(),
                                ),
                              );
                            } 
                            // 2. CEK USER BIASA BERDASARKAN UserData
                            else if (UserData.email.isEmpty || UserData.password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Akun belum terdaftar! Silakan registrasi terlebih dahulu.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (
                              inputEmail != UserData.email ||
                              inputPassword != UserData.password
                            ) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email atau Password salah! Sesuaikan dengan data registrasi.',
                                  ),
                                  backgroundColor: Colors.deepOrange,
                                ),
                              );
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
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
                            onPressed: () async {
                              final result = await Navigator.of(context).push<Map<String, String>>(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  UserData.name = result['name'] ?? '';
                                  UserData.email = result['email'] ?? '';
                                  UserData.password = result['password'] ?? '';

                                  _emailController.text = UserData.email;
                                  _passwordController.text = UserData.password;
                                });
                              }
                            },
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