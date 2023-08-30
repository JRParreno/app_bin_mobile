import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/features/account/login/presentation/widgets/login_header.dart';
import 'package:app_bin_mobile/src/features/account/signup/presentation/screen/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final GlobalKey<FormState> formKey;
  final Widget suffixIcon;
  final bool passwordVisible;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.formKey,
    required this.suffixIcon,
    required this.passwordVisible,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const LoginHeader(),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.65,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: ColorName.gray,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                  width: 1.0, style: BorderStyle.solid, color: ColorName.gray),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 25, bottom: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.transparent,
                        height: 10,
                      ),
                      const Center(
                        child: CustomText(
                          text: "Log in",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                        height: 20,
                      ),
                      CustomTextField(
                        textController: emailCtrl,
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        padding: EdgeInsets.zero,
                        parametersValidate: 'required',
                      ),
                      const Divider(
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
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: CustomTextLink(
                          text: "Forgot Password",
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 25,
                    color: Colors.transparent,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomBtn(
                        label: "Log in",
                        onTap: onSubmit,
                        width: 275,
                      ),
                      const Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: "or ",
                          ),
                          CustomTextLink(
                            text: "Sign up",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SignUpScreen.routeName);
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
