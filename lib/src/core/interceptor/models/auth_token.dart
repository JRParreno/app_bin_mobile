// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthToken {
  final String accessToken;
  final String refreshToken;
  final String status;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
  });

  AuthToken copyWith({
    String? accessToken,
    String? refreshToken,
    String? status,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'status': status,
    };
  }

  factory AuthToken.fromMap(Map<String, dynamic> map) {
    return AuthToken(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthToken.fromJson(String source) =>
      AuthToken.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthToken(accessToken: $accessToken, refreshToken: $refreshToken, status: $status)';

  @override
  bool operator ==(covariant AuthToken other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.status == status;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ status.hashCode;
}
