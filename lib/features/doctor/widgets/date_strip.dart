import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';

class DateStrip extends StatelessWidget {
  const DateStrip({super.key, required this.selected, required this.onSelect, this.days = 14});
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;
  final int days;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dates = List.generate(days, (i) => DateTime(today.year, today.month, today.day).add(Duration(days: i)));
    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final date = dates[i];
          final isSelected = date.year == selected.year && date.month == selected.month && date.day == selected.day;
          return GestureDetector(
            onTap: () => onSelect(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 56,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(weekdayShort(date), style: AppTextStyles.bodySmall.copyWith(color: isSelected ? Colors.white.withValues(alpha: 0.85) : AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text('${date.day}', style: AppTextStyles.headingSmall.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
