import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: const Color(0xFFFF6B00),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFFF6B00),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pengguna MenuPedia',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'user@menupedia.com',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFFFF6B00)),
                title: const Text('Nomor Telepon'),
                subtitle: const Text('+62 812-3456-7890'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_city, color: Color(0xFFFF6B00)),
                title: const Text('Kota Asal'),
                subtitle: const Text('Medan, Indonesia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}