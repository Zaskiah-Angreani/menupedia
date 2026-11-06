import 'package:flutter/material.dart';
import 'detail_restaurant_screen.dart';
import 'reservation_history_screen.dart'; // Import halaman riwayat
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Semua';
  String searchQuery = '';

  // LIST UTAMA MENAMPUNG DATA RESERVASI
  final List<Map<String, dynamic>> globalReservations = [];

  final List<String> categories = ['Semua', 'Nusantara', 'Western', 'Asian', 'Healthy'];

  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Soto Medan Kesawan',
      'category': 'Nusantara',
      'price': 'Rp25k - Rp50k',
      'rating': '4.8',
      'image': 'assets/images/sotokesawan2.jpg',
      'menus': [
        {'name': 'Soto Udang Kesawan', 'price': 35000},
        {'name': 'Soto Daging Sapi', 'price': 32000},
        {'name': 'Soto Ayam Kampung', 'price': 28000},
        {'name': 'Es Teh Manis', 'price': 5000},
        {'name': 'Teh Tawar Hangat', 'price': 3000},
      ],
    },
    {
      'name': 'Bihun Bebek Asie Medan',
      'category': 'Nusantara',
      'price': 'Rp40k - Rp95k',
      'rating': '4.9',
      'image': 'assets/images/bihunbebek.jpg',
      'menus': [
        {'name': 'Bihun Bebek Kuah Herbal Spesial', 'price': 75000},
        {'name': 'Bihun Bebek Setengah Porsi', 'price': 45000},
        {'name': 'Sup Daging Bebek Polos', 'price': 70000},
        {'name': 'Teh Manis Hangat', 'price': 5000},
        {'name': 'Air Mineral', 'price': 5000},
      ],
    },
    {
      'name': 'Tip Top Restaurant Medan',
      'category': 'Western',
      'price': 'Rp40k - Rp120k',
      'rating': '4.7',
      'image': 'assets/images/tiptop.png',
      'menus': [
        {'name': 'Biterballen Klasik Tip Top', 'price': 45000},
        {'name': 'Oxtail Soup (Sup Buntut Sapi)', 'price': 95000},
        {'name': 'Chicken Steak Classic', 'price': 65000},
        {'name': 'Es Soda Gembira', 'price': 25000},
        {'name': 'Lemon Tea', 'price': 18000},
      ],
    },
    {
      'name': 'The Stage Cafe & Resto Medan',
      'category': 'Western',
      'price': 'Rp30k - Rp90k',
      'rating': '4.6',
      'image': 'assets/images/thestage.jpg',
      'menus': [
        {'name': 'Mushroom Cream Soup', 'price': 35000},
        {'name': 'Aglio Olio Smoked Beef', 'price': 48000},
        {'name': 'Chicken Parmigiana', 'price': 62000},
        {'name': 'Lychee Tea Refreshment', 'price': 25000},
        {'name': 'Mineral Water', 'price': 8000},
      ],
    },
    {
      'name': 'Ta Wan Restaurant Sun Plaza Medan',
      'category': 'Asian',
      'price': 'Rp30k - Rp85k',
      'rating': '4.8',
      'image': 'assets/images/tawan.webp',
      'menus': [
        {'name': 'Bubur Spesial Century Egg & Ayam', 'price': 35000},
        {'name': 'Mie Hongkong Daging Sapi', 'price': 52000},
        {'name': 'Udang Goreng Tepung Asam Manis', 'price': 68000},
        {'name': 'Chinese Tea (Pot)', 'price': 15000},
        {'name': 'Es Jeruk Mandarin', 'price': 22000},
      ],
    },
    {
      'name': 'Gyukaku Japanese BBQ Medan',
      'category': 'Asian',
      'price': 'Rp150k - Rp350k',
      'rating': '4.9',
      'image': 'assets/images/gyukaku.jpg',
      'menus': [
        {'name': 'Standard Buffet Package', 'price': 238000},
        {'name': 'Gyu-Kaku Karubi (Beef)', 'price': 65000},
        {'name': 'King Karubi', 'price': 85000},
        {'name': 'Ocha Cold Refill', 'price': 15000},
        {'name': 'Lemonade Squash', 'price': 28000},
      ],
    },
    {
      'name': 'Re Juve Healthy Bar Medan',
      'category': 'Healthy',
      'price': 'Rp40k - Rp85k',
      'rating': '4.8',
      'image': 'assets/images/rejuve.jpg',
      'menus': [
        {'name': 'Glory Green Cold-Pressed Juice', 'price': 55000},
        {'name': 'Iis Happy Green Juice', 'price': 55000},
        {'name': 'Ultimate Golden Clarify', 'price': 60000},
        {'name': 'Tropical Turmeric Shot', 'price': 30000},
        {'name': 'Detox Green Water', 'price': 35000},
      ],
    },
    {
      'name': 'Suisse Bakery & Cafe Medan',
      'category': 'Healthy',
      'price': 'Rp15k - Rp50k',
      'rating': '4.7',
      'image': 'assets/images/tabona.jpg',
      'menus': [
        {'name': 'Whole Wheat Bread Loaf', 'price': 28000},
        {'name': 'Chicken Salad Sandwich Wheat', 'price': 35000},
        {'name': 'Avocado Toast Whole Grain', 'price': 38000},
        {'name': 'Fresh Carrot Juice', 'price': 22000},
        {'name': 'Mineral Water Organic', 'price': 8000},
      ],
    },
    {
      'name': 'Lontong Kak Lin Medan',
      'category': 'Nusantara',
      'price': 'Rp15k - Rp35k',
      'rating': '4.8',
      'image': 'assets/images/lontong.jpg',
      'menus': [
        {'name': 'Lontong Sayur Komplit Medan', 'price': 22000},
        {'name': 'Lontong Pecel Lele/Ayam', 'price': 25000},
        {'name': 'Nasi Sayur Medan', 'price': 20000},
        {'name': 'Es Jeruk Peras Murni', 'price': 8000},
        {'name': 'Kopi Hitam Tradisional', 'price': 10000},
      ],
    },
    {
      'name': 'Merdeka Walk Bistro',
      'category': 'Western',
      'price': 'Rp35k - Rp100k',
      'rating': '4.6',
      'image': 'assets/images/merdekawalk.jpg',
      'menus': [
        {'name': 'Sirloin Steak Lokal', 'price': 85000},
        {'name': 'Chicken Cordon Bleu', 'price': 65000},
        {'name': 'Spaghetti Bolognese', 'price': 50000},
        {'name': 'Milkshake Chocolate', 'price': 30000},
        {'name': 'Mineral Water', 'price': 7000},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRestaurants = restaurants.where((item) {
      final matchesCategory = selectedCategory == 'Semua' || item['category'] == selectedCategory;
      final matchesSearch = item['name'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lokasi Pengiriman', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              children: [
                Text('Medan, Sumatera Utara', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ],
            ),
          ],
        ),
        actions: [
          // TOMBOL MENU RIWAYAT RESERVASI
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black87),
            tooltip: 'Riwayat Reservasi',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationHistoryScreen(
                    reservations: globalReservations,
                    onUpdate: (id, updatedData) {
                      setState(() {
                        final index = globalReservations.indexWhere((item) => item['id'] == id);
                        if (index != -1) {
                          globalReservations[index] = updatedData;
                        }
                      });
                    },
                    onDelete: (id) {
                      setState(() {
                        globalReservations.removeWhere((item) => item['id'] == id);
                      });
                    },
                  ),
                ),
              );
            },
          ),
          // TOMBOL PROFIL DIRI
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black87),
            tooltip: 'Profil Saya',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari restoran atau kafe di Medan...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
  // Fitur AI Rekomendasi Pintar buatan temanmu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B00), Color(0xFFFF8E3C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange   .withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white   .withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rekomendasi Pintar AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Temukan kuliner Medan terbaik yang cocok untuk selera kamu hari ini!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Kategori', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: const Color(0xFFFF6B00),
                      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Restoran Populer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('${filteredRestaurants.length} tempat', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            filteredRestaurants.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('Restoran tidak ditemukan.', style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants[index];
                      return GestureDetector(
                        onTap: () {
                          // NAVIGASI KE DETAIL RESTORAN + CALLBACK PENAMBAHAN RESERVASI
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRestaurantScreen(
                                restaurant: restaurant,
                                onReservationAdded: (newReservation) {
                                  setState(() {
                                    globalReservations.add(newReservation);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey   .withValues(alpha: 0.1),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: Image.asset(
                                  restaurant['image'],
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.restaurant, size: 50, color: Colors.grey),
                                    ),
                                  ),
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
                                        Text(restaurant['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(restaurant['rating'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('${restaurant['category']} • ${restaurant['price']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}