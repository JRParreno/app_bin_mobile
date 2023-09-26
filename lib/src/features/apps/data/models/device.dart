import 'dart:convert';

class Device {
  final int pk;
  final String deviceName;
  final String deviceCode;

  Device({
    required this.pk,
    required this.deviceName,
    required this.deviceCode,
  });

  Device copyWith({
    int? pk,
    String? deviceName,
    String? deviceCode,
  }) {
    return Device(
      pk: pk ?? this.pk,
      deviceName: deviceName ?? this.deviceName,
      deviceCode: deviceCode ?? this.deviceCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'pk': pk});
    result.addAll({'deviceName': deviceName});
    result.addAll({'deviceCode': deviceCode});

    return result;
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      pk: map['pk'],
      deviceName: map['device_name'] ?? '',
      deviceCode: map['device_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() =>
      'Device(deviceName: $deviceName, deviceCode: $deviceCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Device &&
        other.deviceName == deviceName &&
        other.pk == pk &&
        other.deviceCode == deviceCode;
  }

  @override
  int get hashCode => deviceName.hashCode ^ deviceCode.hashCode ^ pk;
}
