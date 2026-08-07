import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/appointment_reminder_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/app_data.dart';
import '../../../models/doctor.dart';
import '../../appointments/pages/appointment_detail_page.dart';
import '../../doctor/pages/doctor_detail_page.dart';
import '../widgets/doctor_card.dart';

const List<String> _specialtyKeys = [
  'specGeneral', 'specDentist', 'specCardiologist', 'specDermatologist', 'specPediatrician',
  'specOrthopedic', 'specENT', 'specOphthalmologist', 'specNeurologist', 'specGynecologist',
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _specialty;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Doctor> get _filtered {
    final data = AppData.instance;
    return data.doctors.where((d) {
      final matchesQuery = _query.isEmpty || d.name.toLowerCase().contains(_query.toLowerCase()) || d.specialty.toLowerCase().contains(_query.toLowerCase());
      final matchesSpecialty = _specialty == null || d.specialtyKey == _specialty;
      return matchesQuery && matchesSpecialty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final data = AppData.instance;
        final next = data.nextUpcoming;
        final doctors = _filtered;
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr('helloThere'), style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 2),
                          Text(tr('findYourDoctor'), style: AppTextStyles.displayMedium.copyWith(fontSize: 24)),
                        ],
                      ),
                    ),
                    Container(
                      width: 46, height: 46,
                      decoration: BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                      child: const Icon(Icons.notifications_none_rounded, color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: tr('searchHint'),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.textSecondary), onPressed: () => setState(() { _searchCtrl.clear(); _query = ''; })),
                  ),
                ),
                if (next != null) ...[
                  const SizedBox(height: 22),
                  AppointmentReminderCard(
                    appointment: next,
                    doctor: data.doctorById(next.doctorId),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AppointmentDetailPage(appointment: next))),
                  ),
                ],
                const SizedBox(height: 24),
                SectionHeader(title: tr('specialties')),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _specialtyKeys.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final key = i == 0 ? null : _specialtyKeys[i - 1];
                      final label = i == 0 ? tr('allClinics') : tr(key!);
                      final selected = _specialty == key;
                      return GestureDetector(
                        onTap: () => setState(() => _specialty = selected ? null : key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: selected ? AppColors.primary : AppColors.divider),
                          ),
                          child: Text(label, style: AppTextStyles.bodyMedium.copyWith(color: selected ? Colors.white : AppColors.textPrimary, fontWeight: FontWeight.w600)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SectionHeader(title: '${doctors.length} ${tr('doctorsFound')}'),
                const SizedBox(height: 14),
                if (doctors.isEmpty)
                  EmptyState(icon: Icons.search_off_rounded, title: tr('noResults'))
                else
                  ...doctors.map((d) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: DoctorCard(doctor: d, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorDetailPage(doctor: d)))),
                      )),
              ],
            ),
          ),
        );
      },
    );
  }
}
