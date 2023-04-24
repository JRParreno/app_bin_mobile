import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/common_widget/common_widget.dart';
import 'package:app_bin_mobile/src/core/common_widget/custom_btn.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  void handleLogin() {}

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 2,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: ColorName.gray,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
              width: 1.0, style: BorderStyle.solid, color: ColorName.gray),
        ),
        child: Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
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
                    controller: emailController,
                    label: "Email",
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
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
                height: 50,
                color: Colors.transparent,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomBtn(
                    label: "Log in",
                    onTap: handleLogin,
                    width: 275,
                  ),
                  const Divider(
                    height: 10,
                    color: Colors.transparent,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CustomText(
                        text: "or ",
                      ),
                      CustomTextLink(
                        text: "Sign up",
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
