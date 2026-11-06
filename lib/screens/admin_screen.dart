import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  final List<dynamic>? restaurants;

  const AdminScreen({
    super.key,
    this.restaurants,
  });

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late List<dynamic> _restaurantList;

  @override
  void initState() {
    super.initState();
    _restaurantList = widget.restaurants ?? [
      {
        'id': 'resto_01',
        'name': 'Soto Medan Kesawan',
        'category': 'Nusantara',
        'price': 'Rp25k - Rp50k',
        'rating': '4.8',
        'image': 'assets/images/sotokesawan2.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Soto Udang Kesawan', 'price': 35000},
          {'name': 'Soto Daging Sapi', 'price': 32000},
          {'name': 'Soto Ayam Kampung', 'price': 28000},
          {'name': 'Es Teh Manis', 'price': 5000},
          {'name': 'Teh Tawar Hangat', 'price': 3000},
        ],
      },
      {
        'id': 'resto_02',
        'name': 'Bihun Bebek Asie Medan',
        'category': 'Nusantara',
        'price': 'Rp40k - Rp95k',
        'rating': '4.9',
        'image': 'assets/images/bihunbebek.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Bihun Bebek Kuah Herbal Spesial', 'price': 75000},
          {'name': 'Bihun Bebek Setengah Porsi', 'price': 45000},
          {'name': 'Sup Daging Bebek Polos', 'price': 70000},
          {'name': 'Teh Manis Hangat', 'price': 5000},
          {'name': 'Air Mineral', 'price': 5000},
        ],
      },
      {
        'id': 'resto_03',
        'name': 'Tip Top Restaurant Medan',
        'category': 'Western',
        'price': 'Rp40k - Rp120k',
        'rating': '4.7',
        'image': 'assets/images/tiptop.png',
        'isFullBooked': false,
        'menus': [
          {'name': 'Biterballen Klasik Tip Top', 'price': 45000},
          {'name': 'Oxtail Soup (Sup Buntut Sapi)', 'price': 95000},
          {'name': 'Chicken Steak Classic', 'price': 65000},
          {'name': 'Es Soda Gembira', 'price': 25000},
          {'name': 'Lemon Tea', 'price': 18000},
        ],
      },
      {
        'id': 'resto_04',
        'name': 'The Stage Cafe & Resto Medan',
        'category': 'Western',
        'price': 'Rp30k - Rp90k',
        'rating': '4.6',
        'image': 'assets/images/thestage.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Mushroom Cream Soup', 'price': 35000},
          {'name': 'Aglio Olio Smoked Beef', 'price': 48000},
          {'name': 'Chicken Parmigiana', 'price': 62000},
          {'name': 'Lychee Tea Refreshment', 'price': 25000},
          {'name': 'Mineral Water', 'price': 8000},
        ],
      },
      {
        'id': 'resto_05',
        'name': 'Ta Wan Restaurant Sun Plaza Medan',
        'category': 'Asian',
        'price': 'Rp30k - Rp85k',
        'rating': '4.8',
        'image': 'assets/images/tawan.webp',
        'isFullBooked': false,
        'menus': [
          {'name': 'Bubur Spesial Century Egg & Ayam', 'price': 35000},
          {'name': 'Mie Hongkong Daging Sapi', 'price': 52000},
          {'name': 'Udang Goreng Tepung Asam Manis', 'price': 68000},
          {'name': 'Chinese Tea (Pot)', 'price': 15000},
          {'name': 'Es Jeruk Mandarin', 'price': 22000},
        ],
      },
      {
        'id': 'resto_06',
        'name': 'Gyukaku Japanese BBQ Medan',
        'category': 'Asian',
        'price': 'Rp150k - Rp350k',
        'rating': '4.9',
        'image': 'assets/images/gyukaku.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Standard Buffet Package', 'price': 238000},
          {'name': 'Gyu-Kaku Karubi (Beef)', 'price': 65000},
          {'name': 'King Karubi', 'price': 85000},
          {'name': 'Ocha Cold Refill', 'price': 15000},
          {'name': 'Lemonade Squash', 'price': 28000},
        ],
      },
      {
        'id': 'resto_07',
        'name': 'Re Juve Healthy Bar Medan',
        'category': 'Healthy',
        'price': 'Rp40k - Rp85k',
        'rating': '4.8',
        'image': 'assets/images/rejuve.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Glory Green Cold-Pressed Juice', 'price': 55000},
          {'name': 'Iis Happy Green Juice', 'price': 55000},
          {'name': 'Ultimate Golden Clarify', 'price': 60000},
          {'name': 'Tropical Turmeric Shot', 'price': 30000},
          {'name': 'Detox Green Water', 'price': 35000},
        ],
      },
      {
        'id': 'resto_08',
        'name': 'Suisse Bakery & Cafe Medan',
        'category': 'Healthy',
        'price': 'Rp15k - Rp50k',
        'rating': '4.7',
        'image': 'assets/images/tabona.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Whole Wheat Bread Loaf', 'price': 28000},
          {'name': 'Chicken Salad Sandwich Wheat', 'price': 35000},
          {'name': 'Avocado Toast Whole Grain', 'price': 38000},
          {'name': 'Fresh Carrot Juice', 'price': 22000},
          {'name': 'Mineral Water Organic', 'price': 8000},
        ],
      },
      {
        'id': 'resto_09',
        'name': 'Lontong Kak Lin Medan',
        'category': 'Nusantara',
        'price': 'Rp15k - Rp35k',
        'rating': '4.8',
        'image': 'assets/images/lontong.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Lontong Sayur Komplit Medan', 'price': 22000},
          {'name': 'Lontong Pecel Lele/Ayam', 'price': 25000},
          {'name': 'Nasi Sayur Medan', 'price': 20000},
          {'name': 'Es Jeruk Peras Murni', 'price': 8000},
          {'name': 'Kopi Hitam Tradisional', 'price': 10000},
        ],
      },
      {
        'id': 'resto_10',
        'name': 'Merdeka Walk Bistro',
        'category': 'Western',
        'price': 'Rp35k - Rp100k',
        'rating': '4.6',
        'image': 'assets/images/merdekawalk.jpg',
        'isFullBooked': false,
        'menus': [
          {'name': 'Sirloin Steak Lokal', 'price': 85000},
          {'name': 'Chicken Cordon Bleu', 'price': 65000},
          {'name': 'Spaghetti Bolognese', 'price': 50000},
          {'name': 'Milkshake Chocolate', 'price': 30000},
          {'name': 'Mineral Water', 'price': 7000},
        ],
      },
    ];
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun admin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await AuthService().logout();
    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showRestaurantDialog({Map<String, dynamic>? restaurant}) {
    final isEditing = restaurant != null;
    final nameController = TextEditingController(text: restaurant?['name'] ?? '');
    final categoryController = TextEditingController(text: restaurant?['category'] ?? '');
    final menuNameController = TextEditingController();
    final menuPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Restoran' : 'Tambah Restoran & Menu Baru'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Restoran',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Kategori Kuliner (misal: Nusantara)',
                  border: OutlineInputBorder(),
                ),
              ),
              if (!isEditing) ...[
                const SizedBox(height: 16),
                const Divider(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Menu Utama Restoran:', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: menuNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Menu / Hidangan',
                    hintText: 'Contoh: Nasi Goreng Special',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: menuPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Harga Menu (Rp)',
                    hintText: 'Contoh: 25000',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B00),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (nameController.text.isNotEmpty && categoryController.text.isNotEmpty) {
                final parsedPrice = int.tryParse(menuPriceController.text) ?? 20000;
                final menuName = menuNameController.text.isNotEmpty
                    ? menuNameController.text
                    : 'Menu Utama Restoran';

                setState(() {
                  if (isEditing) {
                    final index = _restaurantList.indexWhere((r) => r['id'] == restaurant['id']);
                    if (index != -1) {
                      _restaurantList[index] = {
                        ..._restaurantList[index],
                        'name': nameController.text,
                        'category': categoryController.text,
                      };
                    }
                  } else {
                    _restaurantList.add({
                      'id': 'resto_${DateTime.now().millisecondsSinceEpoch}',
                      'name': nameController.text,
                      'category': categoryController.text,
                      'price': 'Rp20k - Rp75k',
                      'rating': '4.5',
                      'image': 'assets/images/tiptop.png',
                      'isFullBooked': false,
                      'menus': [
                        {'name': menuName, 'price': parsedPrice},
                        {'name': 'Es Teh Manis', 'price': 5000},
                      ],
                    });
                  }
                });
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? 'Simpan' : 'Tambah Restoran'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String id, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Restoran'),
        content: Text('Apakah kamu yakin ingin menghapus "$name"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              setState(() {
                _restaurantList.removeWhere((r) => r['id'] == id);
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel Kuliner', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFF6B00),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B00), Color(0xFFFF8E3C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang, Admin! 🚀',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Kelola daftar 10 restoran dan menu kuliner dengan cepat melalui panel ini.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Total Restoran Terdaftar: ${_restaurantList.length}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Daftar Restoran & Menu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _restaurantList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Icon(Icons.restaurant_menu, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          Text('Belum ada data restoran', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _restaurantList.length,
                    itemBuilder: (context, index) {
                      final resto = _restaurantList[index];
                      final menus = resto['menus'] ?? [];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              resto['image'] ?? 'assets/images/tiptop.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 50,
                                height: 50,
                                color: Colors.orange.shade100,
                                child: const Icon(Icons.restaurant, color: Color(0xFFFF6B00)),
                              ),
                            ),
                          ),
                          title: Text(
                            resto['name'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          subtitle: Text(
                            'Kategori: ${resto['category']} | ${menus.length} Menu',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_rounded, color: Colors.blue, size: 20),
                                onPressed: () => _showRestaurantDialog(restaurant: resto),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_rounded, color: Colors.redAccent, size: 20),
                                onPressed: () => _confirmDelete(resto['id'], resto['name']),
                              ),
                            ],
                          ),
                          children: [
                            Container(
                              color: Colors.grey.shade50,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Daftar Menu Hidangan:',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  const SizedBox(height: 6),
                                  ...((menus as Iterable).map((m) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('• ${m['name']}', style: const TextStyle(fontSize: 13)),
                                            Text('Rp ${m['price']}',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFFF6B00))),
                                          ],
                                        ),
                                      ))),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRestaurantDialog(),
        backgroundColor: const Color(0xFFFF6B00),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Restoran', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}