import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_data.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Daftar akun baru di Firebase Auth + simpan profil di Firestore.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _db.collection('users').doc(cred.user!.uid).set({
      'name': name,
      'email': email,
      'phone': '',
      'city': '',
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Login, isi UserData, lalu kembalikan role ("user" / "admin").
  Future<String> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return await loadUserData(cred.user!.uid);
  }

  /// Ambil data user dari Firestore dan isi ke UserData.
  /// splash screen untuk user yang sudah login.
  Future<String> loadUserData(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data() ?? {};
    UserData.name = data['name'] ?? '';
    UserData.email = data['email'] ?? '';
    UserData.phone = data['phone'] ?? '';
    UserData.city = data['city'] ?? '';
    UserData.password = ''; // Firebase tidak memberikan password
    return data['role'] ?? 'user';
  }

  Future<void> logout() async {
    await _auth.signOut();
    UserData.name = '';
    UserData.email = '';
    UserData.password = '';
    UserData.phone = '';
    UserData.city = '';
  }

  static String errorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Silakan login.';
      case 'weak-password':
        return 'Password terlalu lemah.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email atau password salah.';
      case 'network-request-failed':
        return 'Tidak ada koneksi internet.';
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }
}