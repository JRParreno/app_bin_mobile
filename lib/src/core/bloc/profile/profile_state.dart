// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final Profile? profile;

  const ProfileLoaded({
    this.profile,
  });

  ProfileLoaded copyWith({
    Profile? profile,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile': profile?.toMap(),
    };
  }

  factory ProfileLoaded.fromMap(Map<String, dynamic> map) {
    return ProfileLoaded(
      profile: map['profile'] != null
          ? Profile.fromMap(map['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileLoaded.fromJson(String source) =>
      ProfileLoaded.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [profile];
}

class ProfileLogout extends ProfileState {}
