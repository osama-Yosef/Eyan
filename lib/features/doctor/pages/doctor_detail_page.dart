import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/app_data.dart';
import '../../../models/doctor.dart';
import '../widgets/date_strip.dart';
import '../widgets/slot_grid.dart';
import 'booking_success_page.dart';

class DoctorDetailPage extends StatefulWidget {
  const DoctorDetailPage({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  late DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedSlot;

  void _pickDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedSlot = null;
    });
  }

  Future<void> _confirmBooking() async {
    final doctor = widget.doctor;
    final slot = _selectedSlot!;
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _BookingConfirmSheet(doctor: doctor, date: _selectedDate, time: slot),
    );
    if (confirmed != true || !mounted) return;
    final appt = AppData.instance.bookAppointment(doctor: doctor, date: _selectedDate, time: slot);
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BookingSuccessPage(appointment: appt, doctor: doctor)));
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    final slots = doctor.slotsFor(_selectedDate);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                pinned: true,
                expandedHeight: 220,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white), onPressed: () => Navigator.pop(context)),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 36),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 84, height: 84,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              alignment: Alignment.center,
                              child: Text(doctor.initials, style: TextStyle(color: doctor.avatarColor, fontWeight: FontWeight.w700, fontSize: 28, fontFamily: 'Inter')),
                            ),
                            const SizedBox(height: 12),
                            Text(doctor.name, style: AppTextStyles.headingLarge.copyWith(color: Colors.white)),
                            const SizedBox(height: 4),
                            Text(doctor.specialty, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
                        child: Row(
                          children: [
                            _Stat(icon: Icons.star_rounded, value: doctor.rating.toStringAsFixed(1), label: '${doctor.reviewsCount} ${tr('reviews')}'),
                            _divider(),
                            _Stat(icon: Icons.people_alt_rounded, value: '${(doctor.patientsCount / 100).round() / 10}k', label: tr('patients')),
                            _divider(),
                            _Stat(icon: Icons.workspace_premium_rounded, value: '${doctor.experienceYears}', label: tr('years')),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(tr('about'), style: AppTextStyles.headingSmall),
                      const SizedBox(height: 8),
                      Text(doctor.bio, style: AppTextStyles.bodyMedium.copyWith(height: 1.6)),
                      const SizedBox(height: 20),
                      _InfoRow(icon: Icons.schedule_rounded, label: tr('workingHours'), value: doctor.workingHours),
                      const SizedBox(height: 10),
                      _InfoRow(icon: Icons.location_on_outlined, label: tr('clinicAddress'), value: doctor.address),
                      const SizedBox(height: 26),
                      Text(tr('selectDate'), style: AppTextStyles.headingSmall),
                      const SizedBox(height: 12),
                      DateStrip(selected: _selectedDate, onSelect: _pickDate),
                      const SizedBox(height: 24),
                      Text(tr('availableSlots'), style: AppTextStyles.headingSmall),
                      const SizedBox(height: 12),
                      SlotGrid(slots: slots, selected: _selectedSlot, onSelect: (t) => setState(() => _selectedSlot = t)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 20, offset: const Offset(0, -6))]),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr('consultationFee'), style: AppTextStyles.bodySmall),
                        Text('${doctor.price.toStringAsFixed(0)} ${tr('egp')}', style: AppTextStyles.headingLarge.copyWith(color: AppColors.primaryDark)),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 190,
                      child: EyanButton(label: tr('bookAppointment'), onPressed: _selectedSlot == null ? null : _confirmBooking),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(width: 1, height: 34, color: AppColors.divider);
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.headingSmall),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38, height: 38,
          decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodySmall),
              const SizedBox(height: 2),
              Text(value, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

class _BookingConfirmSheet extends StatelessWidget {
  const _BookingConfirmSheet({required this.doctor, required this.date, required this.time});
  final Doctor doctor;
  final DateTime date;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 44, height: 5, decoration: BoxDecoration(color: AppColors.divider, borderRadius: BorderRadius.circular(3)))),
          const SizedBox(height: 20),
          Text(tr('confirmBooking'), style: AppTextStyles.headingMedium),
          const SizedBox(height: 18),
          Row(
            children: [
              AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 48),
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
          const SizedBox(height: 18),
          _row(tr('date'), localizedDate(date)),
          _row(tr('time'), localizedTimeOfDay(time)),
          _row(tr('clinic'), doctor.address),
          const Divider(height: 32, color: AppColors.divider),
          _row(tr('fee'), '${doctor.price.toStringAsFixed(0)} ${tr('egp')}', bold: true),
          const SizedBox(height: 22),
          EyanButton(label: tr('confirmAndBook'), onPressed: () => Navigator.pop(context, true)),
          const SizedBox(height: 10),
          EyanButton(label: tr('cancel'), variant: EyanButtonVariant.text, onPressed: () => Navigator.pop(context, false)),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Text(label, style: AppTextStyles.bodyMedium),
            const Spacer(),
            Text(value, style: (bold ? AppTextStyles.headingSmall : AppTextStyles.bodyMedium).copyWith(color: bold ? AppColors.primaryDark : AppColors.textPrimary, fontWeight: FontWeight.w700)),
          ],
        ),
      );
}
