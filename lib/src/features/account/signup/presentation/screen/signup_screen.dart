import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_bin_mobile/src/features/account/signup/data/models/signup.dart';
import 'package:app_bin_mobile/src/features/account/signup/data/repositories/signup_repository_impl.dart';
import 'package:app_bin_mobile/src/features/account/signup/presentation/widgets/signup_form.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_widget/common_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;
  bool _isCheck = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    super.dispose();
  }

  void handleSignup() {
    if (signupFormKey.currentState!.validate()) {
      if (_isCheck) {
        LoaderDialog.show(context: context);
        final signup = Signup(
          email: emailCtrl.text,
          password: passwordCtrl.text,
          confirmPassword: confirmPasswordCtrl.text,
          firstName: firstNameCtrl.text,
          lastName: lastNameCtrl.text,
        );
        SignupImpl().register(signup).then((value) async {
          await LocalStorage.storeLocalStorage(
              '_token', value['data']['access_token']);
          await LocalStorage.storeLocalStorage(
              '_refreshToken', value['data']['refresh_token']);
          handleGetProfile();
        }).catchError((onError) {
          LoaderDialog.hide(context: context);
          Future.delayed(const Duration(milliseconds: 500), () {
            CommonDialog.showMyDialog(
              context: context,
              body: onError['data']['error_message'],
              isError: true,
            );
          });
        });
      } else {
        CommonDialog.showMyDialog(
          context: context,
          body: "Please agree to terms and conditions",
        );
      }
    }
  }

  void handleGetProfile() async {
    await ProfileRepositoryImpl().fetchProfile().then((profile) async {
      await LocalStorage.storeLocalStorage('_user', profile.toJson());
      handleSetProfileBloc(profile);
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      });
    }).catchError((onError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
    // ignore: use_build_context_synchronously
    LoaderDialog.hide(context: context);
  }

  void handleSetProfileBloc(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).add(
      SetProfileEvent(profile: profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context: context, title: "Signup"),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            decoration: BoxDecoration(
              color: ColorName.gray,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                  width: 1.0, style: BorderStyle.solid, color: ColorName.gray),
            ),
            child: SignupForm(
              emailCtrl: emailCtrl,
              passwordCtrl: passwordCtrl,
              confirmPasswordCtrl: confirmPasswordCtrl,
              firstNameCtrl: firstNameCtrl,
              lastNameCtrl: lastNameCtrl,
              signupFormKey: signupFormKey,
              passwordVisible: _passwordVisible,
              confirmPasswordVisible: _confirmPasswordVisible,
              suffixIconPassword: GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Icon(!_passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              suffixIconConfirmPassword: GestureDetector(
                onTap: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
                child: Icon(!_confirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              onChangeCheckBox: (value) {
                setState(() {
                  _isCheck = value;
                });
              },
              isCheck: _isCheck,
              onSubmit: handleSignup,
            ),
          ),
        ),
      ),
    );
  }
}
