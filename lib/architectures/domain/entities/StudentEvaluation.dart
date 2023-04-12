import 'dart:convert';

import 'package:collection/collection.dart';

class StudentEvaluation {
  final int id;
  final String date;
  final int studentId;
  final List<int> answers;
  const StudentEvaluation({
    required this.id,
    required this.date,
    required this.studentId,
    required this.answers,
  });

  StudentEvaluation copyWith({
    int? id,
    String? date,
    int? studentId,
    List<int>? answers,
  }) {
    return StudentEvaluation(
      id: id ?? this.id,
      date: date ?? this.date,
      studentId: studentId ?? this.studentId,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'date': date});
    result.addAll({'studentId': studentId});
    result.addAll({'answers': answers});

    return result;
  }

  factory StudentEvaluation.fromMap(Map<String, dynamic> map) {
    return StudentEvaluation(
      id: map['id']?.toInt() ?? 0,
      date: map['date'] ?? '',
      studentId: map['studentId']?.toInt() ?? 0,
      answers: List<int>.from(map['answers'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentEvaluation.fromJson(String source) =>
      StudentEvaluation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentEvaluation(id: $id, date: $date, studentId: $studentId, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is StudentEvaluation &&
        other.id == id &&
        other.date == date &&
        other.studentId == studentId &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode {
    return id.hashCode ^ date.hashCode ^ studentId.hashCode ^ answers.hashCode;
  }
}
