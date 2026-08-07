import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../root/root_shell.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() { _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const RootShell()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned(top: -60, right: -60, child: Container(width: 200, height: 200, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle))),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 48),
                      Container(width: 100, height: 62, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(50)),
                        child: const Center(child: Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 28))),
                      const SizedBox(height: 32),
                      Text(tr('welcomeBack'), style: AppTextStyles.displayMedium),
                      const SizedBox(height: 8),
                      Text(tr('loginSubtitle'), style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 36),
                      EyanTextField(hint: tr('email'), prefixIcon: Icons.mail_outline_rounded, controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterEmail') : (!v.contains('@') ? tr('invalidEmail') : null)),
                      const SizedBox(height: 14),
                      EyanTextField(hint: tr('password'), prefixIcon: Icons.lock_outline_rounded, controller: _passCtrl,
                        isPassword: true, textInputAction: TextInputAction.done, onFieldSubmitted: (_) => _submit(),
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterPassword') : (v.length < 6 ? tr('minChars') : null)),
                      const SizedBox(height: 16),
                      Row(children: [
                        GestureDetector(
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: Row(children: [
                            AnimatedContainer(duration: AppConstants.animFast, width: 22, height: 22,
                              decoration: BoxDecoration(color: _rememberMe ? AppColors.primary : AppColors.surface, borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: _rememberMe ? AppColors.primary : AppColors.divider, width: 1.5)),
                              child: _rememberMe ? const Icon(Icons.check, color: Colors.white, size: 14) : null),
                            const SizedBox(width: 8),
                            Text(tr('rememberMe'), style: AppTextStyles.bodyMedium),
                          ]),
                        ),
                        const Spacer(),
                        TextButton(onPressed: () {}, style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(tr('forgotPassword'), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600))),
                      ]),
                      const SizedBox(height: 24),
                      EyanButton(label: tr('login'), onPressed: _submit),
                      const SizedBox(height: 24),
                      Row(children: [
                        Expanded(child: Divider(color: AppColors.divider)),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(tr('orContinueWith'), style: AppTextStyles.bodySmall)),
                        Expanded(child: Divider(color: AppColors.divider)),
                      ]),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(child: _SocialBtn(label: tr('google'), icon: Icons.g_mobiledata_rounded)),
                        const SizedBox(width: 12),
                        Expanded(child: _SocialBtn(label: tr('apple'), icon: Icons.apple_rounded)),
                      ]),
                      const SizedBox(height: 28),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(tr('noAccount'), style: AppTextStyles.bodyMedium),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                          child: Text(tr('signUp'), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700))),
                      ]),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class _SocialBtn extends StatelessWidget {
  const _SocialBtn({required this.label, required this.icon});
  final String label; final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    height: 54, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.divider)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: AppColors.textPrimary, size: 22),
      const SizedBox(width: 8),
      Text(label, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600)),
    ]),
  );
}
