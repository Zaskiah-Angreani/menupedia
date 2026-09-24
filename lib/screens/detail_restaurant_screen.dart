import 'package:flutter/material.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const DetailRestaurantScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailRestaurantScreen> createState() =>
      _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  // Map untuk menyimpan porsi tiap menu (Index Menu : Jumlah Porsi)
  final Map<int, int> _itemQuantities = {};

  // Helper untuk membaca nilai harga secara aman
  int _parsePrice(dynamic price) {
    if (price is int) return price;
    if (price is double) return price.toInt();
    if (price is String) return int.tryParse(price) ?? 0;
    return 0;
  }

  // Fungsi untuk menghitung Subtotal Murni
  int _calculateSubtotal(List<dynamic> menuList) {
    int subtotal = 0;
    _itemQuantities.forEach((index, qty) {
      if (index < menuList.length) {
        final price = _parsePrice(menuList[index]['price']);
        subtotal += price * qty;
      }
    });
    return subtotal;
  }

  // Fungsi untuk menghitung Total Item yang Dipilih
  int _calculateTotalItems() {
    int totalItems = 0;
    _itemQuantities.forEach((index, qty) {
      totalItems += qty;
    });
    return totalItems;
  }

  // Fungsi Tampil Pop-up Struk Pembelanjaan ala Gojek
  void _showOrderReceipt(
      BuildContext context,
      List<dynamic> menuList,
      double grandTotal,
      int subtotal,
      double tax,
      double service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Struk
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.receipt_long, color: Color(0xFFFF6B00)),
                  const SizedBox(width: 8),
                  Text(
                    'Struk Estimasi Pesanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              Text(
                widget.restaurant['name']?.toString() ?? 'Restoran',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Divider(height: 24),

              // Rincian Item Makanan yang Dipilih
              const Text(
                'Item yang Dipilih:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              ..._itemQuantities.entries.map((entry) {
                if (entry.value > 0 && entry.key < menuList.length) {
                  final item = menuList[entry.key];
                  final price = _parsePrice(item['price']);
                  final itemTotal = price * entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${entry.value}x  ${item['name']}',
                            style: const TextStyle(fontSize: 14)),
                        Text('Rp $itemTotal',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              const Divider(height: 24),

              // Rincian Kalkulasi Harga
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal:', style: TextStyle(fontSize: 13)),
                  Text('Rp $subtotal', style: const TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pajak Restoran (10%):',
                      style: TextStyle(fontSize: 13)),
                  Text('Rp ${tax.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Biaya Layanan/Service (5%):',
                      style: TextStyle(fontSize: 13)),
                  Text('Rp ${service.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
              const Divider(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Pembayaran:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    'Rp ${grandTotal.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFFF6B00),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol Selesai
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Menutup BottomSheet Struk
                },
                child: const Text(
                  'Selesai',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pengamanan type casting data list menu
    final List<dynamic> menuList = widget.restaurant['menus'] != null
        ? List<Map<String, dynamic>>.from(widget.restaurant['menus'])
        : [];

    final int subtotal = _calculateSubtotal(menuList);
    final int totalItems = _calculateTotalItems();
    final double tax = subtotal * 0.10;
    final double service = subtotal * 0.05;
    final double grandTotal = subtotal + tax + service;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant['name']?.toString() ?? 'Detail Restoran'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BANNER / FOTO RESTORAN (Menggunakan Image.asset .jpg)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.restaurant['image'] ?? 'assets/images/nusantara.jpg',
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 70, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. NAMA & INFORMASI RESTORAN
            Text(
              widget.restaurant['name']?.toString() ?? 'Nama Restoran',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.restaurant['category']} • Rating ${widget.restaurant['rating']} • ${widget.restaurant['price']}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Divider(height: 32),

            // 3. DAFTAR MENU
            const Text(
              'Daftar Menu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Tampilkan daftar menu
            menuList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Text(
                        'Belum ada menu yang tersedia untuk restoran ini.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuList.length,
                    itemBuilder: (context, index) {
                      final item = menuList[index];
                      final qty = _itemQuantities[index] ?? 0;
                      final price = _parsePrice(item['price']);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']?.toString() ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp $price',
                                    style: const TextStyle(
                                        color: Color(0xFFFF6B00),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              // Tombol Tambah & Kurang Porsi ala Gojek
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: qty > 0
                                          ? () {
                                              setState(() {
                                                _itemQuantities[index] =
                                                    qty - 1;
                                              });
                                            }
                                          : null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.remove,
                                          size: 18,
                                          color: qty > 0
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '$qty',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _itemQuantities[index] = qty + 1;
                                        });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          size: 18,
                                          color: Color(0xFFFF6B00),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      // AREA TOMBOL BOTTOM (LIHAT TOTAL & RESERVASI MEJA)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // FLOATING BUTTON ala GOJEK
            if (totalItems > 0) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _showOrderReceipt(
                      context, menuList, grandTotal, subtotal, tax, service);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$totalItems Item',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Lihat Total Pesanan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    Text(
                      'Rp ${grandTotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],

            // TOMBOL UTAMA FITUR RESERVASI MEJA
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B00),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Membuka formulir reservasi meja untuk ${widget.restaurant['name']}',
                    ),
                  ),
                );
              },
              child: const Text(
                'Buat Reservasi Meja Sekarang',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}