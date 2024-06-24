import 'package:evolphy/components/soal.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:flutter/material.dart';

List<List<SoalCircleFloat>> listKebenaranSoal = [
  [
    const SoalCircleFloat(no: 1, isTrue: false),
    const SoalCircleFloat(no: 8, isTrue: true),
    const SoalCircleFloat(no: 10, isTrue: true),
  ],
  [
    const SoalCircleFloat(no: 2, isTrue: true),
    const SoalCircleFloat(no: 4, isTrue: false),
    const SoalCircleFloat(no: 7, isTrue: true),
  ],
];

List<List<int>> listKategoriSoal = [
  [1, 8, 10],
  [2, 4, 7],
  [
    3,
    5,
  ],
  [
    6,
    9,
  ],
];

List<bool> kebenaranSoal = [
  true,
  false,
  false,
  true,
  true,
  true,
  false,
  true,
  true,
  false
];

TextEditingController soal1controller = TextEditingController();
TextEditingController soal2controller = TextEditingController();
TextEditingController soal3controller = TextEditingController();
TextEditingController soal4controller = TextEditingController();
TextEditingController soal5controller = TextEditingController();
TextEditingController soal6controller = TextEditingController();
TextEditingController soal7controller = TextEditingController();
TextEditingController soal8controller = TextEditingController();
TextEditingController soal9controller = TextEditingController();
TextEditingController soal10controller = TextEditingController();

List<Soal> listSoal = [
  Soal(
    soal:
        'Dua bola identik dilepaskan dari ketinggian yang sama namun bola pertama diberikan kecepatan horisontal awal sebesar 𝑣 sedangkan bola kedua tidak. Diketahui bahwa bola pertama mengenai batu setinggi 5 m yang berada pada jarak 𝑑 dari titik awal, sedangkan bola kedua terdengar mengenai tanah beberapa saat kemudian.',
    pertanyaan:
        'Jika diketahui bahwa 𝑔𝑑 2 𝑣 2 = 20 m, maka ketinggian awal bola kedua adalah ... m.',
    controller: soal1controller,
  ),
  Soal(
    soal:
        'Silinder bermassa 𝑚 = 1 kg dengan jejari 𝑟 = 1 cm dalam keadaan diam ditopang balok pada titik B. Balok kemudian ditarik sehingga balok bergeser dengan laju konstan 𝑣 = 0,2 m/s menjauhi silinder. Asumsikan awalnya balok sangat dekat dengan dinding. Abaikan silinder dengan dinding dan bola. Jarak A-B sama dengan √2 cm.',
    pertanyaan: 'Gaya besar yang diberikan dinding pada silinder adalah ... N.',
    controller: soal2controller,
  ),
  Soal(
    soal:
        'Bola bilier dengan massa 𝑚 = 200 gram dan diameter 𝑑 = 6 cm terletak pada meja horizontal dengan koefisien gesek kinetik antara bola dengan meja adalah 𝜇. Bola dipukul dari titik setinggi 𝑦 di atas garis diameter yang sejajar meja. Bola bergerak menggelinding secara murni.',
    pertanyaan: 'Nilai 𝑦 =…. Mm.',
    controller: soal3controller,
  ),
  Soal(
    soal:
        'Sebuah partikel bermassa 𝑚 = 100 g dilontarkan secara horizontal oleh sebuah pegas berkonstanta 𝑘 = 100 N/m dari pinggir sebuah tebing yang memiliki ketinggian ℎ = 5 m dari permukaan laut. Benda mulanya ditekan ke arah pegas sejauh 𝑥 = 20 cm, kemudian dilepaskan. Terdapat tebing lain dengan ketinggian yang sama berjarak 𝑑 = 3 m dari tebing pertama.',
    pertanyaan:
        'Jika tiap tumbukan dianggap elastis, partikel akan memantul sebanyak ... kali sebelum sampai ke permukaan laut.',
    controller: soal4controller,
  ),
  Soal(
    soal:
        'Sebuah ember yang bermassa 𝑀 = 0.582 kg penuh berisi air dengan massa 1 kg mula-mula diam di tanah. Ember tersebut ditarik dengan gaya 𝐹0 = 17 N ke atas. Karena terdapat lubang pada bagian bawah ember, air di dalam ember bocor keluar dengan jumlah air persatuan waktu yang konstan dengan kelajuan nol relatif terhadap ember tersebut.',
    pertanyaan:
        'Saat waktu 𝑇 = 8 detik, air di dalam ember tersebut kosong. Kecepatan ember pada waktu 𝑇 sama dengan .... m/s.',
    controller: soal5controller,
  ),
  Soal(
    soal:
        'Sebuah bola dengan massa 0.5 kg terikat pada ujung tali yang sangat ringan dan melakukan gerak rotasi vertikal dengan jari-jari 75 cm. Bola memiliki kecepatan 5 m/s pada saat posisi talinya mendatar.',
    pertanyaan:
        'Nilai percepatan gravitasi dianggap 𝑔 = 9.8 m/s 2 . Gaya tegagan tali saat bola berada di titik terendah lingkaran adalah .... N.',
    controller: soal6controller,
  ),
  Soal(
    soal:
        'Dua buah peluru ditembakkan secara bersamaan dengan kecepatan awal 𝑣0 = 25 m/s dari ketinggian ℎ = 25 m. Peluru pertama bersudut 𝜃 terhadap horizontal, sedangkan peluru kedua bersudut awal 180° terhadap peluru pertama. Nilai cos 𝜃 = 0.6.',
    pertanyaan:
        'Ketika kedua peluru mencapai tanah, jarak antara keduanya adalah .... meter',
    controller: soal7controller,
  ),
  Soal(
    soal:
        'Sebuah batang tipis homogen AB bermassa 𝑚 = 1.0 kg bergerak translasi dengan percepatan 𝑎 = 2.0 m/s 2 akibat dua gaya yang saling berlawanan 𝐹1 dan 𝐹2 (lihat gambar). Jarak antara titik-titik di mana gaya-gaya ini diterapkan adalah 𝑏 = 20 cm.',
    pertanyaan:
        'Jika diketahui 𝐹2 = 5.0 N maka panjang batang tersebut ... m.',
    controller: soal8controller,
  ),
  Soal(
    soal:
        'Dua buah balok identik bermassa 𝑚𝐵 = 1 kg diletakkan di atas papan panjang bermassa 𝑚𝑃 = 4 kg yang akan ditarik dengan gaya 𝐹. Koefisien gesek statik antara balok 1 dan 2 dengan papan masing-masing adalah 𝜇𝑠1 = 0.8 dan 𝜇𝑠2 = 𝜇𝑠1/2, sedangkan koefisien gesek kinetiknya sama sebesar 𝜇𝑘 = 0.3.',
    pertanyaan:
        'Agar kedua balok dapat bertumbukan, dan jika 𝐹 minimum dan maksimum masing-masing bernilai 𝑝 dan 𝑞, maka 𝑝 + 𝑞 adalah ... N.',
    controller: soal9controller,
  ),
  Soal(
    soal:
        'Sebuah batang dengan panjang 𝐿 = 4 m bermassa 𝑚1 = 1 kg diletakkan di atas dua silinder pejal identik berjari-jari 𝑟 = 80 cm dengan massa total 𝑚2 = 2 kg. Sistem tersebut mula-mula diam dan berada di atas bidang miring dengan sudut 𝜃 = 30°. Posisi kedua silinder hampir saling bersentuhan dan awalnya ujung bawah batang tepat ada di atas silinder depan. ',
    pertanyaan:
        'Jika permukaannya sangat kasar sehingga gaya-gaya gesek kedua silinder sama, maka waktu yang dibutuhkan agar ujung atas batang menyentuh silinder belakang adalah ... s.',
    controller: soal9controller,
  ),
];
