import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum EyanButtonVariant { primary, outlined, text }

class EyanButton extends StatelessWidget {
  const EyanButton({
    super.key, required this.label, required this.onPressed,
    this.variant = EyanButtonVariant.primary, this.isLoading = false,
    this.width, this.height = 56, this.icon,
  });
  final String label;
  final VoidCallback? onPressed;
  final EyanButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;
  final Widget? icon;

  bool get _disabled => onPressed == null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity, height: height,
      child: switch (variant) {
        EyanButtonVariant.primary => _primary(),
        EyanButtonVariant.outlined => _outlined(),
        EyanButtonVariant.text => _text(),
      },
    );
  }

  Widget _primary() => ElevatedButton(
    onPressed: isLoading ? null : onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: _disabled ? AppColors.divider : AppColors.primary,
      disabledBackgroundColor: AppColors.divider,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
    ),
    child: _child(_disabled ? AppColors.textHint : AppColors.surface),
  );

  Widget _outlined() => OutlinedButton(
    onPressed: isLoading ? null : onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: _disabled ? AppColors.divider : AppColors.primary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    child: _child(_disabled ? AppColors.textHint : AppColors.primary),
  );

  Widget _text() => TextButton(onPressed: isLoading ? null : onPressed, child: _child(_disabled ? AppColors.textHint : AppColors.primary));

  Widget _child(Color color) {
    if (isLoading) return SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(color)));
    if (icon != null) return Row(mainAxisAlignment: MainAxisAlignment.center, children: [icon!, const SizedBox(width: 8), Text(label, style: AppTextStyles.labelLarge.copyWith(color: color))]);
    return Text(label, style: AppTextStyles.labelLarge.copyWith(color: color));
  }
}
