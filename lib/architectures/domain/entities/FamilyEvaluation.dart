import 'dart:convert';

import 'package:collection/collection.dart';

class FamilyEvaluation {
  final int id;
  final String date;
  final int childId;
  final List<int> answers;
  const FamilyEvaluation({
    required this.id,
    required this.date,
    required this.childId,
    required this.answers,
  });

  FamilyEvaluation copyWith({
    int? id,
    String? date,
    int? childId,
    List<int>? answers,
  }) {
    return FamilyEvaluation(
      id: id ?? this.id,
      date: date ?? this.date,
      childId: childId ?? this.childId,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'date': date});
    result.addAll({'childId': childId});
    result.addAll({'answers': answers});

    return result;
  }

  factory FamilyEvaluation.fromMap(Map<String, dynamic> map) {
    return FamilyEvaluation(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      childId: map['childId']?.toInt() ?? 0,
      answers: List<int>.from(map['answers'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyEvaluation.fromJson(String source) =>
      FamilyEvaluation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FamilyEvaluation(id: $id, date: $date, childId: $childId, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is FamilyEvaluation &&
        other.id == id &&
        other.date == date &&
        other.childId == childId &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ childId.hashCode ^ answers.hashCode;
  }
}
