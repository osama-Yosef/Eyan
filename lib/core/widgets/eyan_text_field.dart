import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EyanTextField extends StatefulWidget {
  const EyanTextField({
    super.key, required this.hint, required this.prefixIcon,
    this.controller, this.keyboardType, this.isPassword = false,
    this.validator, this.textInputAction, this.onFieldSubmitted,
  });
  final String hint;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<EyanTextField> createState() => _EyanTextFieldState();
}

class _EyanTextFieldState extends State<EyanTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure, validator: widget.validator,
      textInputAction: widget.textInputAction, onFieldSubmitted: widget.onFieldSubmitted,
      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.primary, size: 20),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textSecondary, size: 20))
            : null,
      ),
    );
  }
}
