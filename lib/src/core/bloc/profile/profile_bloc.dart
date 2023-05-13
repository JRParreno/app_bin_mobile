import 'dart:convert';

import 'package:app_bin_mobile/src/core/bloc/common/common_event.dart';
import 'package:app_bin_mobile/src/core/bloc/common/common_state.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const InitialState()) {
    on<InitialEvent>(_initial);
    on<SetProfileEvent>(_setProfile);
    on<SetProfileLogoutEvent>(_setProfileLogoutEvent);
  }

  void _initial(InitialEvent event, Emitter<ProfileState> emit) {
    return emit(const InitialState());
  }

  void _setProfile(SetProfileEvent event, Emitter<ProfileState> emit) {
    return emit(ProfileLoaded(profile: event.profile));
  }

  void _setProfileLogoutEvent(
      SetProfileLogoutEvent event, Emitter<ProfileState> emit) async {
    return emit(ProfileLogout());
  }
}
