import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

// 1. Mengubah HomeScreen menjadi StatefulWidget agar dapat merespons klik filter
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variabel untuk menyimpan kategori yang aktif (Default: 'Semua')
  String selectedCategory = 'Semua';

  // Daftar 5 Kategori
  final List<String> categories = [
    'Semua',
    'Nusantara',
    'Western',
    'Asian',
    'Healthy',
  ];

  // Data 5 Restoran dengan Kategori Berbeda
  final List<Map<String, String>> restaurants = [
    {
      'name': 'Resto Nusantara Jaya',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp50k',
      'rating': '4.8',
    },
    {
      'name': 'Steak & Grill House',
      'category': 'Western',
      'price': 'Rp50k - Rp150k',
      'rating': '4.7',
    },
    {
      'name': 'Ramen & Sushi Master',
      'category': 'Asian',
      'price': 'Rp30k - Rp90k',
      'rating': '4.9',
    },
    {
      'name': 'Green & Healthy Cafe',
      'category': 'Healthy',
      'price': 'Rp35k - Rp80k',
      'rating': '4.6',
    },
    {
      'name': 'Warung Nasi Padang Sederhana',
      'category': 'Nusantara',
      'price': 'Rp15k - Rp40k',
      'rating': '4.8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Logika menyaring restoran berdasarkan kategori yang dipilih
    final filteredRestaurants = selectedCategory == 'Semua'
        ? restaurants
        : restaurants
            .where((resto) => resto['category'] == selectedCategory)
            .toList();

    return Scaffold(
      // HEADER UTAMA (APP BAR)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi Anda',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 16),
                SizedBox(width: 4),
                Text(
                  'Medan, Indonesia',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Ikon Foto Profil
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFFF6B00),
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 8),

          // Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text(
                      'Apakah Anda yakin ingin keluar dari aplikasi?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Logout',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // KONTEN UTAMA (BODY)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KOLOM INPUT PENCARIAN
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari restoran atau menu...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // BANNER PROMOSI DAN AI
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B00), Color(0xFFFF8E53)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bingung Pilih Menu?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tanya MenuBot untuk rekomendasi sesuai budget-mu!',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Tanya AI'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // DAFTAR KATEGORI KULINER (INTERAKTIF)
            const Text(
              'Kategori Kuliner',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return _buildCategoryChip(category, isSelected);
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // DAFTAR REKOMENDASI RESTORAN (FILTERED)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Rekomendasi Restoran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${filteredRestaurants.length} ditemukan',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Menampilkan daftar restoran sesuai filter
            if (filteredRestaurants.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text('Tidak ada restoran untuk kategori ini.'),
                ),
              )
            else
              Column(
                children: filteredRestaurants.map((resto) {
                  return _buildRestaurantCard(
                    name: resto['name']!,
                    category: '${resto['category']} • ${resto['price']}',
                    rating: resto['rating']!,
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  // WIDGET FILTER CHIP (DENGAN ACTION ONTAP)
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.orange,
        backgroundColor: Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        onSelected: (bool selected) {
          setState(() {
            selectedCategory = label;
          });
        },
      ),
    );
  }

  // WIDGET KARTU RESTORAN
  Widget _buildRestaurantCard({
    required String name,
    required String category,
    required String rating,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Center(
              child: Icon(Icons.store, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(rating,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(category,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}