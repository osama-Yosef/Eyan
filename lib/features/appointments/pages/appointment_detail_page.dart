import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/app_data.dart';
import '../../../models/appointment.dart';

class AppointmentDetailPage extends StatelessWidget {
  const AppointmentDetailPage({super.key, required this.appointment});
  final Appointment appointment;

  (Color, Color, String) _statusVisual(AppointmentStatus s) {
    switch (s) {
      case AppointmentStatus.upcoming:
        return (AppColors.primary, AppColors.primarySoft, tr('statusConfirmed'));
      case AppointmentStatus.completed:
        return (AppColors.info, AppColors.infoSoft, tr('statusCompleted'));
      case AppointmentStatus.cancelled:
        return (AppColors.error, AppColors.errorSoft, tr('statusCancelled'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = AppData.instance.doctorById(appointment.doctorId);
    final remaining = appointment.dateTime.difference(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(tr('appointmentDetails'))),
      body: AnimatedBuilder(
        animation: AppData.instance,
        builder: (context, _) {
          final current = AppData.instance.appointments.firstWhere((a) => a.id == appointment.id, orElse: () => appointment);
          final vis = _statusVisual(current.status);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.divider)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 56),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctor.name, style: AppTextStyles.headingSmall),
                              const SizedBox(height: 2),
                              Text(doctor.specialty, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        StatusPill(label: vis.$3, color: vis.$1, bg: vis.$2),
                      ],
                    ),
                    const Divider(height: 32, color: AppColors.divider),
                    _row(Icons.calendar_today_rounded, localizedDate(current.dateTime)),
                    const SizedBox(height: 12),
                    _row(Icons.access_time_rounded, localizedTimeOfDay(TimeOfDay.fromDateTime(current.dateTime))),
                    const SizedBox(height: 12),
                    _row(Icons.location_on_outlined, doctor.address),
                    const SizedBox(height: 12),
                    _row(Icons.confirmation_number_outlined, '${tr('bookingRef')}: ${current.bookingRef}'),
                  ],
                ),
              ),
              if (current.status == AppointmentStatus.upcoming && !remaining.isNegative) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_active_rounded, color: AppColors.primaryDark),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('${tr('startsIn')} ${countdownText(remaining)}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
                child: Column(
                  children: [
                    Row(children: [
                      Text(tr('consultationFee'), style: AppTextStyles.bodyMedium),
                      const Spacer(),
                      Text('${current.price.toStringAsFixed(0)} ${tr('egp')}', style: AppTextStyles.headingSmall.copyWith(color: AppColors.primaryDark)),
                    ]),
                  ],
                ),
              ),
              if (current.status == AppointmentStatus.upcoming) ...[
                const SizedBox(height: 28),
                EyanButton(
                  label: tr('addToCalendar'),
                  variant: EyanButtonVariant.outlined,
                  icon: const Icon(Icons.event_available_outlined, size: 18, color: AppColors.primary),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('comingSoon')))),
                ),
                const SizedBox(height: 10),
                EyanButton(
                  label: tr('cancelAppointment'),
                  variant: EyanButtonVariant.text,
                  onPressed: () => _confirmCancel(context, current.id),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _row(IconData icon, String value) => Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600))),
        ],
      );

  void _confirmCancel(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(tr('cancelConfirmTitle'), style: AppTextStyles.headingSmall),
        content: Text(tr('cancelConfirmMsg'), style: AppTextStyles.bodyMedium),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(tr('keepIt'), style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600))),
          TextButton(
            onPressed: () {
              AppData.instance.cancelAppointment(id);
              Navigator.pop(ctx);
            },
            child: Text(tr('yesCancel'), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
