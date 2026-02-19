import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

import 'package:flutter/cupertino.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
    this.textInputAction,
    this.keyboardType,
  });
  final String hint;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      cursorHeight: 20,
      cursorColor: AppColors.primary,
      keyboardType: widget.keyboardType,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Please Fill ${widget.hint}";
        }
        return null;
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        labelStyle: TextStyle(color: AppColors.gray),
        floatingLabelStyle: TextStyle(color: AppColors.pink),

        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglePassword,
                child: Icon(
                  _obscureText
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye,
                  color: AppColors.gray,
                ),
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray),
          borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pink),
          borderRadius: BorderRadius.circular(12),
        ),

        fillColor: AppColors.primary,
        filled: true,
      ),
    );
  }
}
