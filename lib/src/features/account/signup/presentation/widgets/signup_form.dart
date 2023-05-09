import 'package:flutter/material.dart';

import '../../../../../core/common_widget/common_widget.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;

  final GlobalKey<FormState> signupFormKey;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final Widget? suffixIconPassword;
  final Widget? suffixIconConfirmPassword;
  final bool isCheck;
  final Function(bool value) onChangeCheckBox;
  final VoidCallback onSubmit;

  const SignupForm({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.signupFormKey,
    required this.passwordVisible,
    required this.confirmPasswordVisible,
    required this.onChangeCheckBox,
    required this.onSubmit,
    this.suffixIconPassword,
    this.suffixIconConfirmPassword,
    this.isCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupFormKey,
      child: Column(
        children: [
          CustomTextField(
            textController: firstNameCtrl,
            labelText: "Firstname",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
          ),
          const Divider(
            color: Colors.transparent,
          ),
          CustomTextField(
            textController: lastNameCtrl,
            labelText: "Lastname",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
          ),
          const Divider(
            color: Colors.transparent,
          ),
          CustomTextField(
            textController: emailCtrl,
            labelText: "Email",
            keyboardType: TextInputType.emailAddress,
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            validators: (value) {
              if (value != null &&
                  RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w\w+)+$')
                      .hasMatch(value)) {
                return null;
              }
              return 'Invalid email address';
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          CustomTextField(
            textController: passwordCtrl,
            labelText: "Password",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            suffixIcon: suffixIconPassword,
            obscureText: passwordVisible,
          ),
          const Divider(
            color: Colors.transparent,
          ),
          CustomTextField(
            textController: confirmPasswordCtrl,
            labelText: "Confirm Password",
            padding: EdgeInsets.zero,
            parametersValidate: 'required',
            suffixIcon: suffixIconConfirmPassword,
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
          const Divider(
            height: 40,
            color: Colors.transparent,
          ),
          Row(
            children: [
              Checkbox(
                  value: isCheck,
                  onChanged: (value) {
                    onChangeCheckBox(value ?? false);
                  }),
              const Expanded(
                child: CustomText(
                  text:
                      "By creating you agree to the terms and Use and Privacy Policy",
                ),
              ),
            ],
          ),
          const Divider(
            height: 40,
            color: Colors.transparent,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomBtn(
                label: "Signup",
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
