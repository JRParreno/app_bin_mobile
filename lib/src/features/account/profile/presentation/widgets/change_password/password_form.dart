import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatelessWidget {
  final TextEditingController oldPasswordCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController passwordConfirmCtrl;
  final GlobalKey<FormState> formKey;
  // final FocusNode passwordSignupFocus;
  // final FocusNode confirmPasswordFocus;

  final Widget suffixIcon;
  final bool passwordVisible;

  final Widget confirmSuffixIcon;
  final bool confirmPasswordVisible;
  final VoidCallback onSubmit;

  const PasswordForm({
    super.key,
    required this.passwordCtrl,
    required this.passwordConfirmCtrl,
    required this.formKey,
    // required this.passwordSignupFocus,
    // required this.confirmPasswordFocus,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.confirmSuffixIcon,
    required this.confirmPasswordVisible,
    required this.onSubmit,
    required this.oldPasswordCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Divider(
                color: Colors.transparent,
                height: 20,
              ),
              CustomTextField(
                textController: oldPasswordCtrl,
                labelText: "Old Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                obscureText: true,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: passwordCtrl,
                labelText: "Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: suffixIcon,
                obscureText: passwordVisible,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
              CustomTextField(
                textController: passwordConfirmCtrl,
                labelText: "Confirm Password",
                padding: EdgeInsets.zero,
                parametersValidate: 'required',
                suffixIcon: confirmSuffixIcon,
                obscureText: confirmPasswordVisible,
                validators: (value) {
                  if (value != null &&
                      value.isEmpty &&
                      value != passwordCtrl.value.text) {
                    return "Password doesn't match";
                  }
                  return null;
                },
              ),
            ],
          ),
          const Divider(
            height: 30,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Submit",
                onTap: onSubmit,
                width: 275,
              ),
              const Divider(
                height: 10,
                color: Colors.transparent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
