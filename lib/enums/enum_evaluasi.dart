import 'package:flutter/material.dart';

enum Evaluasi {
  pertanyaan1,
  pertanyaan2,
  pertanyaan3,
  pertanyaan4,
  pertanyaan5,
  pertanyaan6,
  pertanyaan7,
  pertanyaan8,
  pertanyaan9,
  pertanyaan10,
}

extension EvaluasiExtension on Evaluasi {
  static const labelMap = {
    Evaluasi.pertanyaan1: "Anak menggunakan gadget untuk belajar",
    Evaluasi.pertanyaan2: "Anak didampingi saat menggunakan gadget",
    Evaluasi.pertanyaan3:
        "Anak mematuhi jadwal penggunaan gadget yang telah disepakati",
    Evaluasi.pertanyaan4: "Anak dapat berkomunikasi dengan santun",
    Evaluasi.pertanyaan5: "Anak tidak menonton konten kekerasan",
    Evaluasi.pertanyaan6: "Anak tidak menonton konten pornografi",
    Evaluasi.pertanyaan7: "Anak menggunakan gadget kurang dari 3 jam sehari",
    Evaluasi.pertanyaan8: "Anak tidak menonton konten mistik",
    Evaluasi.pertanyaan9: "Anak tidak menirukan gaya tokoh yang tidak baik",
    Evaluasi.pertanyaan10:
        "Anak mematuhi perintah orang tua saat menggunakan gadget",
  };
  String get label => labelMap[this] ?? "";
}
