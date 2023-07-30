import 'dart:convert';

import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  const Schedule({
    required this.myDateTime,
    required this.isHourly,
    required this.hours,
    required this.minutes,
  });

  final DateTime myDateTime;
  final bool isHourly;
  final int hours;
  final int minutes;

  @override
  List<Object> get props => [myDateTime, isHourly, hours, minutes];

  Schedule copyWith({
    DateTime? myDateTime,
    bool? isHourly,
    int? hours,
    int? minutes,
  }) {
    return Schedule(
      myDateTime: myDateTime ?? this.myDateTime,
      isHourly: isHourly ?? this.isHourly,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'myDateTime': myDateTime.millisecondsSinceEpoch});
    result.addAll({'isHourly': isHourly});
    result.addAll({'hours': hours});
    result.addAll({'minutes': minutes});

    return result;
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      myDateTime: DateTime.fromMillisecondsSinceEpoch(map['myDateTime']),
      isHourly: map['isHourly'] ?? false,
      hours: map['hours']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Schedule(myDateTime: $myDateTime, isHourly: $isHourly, hours: $hours, minutes: $minutes)';
  }
}
