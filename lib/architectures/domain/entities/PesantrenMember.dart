import 'dart:convert';

class PesantrenMember {
  final int id;
  final String name;
  final String picture;
  final String birth;
  final int studentClass;
  final String like;
  final String notlike;
  const PesantrenMember({
    required this.id,
    required this.name,
    required this.picture,
    required this.birth,
    required this.studentClass,
    required this.like,
    required this.notlike,
  });

  PesantrenMember copyWith({
    int? id,
    String? name,
    String? picture,
    String? birth,
    int? studentClass,
    String? like,
    String? notlike,
  }) {
    return PesantrenMember(
      id: id ?? this.id,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      birth: birth ?? this.birth,
      studentClass: studentClass ?? this.studentClass,
      like: like ?? this.like,
      notlike: notlike ?? this.notlike,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'picture': picture});
    result.addAll({'birth': birth});
    result.addAll({'studentClass': studentClass});
    result.addAll({'like': like});
    result.addAll({'notlike': notlike});

    return result;
  }

  factory PesantrenMember.fromMap(Map<String, dynamic> map) {
    return PesantrenMember(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      picture: map['picture'] ?? '',
      birth: map['birth'] ?? '',
      studentClass: map['studentClass']?.toInt() ?? 0,
      like: map['like'] ?? '',
      notlike: map['notlike'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PesantrenMember.fromJson(String source) =>
      PesantrenMember.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PesantrenMember(id: $id, name: $name, picture: $picture, birth: $birth, studentClass: $studentClass, like: $like, notlike: $notlike)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PesantrenMember &&
        other.id == id &&
        other.name == name &&
        other.picture == picture &&
        other.birth == birth &&
        other.studentClass == studentClass &&
        other.like == like &&
        other.notlike == notlike;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        birth.hashCode ^
        studentClass.hashCode ^
        like.hashCode ^
        notlike.hashCode;
  }
}
