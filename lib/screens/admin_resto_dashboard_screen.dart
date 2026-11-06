import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class AdminRestoDashboardScreen extends StatefulWidget {
  final String? restaurantId;

  const AdminRestoDashboardScreen({
    super.key,
    this.restaurantId,
  });

  @override
  State<AdminRestoDashboardScreen> createState() => _AdminRestoDashboardScreenState();
}

class _AdminRestoDashboardScreenState extends State<AdminRestoDashboardScreen> {
  // Flag status resto (Buka / Full Booked)
  bool _isFullBooked = false;

  // Data dummy reservasi masuk khusus resto ini
  final List<dynamic> _reservations = [
    {
      'id': 'res_01',
      'customerName': 'Budi Santoso',
      'phone': '081234567890',
      'date': '2026-11-10',
      'time': '19:00',
      'guests': 4,
      'status': 'Pending', // Pending, Accepted, Rejected
      'rejectReason': '',
    },
    {
      'id': 'res_02',
      'customerName': 'Siti Rahma',
      'phone': '089876543210',
      'date': '2026-11-11',
      'time': '13:00',
      'guests': 2,
      'status': 'Pending',
      'rejectReason': '',
    },
  ];

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari Admin Resto?'),
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

  void _updateStatus(int index, String newStatus, {String reason = ''}) {
    setState(() {
      _reservations[index]['status'] = newStatus;
      if (reason.isNotEmpty) {
        _reservations[index]['rejectReason'] = reason;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newStatus == 'Accepted'
              ? 'Reservasi diterima!'
              : 'Reservasi ditolak.',
        ),
        backgroundColor: newStatus == 'Accepted' ? Colors.green : Colors.red,
      ),
    );
  }

  void _showRejectDialog(int index) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tolak Reservasi'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Alasan Penolakan',
            hintText: 'Contoh: Meja sudah penuh jam tersebut',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              if (reasonController.text.isNotEmpty) {
                _updateStatus(index, 'Rejected', reason: reasonController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Tolak'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin Resto', style: TextStyle(fontWeight: FontWeight.bold)),
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
            // Card Kontrol Buka / Full Booked
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isFullBooked ? Colors.red.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isFullBooked ? Colors.red.shade200 : Colors.green.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isFullBooked ? 'Status: FULL BOOKED 🛑' : 'Status: MENERIMA RESERVASI 🟢',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isFullBooked ? Colors.red.shade800 : Colors.green.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _isFullBooked
                            ? 'User tidak bisa melakukan reservasi baru.'
                            : 'Restoran siap menerima reservasi baru.',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  Switch(
                    value: _isFullBooked,
                    activeColor: Colors.red,
                    onChanged: (val) {
                      setState(() {
                        _isFullBooked = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Daftar Reservasi Masuk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _reservations.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text('Belum ada reservasi masuk.'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _reservations.length,
                    itemBuilder: (context, index) {
                      final res = _reservations[index];
                      final isPending = res['status'] == 'Pending';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    res['customerName'].toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: res['status'] == 'Accepted'
                                          ? Colors.green.shade100
                                          : res['status'] == 'Rejected'
                                              ? Colors.red.shade100
                                              : Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      res['status'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: res['status'] == 'Accepted'
                                            ? Colors.green.shade800
                                            : res['status'] == 'Rejected'
                                                ? Colors.red.shade800
                                                : Colors.orange.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text('📅 Tanggal & Jam: ${res['date']} @ ${res['time']} WIB'),
                              Text('👥 Jumlah Tamu: ${res['guests']} Orang'),
                              Text('📞 No HP: ${res['phone']}'),
                              if (res['status'] == 'Rejected' && res['rejectReason'].toString().isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  'Alasan Penolakan: ${res['rejectReason']}',
                                  style: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                                ),
                              ],
                              if (isPending) ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                                        onPressed: () => _showRejectDialog(index),
                                        child: const Text('Tolak'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () => _updateStatus(index, 'Accepted'),
                                        child: const Text('Terima'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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