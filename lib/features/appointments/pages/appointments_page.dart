import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/app_data.dart';
import '../../../models/appointment.dart';
import 'appointment_detail_page.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});
  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  bool _showUpcoming = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final data = AppData.instance;
        final list = _showUpcoming ? data.upcomingAppointments : data.pastAppointments;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Text(tr('myAppointments'), style: AppTextStyles.displayMedium.copyWith(fontSize: 24)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
                    child: Row(
                      children: [
                        _tab(tr('upcoming'), true),
                        _tab(tr('past'), false),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: list.isEmpty
                      ? Center(
                          child: EmptyState(
                            icon: _showUpcoming ? Icons.event_available_outlined : Icons.history_rounded,
                            title: _showUpcoming ? tr('noUpcoming') : tr('noPast'),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                          itemCount: list.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, i) => _AppointmentTile(appointment: list[i]),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _tab(String label, bool value) {
    final selected = _showUpcoming == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _showUpcoming = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: selected ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(11)),
          alignment: Alignment.center,
          child: Text(label, style: AppTextStyles.bodyMedium.copyWith(color: selected ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({required this.appointment});
  final Appointment appointment;

  (Color, Color, String) _visual(AppointmentStatus s) {
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
    final vis = _visual(appointment.status);
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AppointmentDetailPage(appointment: appointment))),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
        child: Row(
          children: [
            AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 52),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: AppTextStyles.headingSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(doctor.specialty, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.textSecondary),
                    const SizedBox(width: 5),
                    Text(localizedDateTime(appointment.dateTime), style: AppTextStyles.bodySmall),
                  ]),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusPill(label: vis.$3, color: vis.$1, bg: vis.$2),
                const SizedBox(height: 10),
                Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
