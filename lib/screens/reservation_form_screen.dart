import 'package:flutter/material.dart';

class ReservationFormScreen extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const ReservationFormScreen({super.key, required this.restaurant});

  @override
  State<ReservationFormScreen> createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  int _selectedGuests = 2;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 19, minute: 0);

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF6B00)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF6B00)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservasi Meja'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant, color: Color(0xFFFF6B00)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Restoran Tujuan:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(
                            widget.restaurant['name'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Nama Pemesan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.grey[150],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pemesan tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Jumlah Kursi / Tamu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _selectedGuests,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.group_outlined),
                  filled: true,
                  fillColor: Colors.grey[150],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                items: List.generate(10, (index) => index + 1).map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value Orang Kursi'),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGuests = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tanggal Reservasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _pickDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[150],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jam Reservasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _pickTime(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[150],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time, size: 18, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text(_selectedTime.format(context), style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Catatan Khusus (Opsional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Contoh: Minta dekat jendela, kursi bayi, dll.',
                  filled: true,
                  fillColor: Colors.grey[150],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B00),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // RELASI ID & DATA SESUAI INSTRUKSI DOSEN
                    Map<String, dynamic> newReservation = {
                      'id': DateTime.now().toString(),
                      'restaurantName': widget.restaurant['name'], // Relasi ke ID/Nama Resto
                      'name': _nameController.text.trim(),         // customerName
                      'guests': _selectedGuests,                     // guestCount
                      'date': '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                      'time': _selectedTime.format(context),
                      'notes': _notesController.text.trim(),
                      'rawDate': _selectedDate,                      // Untuk validasi H-1
                    };

                    Navigator.pop(context, newReservation);
                  }
                },
                child: const Text('Simpan Reservasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}