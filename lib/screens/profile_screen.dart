import 'package:flutter/material.dart';
import 'edit_profile_screen.dart'; // Import halaman edit profil

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State data profil default
  String _name = 'Alya Defira';
  String _email = 'user@menupedia.com';
  String _phone = '+62 812-3456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: const Color(0xFFFF6B00),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
            Text(
              _name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              _email,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // TOMBOL EDIT PROFIL (Menambah layar fungsional ke-8/9)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B00),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profil', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () async {
                // Membuka EditProfileScreen dan menunggu data kembaliannya
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      initialName: _name,
                      initialEmail: _email,
                      initialPhone: _phone,
                    ),
                  ),
                );

                // Jika data berhasil diubah dan disimpan
                if (updatedData != null) {
                  setState(() {
                    _name = updatedData['name'];
                    _email = updatedData['email'];
                    _phone = updatedData['phone'];
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profil berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFFFF6B00)),
                title: const Text('Nomor Telepon'),
                subtitle: Text(_phone),
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