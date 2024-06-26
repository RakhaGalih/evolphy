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
