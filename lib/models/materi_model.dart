import 'dart:ui';

class ModelMateri {
  final String image;
  final String title;
  final Color color;
  final int diamond;

  ModelMateri(this.image, this.title, this.color, this.diamond);
}

List<ModelMateri> materi = [
  ModelMateri(
      "images/mekanika.svg", "Listrik Magnet", const Color(0xFFF28FE6), 10),
  ModelMateri("images/gelombang.svg", "Gelombang", const Color(0xFF9187FF), 10),
  ModelMateri("images/mekanika.svg", "Mekanika", const Color(0xFFFF8C82), 10),
];
