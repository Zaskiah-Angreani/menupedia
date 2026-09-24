import 'package:flutter/material.dart';
import 'reservation_form_screen.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final Function(Map<String, dynamic>) onReservationAdded; // Callback untuk kirim data reservasi

  const DetailRestaurantScreen({
    super.key,
    required this.restaurant,
    required this.onReservationAdded,
  });

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  late List<Map<String, dynamic>> menuList;

  @override
  void initState() {
    super.initState();
    menuList = List<Map<String, dynamic>>.from(
      widget.restaurant['menus'].map((menu) => {
            'name': menu['name'],
            'price': menu['price'],
            'qty': 0,
          }),
    );
  }

  void _updateQty(int index, int delta) {
    setState(() {
      int newQty = menuList[index]['qty'] + delta;
      if (newQty >= 0) {
        menuList[index]['qty'] = newQty;
      }
    });
  }

  void _showOrderReceipt(
      BuildContext context,
      List<Map<String, dynamic>> items,
      double grandTotal,
      double subtotal,
      double tax,
      double service) {
    final orderedItems = items.where((item) => item['qty'] > 0).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rincian Pesanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.restaurant['name'],
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const Divider(height: 24),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderedItems.length,
                  itemBuilder: (context, index) {
                    final item = orderedItems[index];
                    final itemTotal = item['price'] * item['qty'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item['qty']}x ${item['name']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            'Rp ${itemTotal.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal'),
                  Text('Rp ${subtotal.toStringAsFixed(0)}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pajak (10%)'),
                  Text('Rp ${tax.toStringAsFixed(0)}'),
                ],
              ),
              const SizedBox(height: 4),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Biaya Layanan'),
                  Text('Rp ${service.toStringAsFixed(0)}'),
                ],
              ),
              const Divider(height: 16),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(
                    'Rp ${grandTotal.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFF6B00)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan berhasil dibuat!')),
                  );
                },
                child: const Text('Konfirmasi Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = menuList.fold(0, (sum, item) => sum + (item['qty'] as int));
    double subtotal = menuList.fold(0.0, (sum, item) => sum + (item['price'] * item['qty']));
    double tax = subtotal * 0.10;
    double service = subtotal > 0 ? 5000.0 : 0.0;
    double grandTotal = subtotal + tax + service;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFFFF6B00),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.restaurant['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.restaurant, size: 64, color: Colors.grey)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.restaurant['name'],
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant['rating'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.restaurant['category']} • ${widget.restaurant['price']}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Menu Pilihan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuList.length,
                    itemBuilder: (context, index) {
                      final menu = menuList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.08),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu['name'],
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${menu['price']}',
                                    style: const TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                if (menu['qty'] > 0) ...[
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                    onPressed: () => _updateQty(index, -1),
                                  ),
                                  Text(
                                    '${menu['qty']}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                                IconButton(
                                  icon: const Icon(Icons.add_circle, color: Color(0xFFFF6B00)),
                                  onPressed: () => _updateQty(index, 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B00),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: totalItems == 0
                        ? null
                        : () {
                            _showOrderReceipt(
                                context, menuList, grandTotal, subtotal, tax, service);
                          },
                    child: Text(
                      totalItems == 0
                          ? 'Pilih Menu Terlebih Dahulu'
                          : 'Pesan Sekarang ($totalItems Item - Rp ${grandTotal.toStringAsFixed(0)})',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF6B00),
                      side: const BorderSide(color: Color(0xFFFF6B00)),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.event_seat),
                    label: const Text(
                      'Buat Reservasi Meja Sekarang',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      final hasilReservasi = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationFormScreen(
                            restaurant: widget.restaurant,
                          ),
                        ),
                      );

                      if (hasilReservasi != null) {
                        widget.onReservationAdded(hasilReservasi); // Kirim ke HomeScreen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reservasi berhasil disimpan ke riwayat!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}