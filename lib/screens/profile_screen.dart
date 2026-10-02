import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import '../models/user_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFF6B00),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              UserData.name.isEmpty
                  ? 'Nama belum diisi'
                  : UserData.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              UserData.email.isEmpty
                  ? 'Email belum diisi'
                  : UserData.email,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

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
              label: const Text(
                'Edit Profil',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      initialName: UserData.name,
                      initialEmail: UserData.email,
                      initialPhone: UserData.phone,
                      initialCity: UserData.city,
                    ),
                  ),
                );

                if (updatedData != null) {
                  setState(() {
                    UserData.name = updatedData['name'];
                    UserData.email = updatedData['email'];
                    UserData.phone = updatedData['phone'];
                    UserData.city = updatedData['city'];
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
                leading: const Icon(
                  Icons.phone,
                  color: Color(0xFFFF6B00),
                ),
                title: const Text('Nomor Telepon'),
                subtitle: Text(
                  UserData.phone.isEmpty
                      ? 'Belum diisi'
                      : UserData.phone,
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.location_city,
                  color: Color(0xFFFF6B00),
                ),
                title: const Text('Kota Asal'),
                subtitle: Text(
                  UserData.city.isEmpty
                      ? 'Belum diisi'
                      : UserData.city,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}