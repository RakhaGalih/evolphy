// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:evolphy/constants/constant.dart';

class ModelJudulMateri {
  final String image;
  final String title;
  final String desc;
  final Color color;
  final int diamond;
  List<ModelMateri> listMateri;

  ModelJudulMateri(
    this.image,
    this.title,
    this.desc,
    this.color,
    this.diamond,
    this.listMateri,
  );
}

class ModelMateri {
  final String image;
  final String title;
  final String pdf;
  final String desc;
  final List<VideoYoutube> listYoutube;
  final Color color;

  ModelMateri(
    this.image,
    this.title,
    this.color,
    this.pdf,
    this.listYoutube,
    this.desc,
  );
}

class VideoYoutube {
  String title;
  String link;
  VideoYoutube(
    this.title,
    this.link,
  );
}

List<ModelJudulMateri> listJudulMateris = [
  ModelJudulMateri(
      "images/mekanika.svg",
      "Kategori Kinematika",
      "Kinematika adalah cabang dari mekanika klasik yang membahas gerak benda dan sistem benda tanpa mempersoalkan gaya penyebab gerakan.",
      kPink,
      10,
      materiKinematika),
  ModelJudulMateri(
      "images/gelombang.svg",
      "Dinamika Linier",
      "Dinamika linear adalah cabang dari dinamika sistem yang mempelajari perilaku sistem yang dapat dimodelkan dengan persamaan linear.",
      kPurple,
      10,
      materiDinamikaLinier),
  ModelJudulMateri(
      "images/mekanika.svg",
      "Dinamika Rotasi",
      "Dinamika rotasi adalah cabang dari mekanika yang mempelajari gerakan benda yang berputar atau berotasi.",
      kOrange,
      10,
      materiRotasi),
];

List<ModelMateri> materiKinematika = [
  ModelMateri(
      "pensil.png",
      "Gerak Lurus",
      kBlue,
      "/gerak_lurus.pdf",
      listVideo1_1,
      "Dalam materi ini, kita akan membahas konsep dasar gerak lurus, jenis-jenis gerak lurus, serta penerapannya dalam kehidupan sehari-hari. Gerak lurus adalah salah satu bentuk gerakan paling mendasar dalam fisika di mana suatu objek bergerak sepanjang garis lurus. Kita akan mempelajari perbedaan antara gerak lurus beraturan (GLB) dan gerak lurus berubah beraturan (GLBB), serta bagaimana menggunakan rumus-rumus dasar untuk menghitung jarak, kecepatan, dan percepatan. Melalui video ini, kamu akan mendapatkan pemahaman yang lebih baik tentang bagaimana objek bergerak dan bagaimana menganalisis gerakan tersebut menggunakan konsep-konsep fisika dasar."),
  ModelMateri(
      "basket.png",
      "Gerak Parabola",
      kPink,
      "/gerak_parabola.pdf",
      listVideo1_2,
      "Dalam materi ini, kita akan mengeksplorasi konsep gerak parabola, sebuah gerakan dua dimensi di mana sebuah objek mengikuti lintasan berbentuk kurva parabola. Gerak parabola sering ditemui dalam kehidupan sehari-hari, seperti dalam olahraga atau peluncuran proyektil. Kita akan membahas komponen horizontal dan vertikal dari gerakan ini, serta bagaimana keduanya berinteraksi untuk membentuk lintasan parabolik. Selain itu, kita akan mempelajari rumus-rumus penting yang digunakan untuk menghitung jarak, waktu, kecepatan, dan ketinggian maksimum objek dalam gerak parabola. Video ini akan membantu kamu memahami dinamika gerak parabola dan cara menganalisisnya secara fisika."),
  ModelMateri(
      "bianglala.png",
      "Gerak Melingkar",
      kYellow,
      "/gerak_melingkar.pdf",
      listVideo1_3,
      "Dalam materi ini, kita akan mempelajari gerak melingkar, yaitu gerakan suatu objek yang mengikuti lintasan berbentuk lingkaran. Gerak melingkar sering ditemukan dalam berbagai fenomena alam dan teknologi, seperti gerakan planet mengelilingi matahari atau putaran roda. Kita akan membahas berbagai konsep penting, termasuk kecepatan sudut, percepatan sentripetal, dan perioda. Selain itu, kita akan memahami perbedaan antara gerak melingkar beraturan (dengan kecepatan sudut konstan) dan gerak melingkar tidak beraturan (dengan percepatan sudut). Melalui video ini, kamu akan mendapatkan pengetahuan dasar yang diperlukan untuk menganalisis dan memahami gerak melingkar dalam berbagai konteks fisika."),
];

List<ModelMateri> materiDinamikaLinier = [
  ModelMateri(
      "kilat.png",
      "Hukum Newton",
      kPink,
      "/hukum_newton.pdf",
      listVideo2_1,
      "Dalam materi ini, kita akan mendalami Hukum Newton, yang merupakan dasar dari dinamika dalam fisika. Hukum-hukum ini menjelaskan bagaimana gaya mempengaruhi gerak suatu objek. Ada tiga Hukum Newton yang akan kita bahas:\n\n- Hukum Pertama Newton (Hukum Inersia): Menyatakan bahwa sebuah objek akan tetap dalam keadaan diam atau bergerak lurus beraturan kecuali ada gaya eksternal yang mengubah keadaan tersebut.\n\n- Hukum Kedua Newton: Menghubungkan percepatan suatu objek dengan gaya yang bekerja padanya dan massanya melalui persamaan 𝐹 = 𝑚𝑎\nHukum Ketiga Newton: Menyatakan bahwa setiap aksi memiliki reaksi yang sama besar tetapi berlawanan arah."),
  ModelMateri("ion.png", "Gaya Normal & Gaya Gesek", kBlue, "", listVideo2_2,
      "Dalam materi ini, kita akan membahas dua gaya penting yang sering berperan dalam berbagai situasi fisika: gaya normal dan gaya gesek.\n\n- Gaya Normal: Ini adalah gaya yang bekerja tegak lurus terhadap permukaan kontak antara dua objek. Gaya ini muncul sebagai reaksi terhadap gaya gravitasi yang menarik objek ke bawah, menjaga objek tetap berada di permukaan tanpa jatuh menembusnya.\n\n- Gaya Gesek: Ini adalah gaya yang bekerja sejajar dengan permukaan kontak antara dua objek, melawan gerakan relatif antara keduanya. Ada dua jenis gaya gesek yang akan kita pelajari: gaya gesek statis (yang mencegah gerak awal) dan gaya gesek kinetis (yang menentang gerakan saat objek sudah bergerak)."),
  ModelMateri("listrik.png", "Usaha, Energi, & Daya", kOrange, "", listVideo2_3,
      "Materi ini membahas konsep-konsep fundamental dalam fisika yang terkait dengan perubahan keadaan fisik suatu sistem melalui interaksi gaya. Usaha adalah jumlah energi yang ditransfer oleh gaya yang menyebabkan perpindahan. Dalam fisika, usaha dihitung sebagai hasil kali gaya yang bekerja pada suatu benda dengan jarak perpindahan benda tersebut dalam arah gaya. Energi adalah kemampuan untuk melakukan usaha. Terdapat berbagai bentuk energi, seperti energi kinetik (energi gerak), energi potensial (energi posisi), dan energi mekanik (kombinasi energi kinetik dan potensial). Daya adalah laju usaha yang dilakukan atau energi yang ditransfer dalam satuan waktu. Memahami hubungan antara usaha, energi, dan daya sangat penting untuk menganalisis sistem mekanik, efisiensi mesin, dan berbagai fenomena alam yang melibatkan perubahan energi. Materi ini juga akan mencakup hukum kekekalan energi, yang menyatakan bahwa energi tidak dapat diciptakan atau dimusnahkan, hanya dapat berubah bentuk."),
  ModelMateri(
      "pensil.png",
      "Momentum Linear dan Impuls",
      kYellow,
      "/momentum.pdf",
      listVideo2_4,
      "Materi ini akan mengajak kamu untuk memahami konsep momentum linear dan impuls dalam fisika. Momentum linear adalah besaran yang menggambarkan kuantitas gerak sebuah objek dan dihitung sebagai hasil kali massa dan kecepatan objek tersebut. Momentum linear sangat penting dalam analisis gerak karena menunjukkan seberapa sulitnya menghentikan objek yang bergerak. Sementara itu, impuls adalah perubahan momentum yang terjadi ketika gaya bekerja pada objek selama selang waktu tertentu. Impuls dapat dinyatakan sebagai hasil kali gaya dan waktu gaya tersebut bekerja. Konsep impuls dan momentum linear saling terkait erat dan memainkan peran kunci dalam hukum kekekalan momentum, yang menyatakan bahwa dalam sistem tertutup tanpa gaya eksternal, total momentum linear tetap konstan. Melalui video ini, kamu akan mempelajari bagaimana menghitung momentum dan impuls, serta bagaimana menerapkan prinsip-prinsip ini dalam berbagai situasi, seperti tabrakan dan ledakan, untuk memahami dinamika sistem fisika dengan lebih baik."),
];

List<ModelMateri> materiRotasi = [
  ModelMateri(
      "bianglala.png",
      "Dinamika Rotasi Dan Kesetimbangan",
      kYellow,
      "/rotasi.pdf",
      listVideo3_1,
      "Materi ini akan memperkenalkan kamu pada konsep-konsep penting dalam dinamika rotasi dan kesetimbangan. Dinamika rotasi mengkaji gerak objek yang berputar di sekitar sumbu tertentu, mencakup konsep seperti momen inersia, torsi, dan kecepatan sudut. Momen inersia menggambarkan bagaimana massa objek didistribusikan relatif terhadap sumbu rotasi dan mempengaruhi resistensi objek terhadap perubahan dalam gerak rotasinya. Torsi adalah gaya yang menyebabkan objek berputar, setara dengan gaya kali lengan momen. Selain itu, kita akan mempelajari hukum kedua Newton dalam bentuk rotasi dan bagaimana menerapkannya untuk memahami gerak rotasi objek.\n\nKesetimbangan membahas kondisi di mana objek berada dalam keadaan seimbang, baik dalam translasi maupun rotasi. Kesetimbangan statis terjadi ketika objek tidak bergerak, sementara kesetimbangan dinamis terjadi ketika objek bergerak dengan kecepatan konstan. Dalam kesetimbangan, jumlah gaya dan jumlah torsi yang bekerja pada objek harus sama dengan nol. Melalui video ini, kamu akan memahami bagaimana menganalisis situasi kesetimbangan dan menggunakan prinsip-prinsip dinamika rotasi untuk memecahkan masalah yang melibatkan objek yang berputar."),
];

List<VideoYoutube> listVideo1_1 = [
  VideoYoutube(
      "Gerak Lurus • Part 1: Gerak Lurus Beraturan (GLB) dan Gerak Lurus Berubah Beraturan (GLBB)",
      "https://www.youtube.com/watch?v=lt4bRdWowGI"),
  VideoYoutube(
      "Gerak Lurus • Part 2: Contoh Soal Gerak Lurus Beraturan (GLB) & Gerak Lurus Berubah Beraturan (GLBB)",
      "https://www.youtube.com/watch?v=-l6Th8W0-iU"),
  VideoYoutube(
      "Gerak Lurus • Part 3: Variasi Gerak Lurus / Kasus Bertemu dan Menyusul",
      "https://www.youtube.com/watch?v=4Y_nHzSOm1c"),
  VideoYoutube(
      "Gerak Lurus • Part 4: Contoh Soal Variasi Gerak Lurus / Kasus Bertemu & Menyusul",
      "https://www.youtube.com/watch?v=MNtAXylJb7Q"),
  VideoYoutube(
      "Gerak Lurus • Part 5: Gerak Vertikal Atas (GVA), Gerak Vertikal Bawah (GVB), Gerak Jatuh Bebas (GJB)",
      "https://www.youtube.com/watch?v=WDAaUBWZIaI"),
  VideoYoutube("Gerak Lurus • Part 6: Contoh Soal Gerak Vertikal Atas (GVA)",
      "https://www.youtube.com/watch?v=YdSySM6nvM0"),
  VideoYoutube(
      "Gerak Lurus • Part 7: Contoh Soal Gerak Vertikal (GVA & GVB), Gerak Jatuh Bebas (GJB)",
      "https://www.youtube.com/watch?v=Lp62iQwES38"),
  VideoYoutube("Latihan Soal UTBK SBMPTN Eps. 25 • TKA Fisika • Gerak Lurus",
      "https://www.youtube.com/watch?v=iHJI66Mqfjs")
];

List<VideoYoutube> listVideo1_2 = [
  VideoYoutube(
      "Gerak Parabola • Part 1: Konsep, Skema, dan Rumus Gerak Parabola",
      "https://www.youtube.com/watch?v=Qe6tWnm5ivk"),
  VideoYoutube(
      "Gerak Parabola • Part 2: Contoh Soal Gerak Parabola Dimulai dari Tanah",
      "https://www.youtube.com/watch?v=OuPe4YKOiI8"),
  VideoYoutube(
      "Gerak Parabola • Part 3: Contoh Soal Gerak Parabola Dimulai dari Ketinggian Tertentu",
      "https://www.youtube.com/watch?v=5UThNK0thOA"),
  VideoYoutube(
      "Gerak Parabola • Part 4: Contoh Soal Gerak Parabola Pesawat Menjatuhkan Bom",
      "https://www.youtube.com/watch?v=qkFM9oiSeUo"),
  VideoYoutube("Gerak Parabola • Part 5: Contoh Soal Variasi Gerak Parabola",
      "https://www.youtube.com/watch?v=QuMjKA9qH1o")
];

List<VideoYoutube> listVideo1_3 = [
  VideoYoutube(
      "Gerak Melingkar • Part 1: Sudut Radian & Gerak Melingkar Beraturan (GMB)",
      "https://www.youtube.com/watch?v=ZMSciW3XC20"),
  VideoYoutube(
      "Gerak Melingkar • Part 2: Contoh Soal Gerak Melingkar Beraturan (GMB)",
      "https://www.youtube.com/watch?v=a5ql7UzKekk"),
  VideoYoutube(
      "Gerak Melingkar • Part 3: Hubungan Roda Roda (Sepusat, Bersinggungan, Dihubungkan dengan Tali)",
      "https://www.youtube.com/watch?v=MipvgNMYPds"),
  VideoYoutube(
      "Gerak Melingkar • Part 4: Gerak Melingkar Berubah Beraturan (GMBB)",
      "https://www.youtube.com/watch?v=rZVsfH-qQ_A"),
  VideoYoutube(
      "Dinamika Partikel Fisika Kelas 10 • Part 8: Contoh Soal Dinamika Gerak Melingkar",
      "https://www.youtube.com/watch?v=t107XRGnLCU")
];

List<VideoYoutube> listVideo2_1 = [
  VideoYoutube("Video 19: Judul Video 19",
      "https://www.youtube.com/watch?v=24P12dFuXMo"),
  VideoYoutube(
      "Video 20: Judul Video 20", "https://www.youtube.com/watch?v=b0p-TfNOXvw")
];

List<VideoYoutube> listVideo2_2 = [
  VideoYoutube("Video 21: Judul Video 21",
      "https://www.youtube.com/watch?v=e9ME0j11sFc"),
  VideoYoutube("Video 22: Judul Video 22",
      "https://www.youtube.com/watch?v=b0p-TfNOXvw"),
  VideoYoutube("Video 23: Judul Video 23",
      "https://www.youtube.com/watch?v=z-rhG72d-Ys"),
  VideoYoutube("Video 24: Judul Video 24",
      "https://www.youtube.com/watch?v=VtHpsE028Rs"),
  VideoYoutube("Video 25: Judul Video 25",
      "https://www.youtube.com/watch?v=nDtzyBkVcRs"),
  VideoYoutube(
      "Video 26: Judul Video 26", "https://www.youtube.com/watch?v=D1Fo6YqPNCI")
];

List<VideoYoutube> listVideo2_3 = [
  VideoYoutube("Video 27: Judul Video 27",
      "https://www.youtube.com/watch?v=sAqRHwd_RI0"),
  VideoYoutube("Video 28: Judul Video 28",
      "https://www.youtube.com/watch?v=bfS0ctFzaPY"),
  VideoYoutube("Video 29: Judul Video 29",
      "https://www.youtube.com/watch?v=s0Yne8CPYi8"),
  VideoYoutube("Video 30: Judul Video 30",
      "https://www.youtube.com/watch?v=ZK00Bf-XfxY"),
  VideoYoutube("Video 31: Judul Video 31",
      "https://www.youtube.com/watch?v=BgLM_aUlFIw"),
  VideoYoutube("Video 32: Judul Video 32",
      "https://www.youtube.com/watch?v=qQs4CwkjCDo"),
  VideoYoutube(
      "Video 33: Judul Video 33", "https://www.youtube.com/watch?v=n75pARW8bSw")
];

List<VideoYoutube> listVideo2_4 = [
  VideoYoutube(
      "Video 34: Judul Video 34", "https://www.youtube.com/watch?v=LnIK7-8vrME")
];

List<VideoYoutube> listVideo3_1 = [
  VideoYoutube("Video 35: Judul Video 35",
      "https://www.youtube.com/watch?v=Ips5CHxg75A"),
  VideoYoutube("Video 36: Judul Video 36",
      "https://www.youtube.com/watch?v=sDBGL24Tz3U"),
  VideoYoutube("Video 37: Judul Video 37",
      "https://www.youtube.com/watch?v=VLryJRgGzf0"),
  VideoYoutube("Video 38: Judul Video 38",
      "https://www.youtube.com/watch?v=4d_er9vHDPc"),
  VideoYoutube("Video 39: Judul Video 39",
      "https://www.youtube.com/watch?v=wrDXMKJr4mk"),
  VideoYoutube("Video 40: Judul Video 40",
      "https://www.youtube.com/watch?v=4R80A2JWyuw"),
  VideoYoutube(
      "Video 41: Judul Video 41", "https://www.youtube.com/watch?v=vGO-DOfGZ44")
];
