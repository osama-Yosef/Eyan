import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.color, this.bg});
  final String label;
  final Color color;
  final Color? bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg ?? color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }
}
