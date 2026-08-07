import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../models/appointment.dart';
import '../../../models/doctor.dart';
import '../../appointments/pages/appointment_detail_page.dart';
import '../../root/root_shell.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key, required this.appointment, required this.doctor});
  final Appointment appointment;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                builder: (context, v, child) => Transform.scale(scale: v, child: child),
                child: Container(
                  width: 110, height: 110,
                  decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                  child: const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 62),
                ),
              ),
              const SizedBox(height: 28),
              Text(tr('bookingSuccess'), style: AppTextStyles.headingLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(tr('bookingSuccessMsg'), style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 44),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctor.name, style: AppTextStyles.headingSmall),
                              Text(doctor.specialty, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 26, color: AppColors.divider),
                    Row(children: [
                      const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text(localizedDateTime(appointment.dateTime), style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.confirmation_number_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 8),
                      Text('${tr('bookingRef')}: ${appointment.bookingRef}', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                    ]),
                  ],
                ),
              ),
              const Spacer(),
              EyanButton(
                label: tr('viewAppointment'),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => AppointmentDetailPage(appointment: appointment)),
                  (route) => route.isFirst,
                ),
              ),
              const SizedBox(height: 10),
              EyanButton(
                label: tr('backToHome'),
                variant: EyanButtonVariant.outlined,
                onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const RootShell()), (route) => false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
