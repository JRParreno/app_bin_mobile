import 'dart:convert';

class Device {
  final String deviceName;
  final String deviceCode;

  Device({
    required this.deviceName,
    required this.deviceCode,
  });

  Device copyWith({
    String? deviceName,
    String? deviceCode,
  }) {
    return Device(
      deviceName: deviceName ?? this.deviceName,
      deviceCode: deviceCode ?? this.deviceCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'deviceName': deviceName});
    result.addAll({'deviceCode': deviceCode});

    return result;
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
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
        other.deviceCode == deviceCode;
  }

  @override
  int get hashCode => deviceName.hashCode ^ deviceCode.hashCode;
}
