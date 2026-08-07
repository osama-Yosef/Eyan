import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/date_time_format.dart';
import '../../../core/widgets/widgets.dart';
import '../../../data/app_data.dart';
import '../../../models/prescription.dart';
import 'prescription_detail_page.dart';

class PrescriptionsPage extends StatelessWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prescriptions = AppData.instance.prescriptions;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(tr('myPrescriptions'))),
      body: prescriptions.isEmpty
          ? Center(child: EmptyState(icon: Icons.receipt_long_outlined, title: tr('noPrescriptions')))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: prescriptions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) => _PrescriptionTile(prescription: prescriptions[i]),
            ),
    );
  }
}

class _PrescriptionTile extends StatelessWidget {
  const _PrescriptionTile({required this.prescription});
  final Prescription prescription;

  @override
  Widget build(BuildContext context) {
    final doctor = AppData.instance.doctorById(prescription.doctorId);
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PrescriptionDetailPage(prescription: prescription))),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
              child: const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prescription.diagnosis, style: AppTextStyles.headingSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('${tr('prescribedBy')} ${doctor.name}', style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(localizedDate(prescription.date), style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
