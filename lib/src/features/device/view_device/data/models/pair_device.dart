import 'dart:convert';

import 'package:equatable/equatable.dart';

class PairDevice extends Equatable {
  const PairDevice({
    required this.pk,
    required this.fullName,
    required this.pairStatus,
    required this.userPk,
    this.profilePhoto,
  });

  final int pk;
  final String fullName;
  final String pairStatus;
  final int userPk;
  final String? profilePhoto;

  @override
  List<Object?> get props => [
        pk,
        fullName,
        pairStatus,
        profilePhoto,
        userPk,
      ];

  PairDevice copyWith({
    int? pk,
    String? fullName,
    String? pairStatus,
    String? profilePhoto,
    int? userPk,
  }) {
    return PairDevice(
      pk: pk ?? this.pk,
      fullName: fullName ?? this.fullName,
      pairStatus: pairStatus ?? this.pairStatus,
      userPk: userPk ?? this.userPk,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pk': pk});
    result.addAll({'fullName': fullName});
    result.addAll({'pairStatus': pairStatus});
    result.addAll({'userPk': userPk});
    if (profilePhoto != null) {
      result.addAll({'profilePhoto': profilePhoto});
    }

    return result;
  }

  factory PairDevice.fromMap(Map<String, dynamic> map) {
    return PairDevice(
      pk: map['pk']?.toInt() ?? 0,
      fullName: map['user_pair']['user']['get_full_name'] ?? '',
      userPk: map['user_pair']['user']['pk'] ?? '',
      pairStatus: map['pair_status'] ?? '',
      profilePhoto: map['user_pair']['profile_photo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PairDevice.fromJson(String source) =>
      PairDevice.fromMap(json.decode(source));
}
