import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../models/doctor.dart';

class SlotGrid extends StatelessWidget {
  const SlotGrid({super.key, required this.slots, required this.selected, required this.onSelect});
  final List<DoctorSlot> slots;
  final TimeOfDay? selected;
  final ValueChanged<TimeOfDay> onSelect;

  @override
  Widget build(BuildContext context) {
    final available = slots.where((s) => !s.isBooked).length;
    if (available == 0) {
      return EmptyState(icon: Icons.event_busy_rounded, title: tr('noSlotsAvailable'));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final isSelected = selected != null && selected!.hour == slot.time.hour && selected!.minute == slot.time.minute;
        return GestureDetector(
          onTap: slot.isBooked ? null : () => onSelect(slot.time),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: slot.isBooked ? AppColors.background : (isSelected ? AppColors.primary : AppColors.surface),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
            ),
            child: Text(
              localizedTimeOfDay(slot.time),
              style: AppTextStyles.bodyMedium.copyWith(
                color: slot.isBooked ? AppColors.textHint : (isSelected ? Colors.white : AppColors.textPrimary),
                fontWeight: FontWeight.w600,
                decoration: slot.isBooked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
