import 'package:flutter/material.dart';
import '../core/localization/app_strings.dart';
import '../core/localization/locale_controller.dart';

class Doctor {
  const Doctor({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.specialtyKey,
    required this.bioEn,
    required this.bioAr,
    required this.addressEn,
    required this.addressAr,
    required this.workingHoursEn,
    required this.workingHoursAr,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.patientsCount,
    required this.experienceYears,
    required this.avatarColor,
    required this.initials,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final String specialtyKey;
  final String bioEn;
  final String bioAr;
  final String addressEn;
  final String addressAr;
  final String workingHoursEn;
  final String workingHoursAr;
  final double price;
  final double rating;
  final int reviewsCount;
  final int patientsCount;
  final int experienceYears;
  final Color avatarColor;
  final String initials;

  String get name => localeController.isArabic ? nameAr : nameEn;
  String get bio => localeController.isArabic ? bioAr : bioEn;
  String get address => localeController.isArabic ? addressAr : addressEn;
  String get workingHours => localeController.isArabic ? workingHoursAr : workingHoursEn;
  String get specialty => tr(specialtyKey);

  /// Deterministic mock slots for a given day: returns time-of-day slots
  /// with a stable booked/available pattern seeded by doctor + date.
  List<DoctorSlot> slotsFor(DateTime date) {
    final seed = id.hashCode ^ date.day ^ (date.month * 31);
    final rnd = seed.abs();
    final slots = <DoctorSlot>[];
    final startHour = 10;
    final count = 8;
    for (var i = 0; i < count; i++) {
      final totalMinutes = startHour * 60 + i * 40;
      final tod = TimeOfDay(hour: (totalMinutes ~/ 60) % 24, minute: totalMinutes % 60);
      final booked = (rnd + i * 7) % 5 == 0;
      slots.add(DoctorSlot(tod, booked));
    }
    return slots;
  }
}

class DoctorSlot {
  const DoctorSlot(this.time, this.isBooked);
  final TimeOfDay time;
  final bool isBooked;
}
