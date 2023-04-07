import 'package:flutter/material.dart';

enum PertanyaanEvaluasi {
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

extension PertanyaanEvaluasiExtension on PertanyaanEvaluasi {
  static const labelMap = {
    PertanyaanEvaluasi.pertanyaan1: "Anak menggunakan gadget untuk belajar",
    PertanyaanEvaluasi.pertanyaan2: "Anak didampingi saat menggunakan gadget",
    PertanyaanEvaluasi.pertanyaan3:
        "Anak mematuhi jadwal penggunaan gadget yang telah disepakati",
    PertanyaanEvaluasi.pertanyaan4: "Anak dapat berkomunikasi dengan santun",
    PertanyaanEvaluasi.pertanyaan5: "Anak tidak menonton konten kekerasan",
    PertanyaanEvaluasi.pertanyaan6: "Anak tidak menonton konten pornografi",
    PertanyaanEvaluasi.pertanyaan7:
        "Anak menggunakan gadget kurang dari 3 jam sehari",
    PertanyaanEvaluasi.pertanyaan8: "Anak tidak menonton konten mistik",
    PertanyaanEvaluasi.pertanyaan9:
        "Anak tidak menirukan gaya tokoh yang tidak baik",
    PertanyaanEvaluasi.pertanyaan10:
        "Anak mematuhi perintah orang tua saat menggunakan gadget",
  };
  String get label => labelMap[this] ?? "";
}
