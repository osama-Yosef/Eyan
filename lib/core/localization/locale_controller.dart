import 'package:flutter/material.dart';

enum AppLanguage { ar, en }

class LocaleController extends ValueNotifier<AppLanguage> {
  LocaleController() : super(AppLanguage.ar);

  Locale get locale => value == AppLanguage.ar ? const Locale('ar') : const Locale('en');

  bool get isArabic => value == AppLanguage.ar;

  void toggle() => value = value == AppLanguage.ar ? AppLanguage.en : AppLanguage.ar;

  void setLanguage(AppLanguage lang) => value = lang;
}

final LocaleController localeController = LocaleController();

bool get isArabic => localeController.isArabic;
