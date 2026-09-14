import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? registeredEmail;
  String? registeredPassword;

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
                          if (value.length < 8) {
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

                            if (registeredEmail == null || registeredPassword == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Akun belum terdaftar! Silakan registrasi terlebih dahulu.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (inputEmail != registeredEmail || inputPassword != registeredPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email atau Password salah! Sesuaikan dengan data registrasi.'),
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
                                  registeredEmail = result['email'];
                                  registeredPassword = result['password'];
                                  _emailController.text = registeredEmail!;
                                  _passwordController.text = registeredPassword!;
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