import 'package:app_bin_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/core/local_storage/local_storage.dart';
import 'package:app_bin_mobile/src/features/account/login/data/repositories/login_repository_impl.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_form.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:app_bin_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_bin_mobile/src/features/apps/bloc/apps_bloc.dart';
import 'package:app_bin_mobile/src/features/apps/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usage_stats/usage_stats.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool isAppUsageEnable = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    handleAppUsagePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: LoginForm(
            formKey: loginFormKey,
            emailCtrl: emailCtrl,
            passwordCtrl: passwordCtrl,
            passwordVisible: _passwordVisible,
            onSubmit: handleLogin,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> handleAppUsagePermission() async {
    try {
      final permission = await UsageStats.checkUsagePermission() ?? false;

      setState(() {
        isAppUsageEnable = permission;
      });

      if (!permission) {
        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
              context: context,
              body: 'You need to enable app usage in app settings',
              isError: true,
              buttons: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () async {
                    UsageStats.grantUsagePermission();
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
        return;
      }
      handleGetApps();
    } catch (e) {
      print(e.toString());
    }
  }

  void handleLogin() {
    if (isAppUsageEnable) {
      if (loginFormKey.currentState!.validate()) {
        LoaderDialog.show(context: context);

        LoginRepositoryImpl()
            .login(
                email: emailCtrl.value.text, password: passwordCtrl.value.text)
            .then((value) async {
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
              title: AppConstant.appName,
              body: "Invalid email or password",
              isError: true,
            );
          });
        });
      }
    } else {
      handleAppUsagePermission();
    }
  }

  void handleGetProfile() async {
    await ProfileRepositoryImpl().fetchProfile().then((profile) async {
      await LocalStorage.storeLocalStorage('_user', profile.toJson());
      handleSetProfileBloc(profile);
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamed(
          HomeScreen.routeName,
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

  void handleGetApps() {
    if (isAppUsageEnable) {
      BlocProvider.of<AppsBloc>(context)
          .add(const AppsLoadInitEvent(whiteList: []));
    }
  }
}
