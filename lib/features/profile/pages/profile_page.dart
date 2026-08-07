import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/presentation/pages/login_page.dart';
import '../../prescriptions/pages/prescriptions_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: localeController,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              children: [
                Text(tr('myProfile'), style: AppTextStyles.displayMedium.copyWith(fontSize: 24)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60, height: 60,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('م ع', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 20, fontFamily: 'Inter')),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isArabic ? 'مريم عادل' : 'Mariam Adel', style: AppTextStyles.headingSmall.copyWith(color: Colors.white)),
                            const SizedBox(height: 3),
                            Text('mariam.adel@email.com', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _comingSoon(context),
                        icon: const Icon(Icons.edit_outlined, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(tr('language'), style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
                  child: Row(
                    children: [
                      _langOption(context, tr('arabic'), AppLanguage.ar),
                      _langOption(context, tr('english'), AppLanguage.en),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _MenuTile(icon: Icons.receipt_long_outlined, label: tr('myPrescriptions'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionsPage()))),
                _MenuTile(icon: Icons.folder_shared_outlined, label: tr('medicalRecords'), onTap: () => _comingSoon(context)),
                _MenuTile(icon: Icons.notifications_none_rounded, label: tr('notifications'), onTap: () => _comingSoon(context)),
                _MenuTile(icon: Icons.settings_outlined, label: tr('settings'), onTap: () => _comingSoon(context)),
                _MenuTile(icon: Icons.help_outline_rounded, label: tr('helpSupport'), onTap: () => _comingSoon(context)),
                _MenuTile(icon: Icons.logout_rounded, label: tr('logout'), color: AppColors.error, onTap: () => _confirmLogout(context)),
                const SizedBox(height: 24),
                Center(child: Text('${tr('version')} 1.0.0', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textHint))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _langOption(BuildContext context, String label, AppLanguage lang) {
    final selected = localeController.value == lang;
    return Expanded(
      child: GestureDetector(
        onTap: () => localeController.setLanguage(lang),
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

  void _comingSoon(BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('comingSoon'))));

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(tr('logout'), style: AppTextStyles.headingSmall),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(tr('cancel'))),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false),
            child: Text(tr('logout'), style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.label, required this.onTap, this.color});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.divider)),
          child: Row(
            children: [
              Icon(icon, color: color ?? AppColors.textSecondary, size: 22),
              const SizedBox(width: 14),
              Expanded(child: Text(label, style: AppTextStyles.bodyLarge.copyWith(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w600))),
              Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
            ],
          ),
        ),
      ),
    );
  }
}
