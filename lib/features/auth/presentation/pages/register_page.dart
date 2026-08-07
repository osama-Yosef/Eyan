import 'package:flutter/material.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../root/root_shell.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() { _nameCtrl.dispose(); _emailCtrl.dispose(); _phoneCtrl.dispose(); _passCtrl.dispose(); _confirmCtrl.dispose(); super.dispose(); }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const RootShell()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.only(left: 8, top: 8),
                child: Row(children: [IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20))])),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const SizedBox(height: 20),
                      Text(tr('createAccount'), style: AppTextStyles.displayMedium),
                      const SizedBox(height: 6),
                      Text(tr('registerSubtitle'), style: AppTextStyles.bodyMedium),
                      const SizedBox(height: 32),
                      EyanTextField(hint: tr('fullName'), prefixIcon: Icons.person_outline_rounded, controller: _nameCtrl, textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterName') : null),
                      const SizedBox(height: 14),
                      EyanTextField(hint: tr('email'), prefixIcon: Icons.mail_outline_rounded, controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterEmail') : (!v.contains('@') ? tr('invalidEmail') : null)),
                      const SizedBox(height: 14),
                      EyanTextField(hint: tr('phoneNumber'), prefixIcon: Icons.phone_outlined, controller: _phoneCtrl,
                        keyboardType: TextInputType.phone, textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterPhone') : null),
                      const SizedBox(height: 14),
                      EyanTextField(hint: tr('password'), prefixIcon: Icons.lock_outline_rounded, controller: _passCtrl,
                        isPassword: true, textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? tr('enterPassword') : (v.length < 6 ? tr('minChars') : null)),
                      const SizedBox(height: 14),
                      EyanTextField(hint: tr('confirmPassword'), prefixIcon: Icons.lock_outline_rounded, controller: _confirmCtrl,
                        isPassword: true, textInputAction: TextInputAction.done, onFieldSubmitted: (_) => _submit(),
                        validator: (v) => (v == null || v.isEmpty) ? tr('confirmPasswordHint') : (v != _passCtrl.text ? tr('passwordsNoMatch') : null)),
                      const SizedBox(height: 26),
                      EyanButton(label: tr('createAccount'), onPressed: _submit),
                      const SizedBox(height: 22),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(tr('alreadyHaveAccount'), style: AppTextStyles.bodyMedium),
                        GestureDetector(onTap: () => Navigator.pop(context),
                          child: Text(tr('login'), style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700))),
                      ]),
                      const SizedBox(height: 24),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
