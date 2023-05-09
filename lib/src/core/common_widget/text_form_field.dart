import 'package:app_bin_mobile/gen/colors.gen.dart';
import 'package:app_bin_mobile/src/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController textController;
  final bool focus;
  final int? maxLength;
  final String? parametersValidate;
  final AutovalidateMode? mode;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? minLines;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? errorText;
  final Function()? onTap;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? padding;
  final String? helpText;
  final String? hintText;
  final FormFieldValidator<String>? validators;

  const TextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.textController,
    this.maxLength,
    this.parametersValidate = '',
    this.focus = false,
    this.mode,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.minLines,
    this.maxLines = 1,
    this.onChanged,
    this.errorText,
    this.onTap,
    this.suffixIcon,
    this.inputFormatters,
    this.padding,
    this.helpText,
    this.hintText,
    this.validators,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            readOnly: widget.readOnly,
            maxLength: widget.maxLength,
            controller: widget.textController,
            autovalidateMode: widget.mode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              counterText: '',
              labelStyle: const TextStyle(
                fontSize: 16,
                letterSpacing: .3,
                fontFamily: "HenrySans",
                fontWeight: FontWeight.w400,
              ),
              floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                  (Set<MaterialState> states) {
                final Color? color = states.contains(MaterialState.error)
                    ? ColorName.error
                    : null;
                return TextStyle(
                  fontSize: 16,
                  letterSpacing: .5,
                  fontFamily: "HenrySans",
                  fontWeight: FontWeight.w700,
                  color: color,
                );
              }),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: ColorName.error,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: ColorName.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: ColorName.placeHolder,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: ColorName.error,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(16),
                vertical: SizeConfig.getProportionateScreenHeight(16.5),
              ),
              errorStyle: const TextStyle(
                fontSize: 0,
                height: 0,
              ),
              suffixIcon: widget.suffixIcon,
              errorText: widget.errorText,
            ),
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w400,
              fontFamily: "HenrySans",
              color: Colors.black,
            ),
            validator: widget.validators ??
                (value) {
                  if ((value == null || value.isEmpty) &&
                      widget.parametersValidate != null) {
                    return widget.parametersValidate;
                  }
                  return null;
                },
          ),
        ),
        if (widget.helpText != null) ...[
          SizedBox(height: 8.sp),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateScreenWidth(40)),
              child: Text(
                widget.helpText!,
                style: TextStyle(
                  fontFamily: "HenrySans",
                  fontSize: 12.sp,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ]
      ],
    );
  }

  String emptyValidation(String value, String messageError) {
    if (value.isEmpty) {
      return messageError;
    }
    return '';
  }
}
