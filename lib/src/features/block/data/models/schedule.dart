import 'dart:convert';

import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  const Schedule({
    required this.myDateTime,
    required this.isHourly,
    required this.hours,
    required this.minutes,
    this.device = -1,
    this.pk = -1,
  });

  final DateTime myDateTime;
  final bool isHourly;
  final int hours;
  final int minutes;
  final int device;
  final int pk;

  @override
  List<Object> get props => [myDateTime, isHourly, hours, minutes];

  Schedule copyWith({
    DateTime? myDateTime,
    bool? isHourly,
    int? hours,
    int? minutes,
    int? device,
    int? pk,
  }) {
    return Schedule(
      myDateTime: myDateTime ?? this.myDateTime,
      isHourly: isHourly ?? this.isHourly,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      device: device ?? this.device,
      pk: pk ?? this.pk,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'myDateTime': myDateTime.millisecondsSinceEpoch});
    result.addAll({'isHourly': isHourly});
    result.addAll({'hours': hours});
    result.addAll({'minutes': minutes});
    result.addAll({'device': device});
    result.addAll({'pk': pk});

    return result;
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      myDateTime: DateTime.parse(map['my_date_time']),
      isHourly: map['is_hourly'] ?? false,
      hours: map['hours']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      device: map['device']?.toInt() ?? 0,
      pk: map['pk']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));

  factory Schedule.empty() {
    return Schedule(
      hours: -1,
      isHourly: false,
      minutes: -1,
      myDateTime: DateTime.now(),
      device: -1,
      pk: -1,
    );
  }
}
