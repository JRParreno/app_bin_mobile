import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isEnabled;
  final TextInputType? inputType;
  final TextInputAction? actionType;
  final Function(String)? onChanged;
  final Function(String text)? validate;
  final String? errorMessage;
  final int? minLines;
  final int maxLines;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isEnabled = true,
    this.inputType,
    this.actionType,
    this.onChanged,
    this.validate,
    this.errorMessage,
    this.minLines,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  Color _color = const Color(0xFF494E56);
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    widget.controller.addListener(() {
      _color = widget.validate != null &&
              widget.validate!(widget.controller.text) == false
          ? const Color(0xFFEC5D77)
          : _focusNode.hasFocus
              ? const Color(0xFF0030FF)
              : const Color(0xFF494E56);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (onChanged) {
          _color = widget.validate != null &&
                  widget.validate!(widget.controller.text) == false
              ? const Color(0xFFEC5D77)
              : onChanged
                  ? Colors.black
                  : const Color(0xFF494E56);
        },
        child: TextField(
          focusNode: _focusNode,
          onTap: _requestFocus,
          onChanged: widget.onChanged,
          enabled: widget.isEnabled,
          controller: widget.controller,
          keyboardType: widget.inputType,
          textInputAction: widget.actionType,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          cursorColor: const Color(0xFF2B3039),
          cursorWidth: 1,
          cursorHeight: 20,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(
                fontSize: 16,
                letterSpacing: .3,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: widget.validate != null &&
                          widget.validate!(widget.controller.text) == false
                      ? const Color(0xFFEC5D77)
                      : widget.controller.text.isEmpty
                          ? const Color(0xFFCED3DD)
                          : const Color(0xFF494E56),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _color,
                ),
              ),
              focusColor: Colors.black,
              floatingLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: .5,
                  color: _color),
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor:
                  widget.isEnabled ? Colors.white : const Color(0xFFF1F2F3),
              errorText: widget.validate != null &&
                      widget.validate!(widget.controller.text) == false
                  ? widget.errorMessage
                  : null,
              errorStyle: const TextStyle(
                  color: Color(0xFFEC5D77), fontSize: 12, letterSpacing: .5),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFEC5D77))),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFCED3DD),
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFEC5D77))),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon),
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ));
  }
}
