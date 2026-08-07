import 'package:flutter/material.dart';
import '../localization/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/date_time_format.dart';
import '../../models/appointment.dart';
import '../../models/doctor.dart';

class AppointmentReminderCard extends StatelessWidget {
  const AppointmentReminderCard({super.key, required this.appointment, required this.doctor, required this.onTap});
  final Appointment appointment;
  final Doctor doctor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final remaining = appointment.dateTime.difference(DateTime.now());
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.28), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_active_rounded, color: Colors.white.withValues(alpha: 0.9), size: 18),
                const SizedBox(width: 6),
                Text(tr('upcomingAppointment'), style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.w600)),
                const Spacer(),
                if (!remaining.isNegative)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
                    child: Text('${tr('reminderIn')} ${countdownText(remaining)}', style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(doctor.initials, style: TextStyle(color: doctor.avatarColor, fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'Inter')),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name, style: AppTextStyles.headingSmall.copyWith(color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(doctor.specialty, style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(14)),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 15),
                  const SizedBox(width: 8),
                  Text(localizedDateTime(appointment.dateTime), style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Icon(Icons.chevron_right_rounded, color: Colors.white.withValues(alpha: 0.85), size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
