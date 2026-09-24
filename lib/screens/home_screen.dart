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
        {'name': 'Soto Campur Spesial', 'price': 38000},
        {'name': 'Perkedel Kentang Jumbo', 'price': 7000},
        {'name': 'Emping Melinjo', 'price': 5000},
        {'name': 'Nasi Putih', 'price': 7000},
        {'name': 'Es Jeruk Peras', 'price': 8000},
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
        {'name': 'Nasi Tim Bebek', 'price': 35000},
        {'name': 'Pangsit Goreng (5pcs)', 'price': 30000},
        {'name': 'Telur Kecap Herbal', 'price': 8000},
        {'name': 'Es Liang Teh', 'price': 10000},
        {'name': 'Es Kacamata', 'price': 12000},
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
        {'name': 'Nasi Goreng Spesial Tip Top', 'price': 50000},
        {'name': 'Bitterballen Daging Sapi', 'price': 48000},
        {'name': 'Es Krim Homemade Vanila', 'price': 30000},
        {'name': 'Pudding Cokelat Vla', 'price': 28000},
        {'name': 'Kopi Tarik Klasik', 'price': 22000},
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
        {'name': 'Classic Cheeseburger', 'price': 55000},
        {'name': 'Loaded French Fries', 'price': 32000},
        {'name': 'Churros with Chocolate Dip', 'price': 28000},
        {'name': 'Caramel Machiato Ice', 'price': 32000},
        {'name': 'Hazelnut Latte', 'price': 32000},
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
        {'name': 'Ayam Panggang Ta Wan', 'price': 60000},
        {'name': 'Cah Kailan Garlic', 'price': 38000},
        {'name': 'Sapi Lada Hitam Hotplate', 'price': 75000},
        {'name': 'Dimsum Udang Steam', 'price': 32000},
        {'name': 'Es Longan Buah Segar', 'price': 28000},
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
        {'name': 'Chicken Garlic Butter', 'price': 42000},
        {'name': 'Spicy Sukiyaki Bibimbap', 'price': 48000},
        {'name': 'Miso Soup', 'price': 20000},
        {'name': 'Caesar Salad Gyukaku', 'price': 35000},
        {'name': 'Milk Pudding Dessert', 'price': 25000},
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
        {'name': 'Beat That Juice (Beetroot)', 'price': 58000},
        {'name': 'Avocado Coffee High Protein', 'price': 65000},
        {'name': 'Pure Coconut Water', 'price': 38000},
        {'name': 'Chia Seed Pudding Bowl', 'price': 45000},
        {'name': 'Almond Milk Cacao', 'price': 55000},
        {'name': 'Tropical Turmeric Shot', 'price': 30000},
        {'name': 'Detox Green Water', 'price': 35000},
      ],
    },
    {
      'name': 'Suisse Bakery & Cafe Medan',
      'category': 'Healthy',
      'price': 'Rp15k - Rp50k',
      'rating': '4.7',
      'image': 'assets/images/janjijiwa.jpg',
      'menus': [
        {'name': 'Whole Wheat Bread Loaf', 'price': 28000},
        {'name': 'Chicken Salad Sandwich Wheat', 'price': 35000},
        {'name': 'Avocado Toast Whole Grain', 'price': 38000},
        {'name': 'Oatmeal Fruit Bowl', 'price': 32000},
        {'name': 'Low Sugar Banana Muffin', 'price': 18000},
        {'name': 'Almond Croissant', 'price': 25000},
        {'name': 'Green Tea Smoothies', 'price': 32000},
        {'name': 'Black Coffee Americano', 'price': 20000},
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
        {'name': 'Mie Gomak Sayur Medan', 'price': 22000},
        {'name': 'Telur Balado Bulat', 'price': 7000},
        {'name': 'Tempe Goreng Tepung', 'price': 4000},
        {'name': 'Kerupuk Merah Udang', 'price': 4000},
        {'name': 'Es Teh Manis Dingin', 'price': 5000},
        {'name': 'Es Jeruk Peras Murni', 'price': 8000},
        {'name': 'Kopi Hitam Tradisional', 'price': 10000},
      ],
    },
    {
      'name': 'Pondok Gurame Medan',
      'category': 'Nusantara',
      'price': 'Rp35k - Rp110k',
      'rating': '4.7',
      'image': 'assets/images/gurame.jpg',
      'menus': [
        {'name': 'Gurame Goreng Terbang Sambal Mangga', 'price': 85000},
        {'name': 'Gurame Bakar Madu Spesial', 'price': 90000},
        {'name': 'Gurame Asam Manis', 'price': 88000},
        {'name': 'Udang Bakar Madu Jimbaran', 'price': 75000},
        {'name': 'Cumi Goreng Tepung Krispi', 'price': 55000},
        {'name': 'Cah Kangkung Polos', 'price': 15000},
        {'name': 'Nasi Putih Bakul (Untuk 3-4 orang)', 'price': 25000},
        {'name': 'Es Kelapa Muda Jeruk', 'price': 18000},
        {'name': 'Es Teh Manis', 'price': 5000},
        {'name': 'Jus Alpukat Kerok', 'price': 15000},
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
        {'name': 'French Fries Special', 'price': 25000},
        {'name': 'Onion Rings', 'price': 22000},
        {'name': 'Caesar Salad', 'price': 40000},
        {'name': 'Iced Black Coffee', 'price': 20000},
        {'name': 'Lemon Squash', 'price': 25000},
        {'name': 'Milkshake Chocolate', 'price': 30000},
        {'name': 'Mineral Water', 'price': 7000},
      ],
    },
    {
      'name': 'Maimun Palace Cafe',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp60k',
      'rating': '4.8',
      'image': 'assets/images/tabona.jpg',
      'menus': [
        {'name': 'Nasi Goreng Istana Maimun', 'price': 40000},
        {'name': 'Sate Padang Daging Asli', 'price': 35000},
        {'name': 'Ayam Penyet Sambal Hijau', 'price': 32000},
        {'name': 'Gado-Gado Medan', 'price': 28000},
        {'name': 'Tahu Telor Special', 'price': 25000},
        {'name': 'Es Cendol Durian', 'price': 22000},
        {'name': 'Teh Tarik Istana', 'price': 15000},
        {'name': 'Es Timun Suri', 'price': 15000},
        {'name': 'Kopi Tubruk', 'price': 12000},
        {'name': 'Kerupuk Jangek', 'price': 8000},
      ],
    },
    {
      'name': 'Cambridge Steakhouse',
      'category': 'Western',
      'price': 'Rp60k - Rp180k',
      'rating': '4.9',
      'image': 'assets/images/mahakopi.jpg',
      'menus': [
        {'name': 'Wagyu Ribeye Steak 200g', 'price': 165000},
        {'name': 'T-Bone Steak Premium', 'price': 175000},
        {'name': 'Lamb Chop Blackpepper', 'price': 145000},
        {'name': 'Grilled Salmon Steak', 'price': 130000},
        {'name': 'Creamy Mushroom Soup', 'price': 40000},
        {'name': 'Garlic Bread', 'price': 25000},
        {'name': 'Mashed Potato Extra', 'price': 30000},
        {'name': 'Ice Lemon Tea', 'price': 22000},
        {'name': 'Sparkling Water', 'price': 35000},
        {'name': 'Panna Cotta Vanilla', 'price': 45000},
      ],
    },
    {
      'name': 'Nelayan Resto Sun Plaza',
      'category': 'Asian',
      'price': 'Rp40k - Rp110k',
      'rating': '4.8',
      'image': 'assets/images/nelayan.jpg',
      'menus': [
        {'name': 'Dimsum Hakau Udang', 'price': 35000},
        {'name': 'Dimsum Siomay Ayam', 'price': 32000},
        {'name': 'Bakpao Telur Asin', 'price': 30000},
        {'name': 'Mie Bebek Panggang', 'price': 58000},
        {'name': 'Nasi Goreng Seafood', 'price': 52000},
        {'name': 'Udang Mayonnaise', 'price': 75000},
        {'name': 'Cah Broccoli Sapi', 'price': 60000},
        {'name': 'Es Timun Lemon', 'price': 25000},
        {'name': 'Chinese Tea Refill', 'price': 18000},
        {'name': 'Jus Melon Segar', 'price': 24000},
      ],
    },
    {
      'name': 'Koki Sunda Medan',
      'category': 'Nusantara',
      'price': 'Rp30k - Rp90k',
      'rating': '4.7',
      'image': 'assets/images/kokisunda.webp',
      'menus': [
        {'name': 'Paket Nasi Timbel Komplit', 'price': 55000},
        {'name': 'Ayam Bakar Sunda Madu', 'price': 42000},
        {'name': 'Gurame Pecak Sambal', 'price': 85000},
        {'name': 'Sayur Asem Sunda Asli', 'price': 20000},
        {'name': 'Pepes Tahu Jamur', 'price': 15000},
        {'name': 'Karedok Sayuran Segar', 'price': 22000},
        {'name': 'Sambal Dadak Terasi', 'price': 8000},
        {'name': 'Es Kelapa Muda Jeruk', 'price': 20000},
        {'name': 'Es Cincau Hijau', 'price': 16000},
        {'name': 'Teh Manis Hangat', 'price': 5000},
      ],
    },
    {
      'name': 'Tokyo Station Ramen Medan',
      'category': 'Asian',
      'price': 'Rp35k - Rp85k',
      'rating': '4.8',
      'image': 'assets/images/tokyoramen.jpg',
      'menus': [
        {'name': 'Tokyo Shoyu Ramen', 'price': 48000},
        {'name': 'Spicy Miso Ramen', 'price': 55000},
        {'name': 'Chicken Katsu Curry Rice', 'price': 58000},
        {'name': 'Beef Teriyaki Don', 'price': 62000},
        {'name': 'Gyoza Pan-Fried (5pcs)', 'price': 32000},
        {'name': 'Takoyaki Octopus', 'price': 30000},
        {'name': 'Ocha Cold', 'price': 12000},
        {'name': 'Ice Lychee Tea', 'price': 25000},
        {'name': 'Matcha Ice Cream', 'price': 28000},
        {'name': 'Mineral Water', 'price': 8000},
      ],
    },
    {
      'name': 'Healthy Bites & Salad Bar',
      'category': 'Healthy',
      'price': 'Rp35k - Rp75k',
      'rating': '4.7',
      'image': 'assets/images/green.jpg',
      'menus': [
        {'name': 'Grilled Chicken Caesar Salad', 'price': 52000},
        {'name': 'Tofu Avocado Poke Bowl', 'price': 58000},
        {'name': 'Quinoa Salmon Bowl', 'price': 75000},
        {'name': 'Green Detox Smoothie', 'price': 40000},
        {'name': 'Berry Antioxidant Smoothie', 'price': 42000},
        {'name': 'Almond Protein Milk', 'price': 35000},
        {'name': 'Chia Seed Pudding', 'price': 30000},
        {'name': 'Whole Wheat Wrap Tuna', 'price': 48000},
        {'name': 'Infused Lemon Water', 'price': 15000},
        {'name': 'Mineral Water', 'price': 8000},
      ],
    },
    {
      'name': 'Wajir Corner Medan',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp55k',
      'rating': '4.6',
      'image': 'assets/images/naspad.jpg',
      'menus': [
        {'name': 'Nasi Lemak Royal Special', 'price': 35000},
        {'name': 'Lontong Sayur Medan', 'price': 25000},
        {'name': 'Roti Jala Kari Ayam', 'price': 30000},
        {'name': 'Mie Lidi Goreng', 'price': 22000},
        {'name': 'Teh Tarik Special', 'price': 15000},
        {'name': 'Kopi O Medan', 'price': 10000},
        {'name': 'Es Jeruk Kasturi', 'price': 16000},
        {'name': 'Pisang Goreng Keju', 'price': 18000},
        {'name': 'Martabak Telur Mini', 'price': 20000},
        {'name': 'Air Mineral', 'price': 5000},
      ],
    },
    {
      'name': 'Seoul Garden Medan',
      'category': 'Asian',
      'price': 'Rp130k - Rp280k',
      'rating': '4.8',
      'image': 'assets/images/ramensushi.jpg',
      'menus': [
        {'name': 'All You Can Eat Grill & Steamboat', 'price': 185000},
        {'name': 'Bulgogi Beef Special', 'price': 65000},
        {'name': 'Spicy Chicken Galbi', 'price': 50000},
        {'name': 'Kimchi Jige Soup', 'price': 40000},
        {'name': 'Seafood Platter Grill', 'price': 75000},
        {'name': 'Tteokbokki Spicy Cheese', 'price': 38000},
        {'name': 'Japchae Glass Noodles', 'price': 42000},
        {'name': 'Corn Tea Refill', 'price': 15000},
        {'name': 'Ice Peach Tea', 'price': 22000},
        {'name': 'Vanilla Soft Ice Cream', 'price': 20000},
      ],
    },
    {
      'name': 'The Daily Organic Cafe',
      'category': 'Healthy',
      'price': 'Rp40k - Rp85k',
      'rating': '4.9',
      'image': 'assets/images/thanos.jpg',
      'menus': [
        {'name': 'Organic Spinach Salad Bowl', 'price': 55000},
        {'name': 'Zucchini Pasta Pesto', 'price': 62000},
        {'name': 'Pan-Seared Organic Tofu', 'price': 48000},
        {'name': 'Cold Pressed Orange Carrot', 'price': 45000},
        {'name': 'Matcha Almond Latte', 'price': 38000},
        {'name': 'Acai Berry Bowl', 'price': 68000},
        {'name': 'Wholemeal Avocado Wrap', 'price': 52000},
        {'name': 'Chia Seed Energy Drink', 'price': 35000},
        {'name': 'Lemon Honey Warm Water', 'price': 20000},
        {'name': 'Organic Sparkling Water', 'price': 30000},
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
                    color: Colors.orange.withOpacity(0.3),
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
                      color: Colors.white.withOpacity(0.2),
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
                                color: Colors.grey.withOpacity(0.1),
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