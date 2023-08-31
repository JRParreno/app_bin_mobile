import 'dart:convert';

class AppWeek {
  final String pk;
  final DateTime startDate;
  final DateTime endDate;

  AppWeek({
    required this.pk,
    required this.startDate,
    required this.endDate,
  });

  AppWeek copyWith({
    String? pk,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return AppWeek(
      pk: pk ?? this.pk,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'startDate': startDate.millisecondsSinceEpoch});
    result.addAll({'endDate': endDate.millisecondsSinceEpoch});

    return result;
  }

  factory AppWeek.fromMap(Map<String, dynamic> map) {
    return AppWeek(
      pk: map['pk'].toString(),
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppWeek.fromJson(String source) =>
      AppWeek.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppWeek(pk: $pk, startDate: $startDate, endDate: $endDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppWeek &&
        other.pk == pk &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode => pk.hashCode ^ startDate.hashCode ^ endDate.hashCode;
}
