import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateToString(Timestamp time) {
  // Mengubah string ke objek DateTime
  DateTime tanggalWaktuObj = time.toDate();

  // Mengubah objek DateTime ke format yang diinginkan
  String tanggalWaktuFormatBaru =
      DateFormat('d MMMM y HH:mm', 'id_ID').format(tanggalWaktuObj);

  // Hasil
  return tanggalWaktuFormatBaru; // Output: 25 Juni 2024 22:02
}

String formatTanggal(Timestamp time) {
  DateTime sekarang = DateTime.now();
  DateTime tanggalWaktu = time.toDate();

  Duration perbedaan = sekarang.difference(tanggalWaktu);

  if (perbedaan.inDays >= 7) {
    // Jika lebih dari 7 hari, tampilkan dalam format tanggal lengkap
    return DateFormat('d MMMM y HH:mm', 'id_ID').format(tanggalWaktu);
  } else if (perbedaan.inDays >= 1) {
    // Jika lebih dari atau sama dengan 1 hari, tampilkan sebagai "X hari yang lalu"
    return '${perbedaan.inDays} hari yang lalu';
  } else if (perbedaan.inHours >= 1) {
    // Jika lebih dari atau sama dengan 1 jam, tampilkan sebagai "X jam yang lalu"
    return '${perbedaan.inHours} jam yang lalu';
  } else if (perbedaan.inMinutes >= 1) {
    // Jika lebih dari atau sama dengan 1 menit, tampilkan sebagai "X menit yang lalu"
    return '${perbedaan.inMinutes} menit yang lalu';
  } else {
    // Jika kurang dari 1 menit, tampilkan sebagai "baru saja"
    return 'baru saja';
  }
}

bool areValuesEqual(String value1, String value2) {
  // Fungsi untuk mengonversi string ke nilai double setelah normalisasi
  double? parseValue(String value) {
    // Hapus spasi di sekitar string dan ganti koma dengan titik
    value = value.trim().replaceAll(',', '.');

    // Periksa jika string kosong setelah trim
    if (value.isEmpty) {
      print("Empty or invalid value: '$value'");
      return 0.0;
    }

    // Coba konversi ke double, jika gagal kembalikan null
    try {
      print(value);
      return double.parse(value);
    } catch (e) {
      print("Error parsing '$value': $e");
      return null;
    }
  }

  // Normalisasi dan konversi kedua nilai
  double? num1 = parseValue(value1);
  double? num2 = parseValue(value2);

  // Jika salah satu nilai null, anggap tidak sama
  if (num1 == null || num2 == null) {
    return false;
  }

  // Bandingkan kedua nilai
  return num1 == num2;
}
