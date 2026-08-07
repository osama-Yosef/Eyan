import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/app_data.dart';
import '../../../models/prescription.dart';

class PrescriptionDetailPage extends StatelessWidget {
  const PrescriptionDetailPage({super.key, required this.prescription});
  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    final doctor = AppData.instance.doctorById(prescription.doctorId);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(tr('prescriptionDetails'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.divider),
              boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 18, offset: Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Text(tr('appName'), style: AppTextStyles.headingMedium.copyWith(color: AppColors.primaryDark)),
                  ],
                ),
                const SizedBox(height: 18),
                const _DashedDivider(),
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
                    Text(localizedDate(prescription.date), style: AppTextStyles.bodySmall),
                  ],
                ),
                const SizedBox(height: 20),
                _label(tr('diagnosis')),
                const SizedBox(height: 6),
                Text(prescription.diagnosis, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 22),
                _label(tr('medicines')),
                const SizedBox(height: 10),
                ...prescription.medicines.map((m) => _MedicineTile(medicine: m)),
                const SizedBox(height: 10),
                _label(tr('doctorNotes')),
                const SizedBox(height: 6),
                Text(prescription.notes, style: AppTextStyles.bodyMedium.copyWith(height: 1.6)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          EyanButton(
            label: tr('shareDownload'),
            variant: EyanButtonVariant.outlined,
            icon: const Icon(Icons.ios_share_rounded, size: 18, color: AppColors.primary),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('comingSoon')))),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.3));
}

class _MedicineTile extends StatelessWidget {
  const _MedicineTile({required this.medicine});
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          const Icon(Icons.medication_rounded, color: AppColors.primaryDark, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medicine.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 3),
                Text('${medicine.dosage} • ${medicine.frequency} • ${medicine.duration}', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = (constraints.maxWidth / 8).floor();
          return Row(
            children: List.generate(count, (i) => Expanded(child: Container(height: 1, color: i.isEven ? AppColors.divider : Colors.transparent))),
          );
        },
      ),
    );
  }
}
