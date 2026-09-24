import 'package:flutter/material.dart';

class ReservationHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> reservations;
  final Function(String id, Map<String, dynamic> updatedData) onUpdate;
  final Function(String id) onDelete;

  const ReservationHistoryScreen({
    super.key,
    required this.reservations,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<ReservationHistoryScreen> createState() => _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  
  // Fungsi Cek apakah masih bisa diedit/dihapus (Minimal H-1 dari hari reservasi)
  bool _canModify(DateTime? rawDate) {
    if (rawDate == null) return true;
    final now = DateTime.now();
    final difference = rawDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    // Boleh edit/hapus jika selisih minimal 1 hari (H-1 atau lebih jauh)
    return difference >= 1;
  }

  // Dialog Edit Reservasi (Update)
  void _showEditDialog(Map<String, dynamic> reservation) {
    final nameController = TextEditingController(text: reservation['name']);
    final notesController = TextEditingController(text: reservation['notes']);
    int guests = reservation['guests'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Reservasi Meja'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Restoran: ${reservation['restaurantName']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 16),
                const Text('Nama Pemesan'),
                TextField(controller: nameController),
                const SizedBox(height: 12),
                const Text('Jumlah Kursi'),
                DropdownButton<int>(
                  value: guests,
                  isExpanded: true,
                  items: List.generate(10, (index) => index + 1).map((val) {
                    return DropdownMenuItem(value: val, child: Text('$val Orang'));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      guests = val!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                const Text('Catatan Khusus'),
                TextField(controller: notesController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B00)),
              onPressed: () {
                final updatedData = {
                  ...reservation,
                  'name': nameController.text.trim(),
                  'guests': guests,
                  'notes': notesController.text.trim(),
                };
                widget.onUpdate(reservation['id'], updatedData);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reservasi berhasil diperbarui!')),
                );
              },
              child: const Text('Simpan', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Reservasi Meja'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: widget.reservations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_busy, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text('Belum ada riwayat reservasi meja.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.reservations.length,
              itemBuilder: (context, index) {
                final res = widget.reservations[index];
                final bool allowAction = _canModify(res['rawDate']);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
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
                                res['restaurantName'],
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFF6B00)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.green.withOpacity(0.3)),
                              ),
                              child: const Text('Aktif', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text('Pemesan: ${res['name']}', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.group, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text('Jumlah Kursi: ${res['guests']} Orang', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text('Waktu: ${res['date']} pukul ${res['time']}', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        if (res['notes'] != null && res['notes'].toString().isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.note, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(child: Text('Catatan: ${res['notes']}', style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey))),
                            ],
                          ),
                        ],
                        const SizedBox(height: 16),
                        
                        // Tombol Aksi (Edit & Hapus dengan validasi H-1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!allowAction)
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text('*Melewati batas H-1', style: TextStyle(color: Colors.red, fontSize: 11)),
                              ),
                            OutlinedButton.icon(
                              onPressed: allowAction ? () => _showEditDialog(res) : null,
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Edit'),
                              style: OutlinedButton.styleFrom(foregroundColor: Colors.blue),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: allowAction
                                  ? () {
                                      widget.onDelete(res['id']);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Reservasi dibatalkan/dihapus.')),
                                      );
                                    }
                                  : null,
                              icon: const Icon(Icons.delete, size: 16),
                              label: const Text('Batalkan'),
                              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}