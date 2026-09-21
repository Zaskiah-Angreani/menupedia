import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'detail_restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller untuk membaca input pada Search Bar
  final TextEditingController _searchController = TextEditingController();

  // Variabel untuk menampung query pencarian dan kategori yang aktif
  String searchQuery = '';
  String selectedCategory = 'Semua';

  // Daftar 5 Kategori Kuliner
  final List<String> categories = [
    'Semua',
    'Nusantara',
    'Western',
    'Asian',
    'Healthy',
  ];

  // Data 5 Restoran beserta Daftar Menu Spesifik (Map<String, dynamic>)
  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Resto Nusantara Jaya',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp50k',
      'rating': '4.8',
      'menus': [
        {'name': 'Nasi Goreng Spesial', 'price': 25000},
        {'name': 'Ayam Bakar Madu', 'price': 30000},
        {'name': 'Soto Ayam Kampung', 'price': 22000},
        {'name': 'Es Teh Manis', 'price': 5000},
      ],
    },
    {
      'name': 'Steak & Grill House',
      'category': 'Western',
      'price': 'Rp50k - Rp150k',
      'rating': '4.7',
      'menus': [
        {'name': 'Sirloin Steak 200g', 'price': 120000},
        {'name': 'Chicken Cordon Bleu', 'price': 65000},
        {'name': 'Spaghetti Carbonara', 'price': 50000},
        {'name': 'Lemon Tea Ice', 'price': 15000},
      ],
    },
    {
      'name': 'Ramen & Sushi Master',
      'category': 'Asian',
      'price': 'Rp30k - Rp90k',
      'rating': '4.9',
      'menus': [
        {'name': 'Shoyu Ramen Beef', 'price': 55000},
        {'name': 'Salmon Roll Sushi (8pcs)', 'price': 68000},
        {'name': 'Chicken Katsu Don', 'price': 45000},
        {'name': 'Ocha Cold (Free Refill)', 'price': 10000},
      ],
    },
    {
      'name': 'Green & Healthy Cafe',
      'category': 'Healthy',
      'price': 'Rp35k - Rp80k',
      'rating': '4.6',
      'menus': [
        {'name': 'Caesar Salad Chicken', 'price': 48000},
        {'name': 'Smoothie Bowl Dragonfruit', 'price': 42000},
        {'name': 'Cold Pressed Green Juice', 'price': 35000},
      ],
    },
    {
      'name': 'Warung Nasi Padang Sederhana',
      'category': 'Nusantara',
      'price': 'Rp15k - Rp40k',
      'rating': '4.8',
      'menus': [
        {'name': 'Nasi Rendang Daging', 'price': 28000},
        {'name': 'Nasi Ayam Pop', 'price': 25000},
        {'name': 'Gulai Cincang', 'price': 30000},
        {'name': 'Es Jeruk Murni', 'price': 8000},
      ],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Logika penyaringan gabungan (Kategori & Kata Kunci Pencarian)
    final filteredRestaurants = restaurants.where((resto) {
      final matchesCategory = selectedCategory == 'Semua' ||
          resto['category'] == selectedCategory;
      final matchesSearch = resto['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase().trim());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      // HEADER UTAMA (APPBAR)
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
          // Tombol Profil
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
            // SEARCH BAR DENGAN TOMBOL CLEAR
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari restoran atau menu...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // BANNER PROMOSI & AI MENUBOT
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

            // DAFTAR KATEGORI KULINER
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

            // REKOMENDASI RESTORAN
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

            // TAMPILAN JIKA TIDAK DITEMUKAN / DAFTAR KARTU RESTORAN
            if (filteredRestaurants.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      const Text(
                        'Restoran tidak tersedia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Coba kata kunci lain atau ubah filter kategori.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: filteredRestaurants.map((resto) {
                  return _buildRestaurantCard(resto);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  // WIDGET FILTER CHIP
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

  // WIDGET KARTU RESTORAN (Kirim data restoran utuh termasuk array 'menus')
  Widget _buildRestaurantCard(Map<String, dynamic> resto) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailRestaurantScreen(restaurant: resto),
          ),
        );
      },
      child: Card(
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
                        resto['name'] ?? '',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(resto['rating'] ?? '0.0',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${resto['category']} • ${resto['price']}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}