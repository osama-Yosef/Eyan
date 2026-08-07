import '../core/localization/locale_controller.dart';

class Medicine {
  const Medicine({
    required this.name,
    required this.dosageEn,
    required this.dosageAr,
    required this.frequencyEn,
    required this.frequencyAr,
    required this.durationEn,
    required this.durationAr,
  });

  final String name;
  final String dosageEn;
  final String dosageAr;
  final String frequencyEn;
  final String frequencyAr;
  final String durationEn;
  final String durationAr;

  String get dosage => localeController.isArabic ? dosageAr : dosageEn;
  String get frequency => localeController.isArabic ? frequencyAr : frequencyEn;
  String get duration => localeController.isArabic ? durationAr : durationEn;
}

class Prescription {
  const Prescription({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.diagnosisEn,
    required this.diagnosisAr,
    required this.notesEn,
    required this.notesAr,
    required this.medicines,
  });

  final String id;
  final String doctorId;
  final DateTime date;
  final String diagnosisEn;
  final String diagnosisAr;
  final String notesEn;
  final String notesAr;
  final List<Medicine> medicines;

  String get diagnosis => localeController.isArabic ? diagnosisAr : diagnosisEn;
  String get notes => localeController.isArabic ? notesAr : notesEn;
}
