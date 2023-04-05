import 'dart:convert';

class FamilyMember {
  final int id;
  final String name;
  final String gender;
  final String picture;
  final String birth;
  final int childRank;
  final String like;
  final String notlike;
  const FamilyMember({
    required this.id,
    required this.name,
    required this.gender,
    required this.picture,
    required this.birth,
    required this.childRank,
    required this.like,
    required this.notlike,
  });

  FamilyMember copyWith({
    int? id,
    String? name,
    String? gender,
    String? picture,
    String? birth,
    int? childRank,
    String? like,
    String? notlike,
  }) {
    return FamilyMember(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      picture: picture ?? this.picture,
      birth: birth ?? this.birth,
      childRank: childRank ?? this.childRank,
      like: like ?? this.like,
      notlike: notlike ?? this.notlike,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'gender': gender});
    result.addAll({'picture': picture});
    result.addAll({'birth': birth});
    result.addAll({'childRank': childRank});
    result.addAll({'like': like});
    result.addAll({'notlike': notlike});

    return result;
  }

  factory FamilyMember.fromMap(Map<String, dynamic> map) {
    return FamilyMember(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      picture: map['picture'] ?? '',
      birth: map['birth'] ?? '',
      childRank: map['childRank']?.toInt() ?? 0,
      like: map['like'] ?? '',
      notlike: map['notlike'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyMember.fromJson(String source) =>
      FamilyMember.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FamilyMember(id: $id, name: $name, gender: $gender, picture: $picture, birth: $birth, childRank: $childRank, like: $like, notlike: $notlike)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FamilyMember &&
        other.id == id &&
        other.name == name &&
        other.gender == gender &&
        other.picture == picture &&
        other.birth == birth &&
        other.childRank == childRank &&
        other.like == like &&
        other.notlike == notlike;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        picture.hashCode ^
        birth.hashCode ^
        childRank.hashCode ^
        like.hashCode ^
        notlike.hashCode;
  }
}
