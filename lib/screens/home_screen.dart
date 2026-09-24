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

  // Data 10 Restoran & Kafe Nyata di Medan (Format .jpg)
  final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Resto Nusantara Jaya',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp50k',
      'rating': '4.8',
      'image': 'assets/images/nusantara.jpg',
      'menus': [
        {'name': 'Nasi Goreng Spesial', 'price': 25000},
        {'name': 'Ayam Bakar Madu', 'price': 30000},
        {'name': 'Soto Ayam Kampung', 'price': 22000},
        {'name': 'Mie Goreng Seafood', 'price': 28000},
        {'name': 'Ikan Gurame Goreng Kipas', 'price': 45000},
        {'name': 'Sate Ayam Madura (10 tusuk)', 'price': 25000},
        {'name': 'Cah Kangkung Terasi', 'price': 15000},
        {'name': 'Es Teh Manis', 'price': 5000},
        {'name': 'Es Jeruk Peras', 'price': 8000},
        {'name': 'Jus Alpukat', 'price': 12000},
      ],
    },
    {
      'name': 'Rumah Makan Tabona',
      'category': 'Nusantara',
      'price': 'Rp30k - Rp70k',
      'rating': '4.8',
      'image': 'assets/images/tabona.jpg',
      'menus': [
        {'name': 'Kari Ayam Kampung', 'price': 45000},
        {'name': 'Kari Sapi Khas Tabona', 'price': 50000},
        {'name': 'Kari Bihun Ayam', 'price': 45000},
        {'name': 'Kari Bihun Sapi', 'price': 50000},
        {'name': 'Kari Jeroan Sapi', 'price': 48000},
        {'name': 'Nasi Putih', 'price': 7000},
        {'name': 'Bihun Polos', 'price': 8000},
        {'name': 'Teh Manis Dingin', 'price': 6000},
        {'name': 'Teh Tawar Dingin', 'price': 4000},
        {'name': 'Liang Teh Medan', 'price': 10000},
      ],
    },
    {
      'name': 'Steak & Grill House',
      'category': 'Western',
      'price': 'Rp50k - Rp150k',
      'rating': '4.7',
      'image': 'assets/images/steak.jpg',
      'menus': [
        {'name': 'Sirloin Steak 200g', 'price': 120000},
        {'name': 'Tenderloin Steak 200g', 'price': 135000},
        {'name': 'Chicken Cordon Bleu', 'price': 65000},
        {'name': 'Grilled Salmon Steak', 'price': 110000},
        {'name': 'Spaghetti Carbonara', 'price': 50000},
        {'name': 'BBQ Beef Ribs', 'price': 140000},
        {'name': 'French Fries Cheese', 'price': 25000},
        {'name': 'Mashed Potato', 'price': 20000},
        {'name': 'Lemon Tea Ice', 'price': 15000},
        {'name': 'Milkshake Chocolate', 'price': 22000},
      ],
    },
    {
      'name': 'Thanos Coffee & Eatery Medan',
      'category': 'Western',
      'price': 'Rp25k - Rp85k',
      'rating': '4.6',
      'image': 'assets/images/thanos.jpg',
      'menus': [
        {'name': 'Beef Burger Deluxe', 'price': 45000},
        {'name': 'Chicken Creamy Pasta', 'price': 48000},
        {'name': 'Fish and Chips', 'price': 52000},
        {'name': 'Chicken Wings BBQ', 'price': 35000},
        {'name': 'Waffle Ice Cream Sundae', 'price': 30000},
        {'name': 'Club Sandwich Extra Cheese', 'price': 40000},
        {'name': 'Americano Hot/Ice', 'price': 22000},
        {'name': 'Cafe Latte', 'price': 28000},
        {'name': 'Caramel Macchiato', 'price': 32000},
        {'name': 'Matcha Green Tea Latte', 'price': 30000},
      ],
    },
    {
      'name': 'Ramen & Sushi Master',
      'category': 'Asian',
      'price': 'Rp30k - Rp90k',
      'rating': '4.9',
      'image': 'assets/images/ramensushi.jpg',
      'menus': [
        {'name': 'Shoyu Ramen Beef', 'price': 55000},
        {'name': 'Spicy Tonkotsu Ramen', 'price': 58000},
        {'name': 'Salmon Roll Sushi (8pcs)', 'price': 68000},
        {'name': 'Chicken Katsu Don', 'price': 45000},
        {'name': 'Beef Teriyaki Bento', 'price': 62000},
        {'name': 'Ebi Furai Roll Sushi', 'price': 50000},
        {'name': 'Takoyaki Classic (6pcs)', 'price': 28000},
        {'name': 'Chicken Gyoza (5pcs)', 'price': 25000},
        {'name': 'Ocha Cold (Free Refill)', 'price': 10000},
        {'name': 'Japanese Lemonade', 'price': 18000},
      ],
    },
    {
      'name': 'Nelayan Jembatan Merah Medan',
      'category': 'Asian',
      'price': 'Rp25k - Rp80k',
      'rating': '4.8',
      'image': 'assets/images/nelayan.jpg',
      'menus': [
        {'name': 'Dimsum Lenghongkien', 'price': 32000},
        {'name': 'Dimsum Siomay Ayam', 'price': 28000},
        {'name': 'Dimsum Hakau Udang', 'price': 30000},
        {'name': 'Dimsum Lumpia Udang Kulit Tahu', 'price': 30000},
        {'name': 'Nasi Goreng Nelayan Spesial', 'price': 42000},
        {'name': 'Kwetiau Siram Sapi', 'price': 45000},
        {'name': 'Bebek Panggang Hongkong', 'price': 75000},
        {'name': 'Es Nelayan Spesial', 'price': 25000},
        {'name': 'Es Campur Medan', 'price': 22000},
        {'name': 'Teh Manis Dingin', 'price': 8000},
      ],
    },
    {
      'name': 'Green & Healthy Cafe',
      'category': 'Healthy',
      'price': 'Rp35k - Rp80k',
      'rating': '4.6',
      'image': 'assets/images/green.jpg',
      'menus': [
        {'name': 'Caesar Salad Chicken', 'price': 48000},
        {'name': 'Salmon Avocado Salad', 'price': 65000},
        {'name': 'Smoothie Bowl Dragonfruit', 'price': 42000},
        {'name': 'Granola Yogurt Berry', 'price': 38000},
        {'name': 'Quinoa Veggie Bowl', 'price': 50000},
        {'name': 'Grilled Chicken Breast Rice', 'price': 55000},
        {'name': 'Whole Wheat Tuna Toast', 'price': 35000},
        {'name': 'Cold Pressed Green Juice', 'price': 35000},
        {'name': 'Infused Water Lemon Mint', 'price': 15000},
        {'name': 'Almond Milk Matchalatte', 'price': 32000},
      ],
    },
    {
      'name': 'Kopi Janji Jiwa & Jiwa Toast Medan',
      'category': 'Healthy',
      'price': 'Rp18k - Rp45k',
      'rating': '4.7',
      'image': 'assets/images/janjijiwa.jpg',
      'menus': [
        {'name': 'Toast Egg and Cheese', 'price': 22000},
        {'name': 'Toast Crispy Chicken', 'price': 28000},
        {'name': 'Toast Tuna Mayo', 'price': 26000},
        {'name': 'Toast Thai Sweet Chili', 'price': 25000},
        {'name': 'Toast Ham and Cheese', 'price': 30000},
        {'name': 'Es Kopi Kenangan Mantan', 'price': 18000},
        {'name': 'Es Soy Matcha (Healthy)', 'price': 25000},
        {'name': 'Earl Grey Milk Tea', 'price': 22000},
        {'name': 'Es Americano Less Sugar', 'price': 18000},
        {'name': 'Fresh Orange Pure Juice', 'price': 20000},
      ],
    },
    {
      'name': 'Warung Nasi Padang Sederhana',
      'category': 'Nusantara',
      'price': 'Rp15k - Rp40k',
      'rating': '4.8',
      'image': 'assets/images/naspad.jpg',
      'menus': [
        {'name': 'Nasi Rendang Daging', 'price': 28000},
        {'name': 'Nasi Ayam Pop', 'price': 25000},
        {'name': 'Nasi Ayam Goreng Bumbu', 'price': 24000},
        {'name': 'Gulai Cincang Sapi', 'price': 30000},
        {'name': 'Gulai Kepala Ikan Kakap', 'price': 45000},
        {'name': 'Dendeng Balado Batokok', 'price': 28000},
        {'name': 'Telur Dadar Padang', 'price': 12000},
        {'name': 'Perkedel Kentang', 'price': 6000},
        {'name': 'Es Jeruk Murni', 'price': 8000},
        {'name': 'Teh Botol Sosro', 'price': 6000},
      ],
    },
    {
      'name': 'Maha Kopi & Resto Medan',
      'category': 'Nusantara',
      'price': 'Rp20k - Rp60k',
      'rating': '4.7',
      'image': 'assets/images/mahakopi.jpg',
      'menus': [
        {'name': 'Nasi Daging Sapi Lada Hitam', 'price': 38000},
        {'name': 'Ayam Penyet Sambal Ijo', 'price': 26000},
        {'name': 'Mie Aceh Tumis Daging', 'price': 32000},
        {'name': 'Nasi Gurih Komplit Medan', 'price': 28000},
        {'name': 'Soto Medan Daging Sapi', 'price': 35000},
        {'name': 'Singkong Goreng Keju', 'price': 18000},
        {'name': 'Pisang Goreng Cokelat Keju', 'price': 20000},
        {'name': 'Kopi Tubruk Sidikalang', 'price': 15000},
        {'name': 'Espresso Milk Gula Aren', 'price': 22000},
        {'name': 'Es Alpukat Kocok Medan', 'price': 20000},
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
    // Logika penyaringan Kategori & Kata Kunci Pencarian
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
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEARCH BAR
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

            // BANNER PROMO
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

            // KATEGORI KULINER
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                resto['image'] ?? 'assets/images/nusantara.jpg',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
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
                      Text(
                        resto['name'] ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(resto['rating'] ?? '0.0',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
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