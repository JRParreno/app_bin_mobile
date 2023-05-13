// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  final String pk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePhoto;
  final String? parentUser;
  final String? childUser;

  Profile({
    required this.pk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePhoto,
    this.parentUser,
    this.childUser,
  });

  Profile copyWith({
    String? pk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePhoto,
    String? parentUser,
    String? childUser,
  }) {
    return Profile(
      pk: pk ?? this.pk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      parentUser: parentUser ?? this.parentUser,
      childUser: childUser ?? this.childUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePhoto': profilePhoto,
      'parentUser': parentUser,
      'childUser': childUser,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      pk: map['pk'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      parentUser:
          map['parentUser'] != null ? map['parentUser'] as String : null,
      childUser: map['childUser'] != null ? map['childUser'] as String : null,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(pk: $pk, username: $username, firstName: $firstName, lastName: $lastName, email: $email, profilePhoto: $profilePhoto, parentUser: $parentUser, childUser: $childUser)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.profilePhoto == profilePhoto &&
        other.childUser == childUser &&
        other.parentUser == parentUser;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        parentUser.hashCode ^
        childUser.hashCode ^
        profilePhoto.hashCode;
  }
}
