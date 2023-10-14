import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:app_bin_mobile/src/core/config/app_constant.dart';
import 'package:app_bin_mobile/src/features/account/forgot_password/data/forgot_password_repository_impl.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = 'forgot-password/';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: "Forgot Password"),
      body: Form(
        key: formKey,
        child: SizedBox(
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    textController: emailController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.zero,
                    parametersValidate: 'required',
                    validators: (value) {
                      if (value != null && EmailValidator.validate(value)) {
                        return null;
                      }
                      return "Please enter a valid email";
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomBtn(
                    label: "Submit",
                    onTap: handleSubmitForgotPassword,
                    width: 275,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleSubmitForgotPassword() async {
    if (formKey.currentState!.validate()) {
      LoaderDialog.show(context: context);

      try {
        final message = await ForgotPasswordRepositoryImpl()
            .forgotPassowrd(emailController.value.text);
        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: AppConstant.appName,
            body: message,
          );
        });
      } catch (onError) {
        Future.delayed(const Duration(milliseconds: 500), () {
          CommonDialog.showMyDialog(
            context: context,
            title: AppConstant.appName,
            body: onError.toString(),
            isError: true,
          );
        });
      }
      // ignore: use_build_context_synchronously
      LoaderDialog.hide(context: context);
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: AppConstant.appName,
          body: 'Invalid email address',
          isError: true,
        );
      });
    }
  }
}
