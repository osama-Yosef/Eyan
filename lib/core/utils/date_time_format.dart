import 'package:flutter/material.dart';
import '../localization/app_strings.dart';
import '../localization/locale_controller.dart';

String formatDateForDb(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

String formatTimeForDb(TimeOfDay time) =>
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';

TimeOfDay parseDbTime(String raw) {
  final parts = raw.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

int timeOfDayToMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

TimeOfDay addMinutesToTime(TimeOfDay t, int minutes) {
  final total = timeOfDayToMinutes(t) + minutes;
  return TimeOfDay(hour: (total ~/ 60) % 24, minute: total % 60);
}

const _monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

String formatFriendlyDate(DateTime date) => '${date.day} ${_monthNames[date.month - 1]} ${date.year}';

String formatFriendlyTime(DateTime dateTime) {
  final h = dateTime.hour, min = dateTime.minute.toString().padLeft(2, '0');
  final p = h >= 12 ? 'PM' : 'AM', hr = h > 12 ? h - 12 : (h == 0 ? 12 : h);
  return '$hr:$min $p';
}

String formatTimeOfDay(TimeOfDay time) {
  final h = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final m = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$h:$m $period';
}

const _monthNamesAr = ['يناير','فبراير','مارس','أبريل','مايو','يونيو','يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'];
const _weekdayShortEn = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
const _weekdayShortAr = ['اثنين','ثلاثاء','أربعاء','خميس','جمعة','سبت','حد'];

bool _isSameDate(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String localizedDate(DateTime date) {
  final now = DateTime.now();
  if (_isSameDate(date, now)) return tr('today');
  if (_isSameDate(date, now.add(const Duration(days: 1)))) return tr('tomorrow');
  if (localeController.isArabic) return '${date.day} ${_monthNamesAr[date.month - 1]} ${date.year}';
  return formatFriendlyDate(date);
}

String weekdayShort(DateTime date) {
  final idx = date.weekday - 1; // 1=Mon..7=Sun
  return localeController.isArabic ? _weekdayShortAr[idx] : _weekdayShortEn[idx];
}

String localizedTimeOfDay(TimeOfDay time) {
  final h = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final m = time.minute.toString().padLeft(2, '0');
  if (localeController.isArabic) {
    final period = time.period == DayPeriod.am ? 'ص' : 'م';
    return '$h:$m $period';
  }
  return formatTimeOfDay(time);
}

String localizedDateTime(DateTime dt) => '${localizedDate(dt)} • ${localizedTimeOfDay(TimeOfDay.fromDateTime(dt))}';

/// Compact countdown like "2d 4h" / "٢ي ٤س"
String countdownText(Duration d) {
  if (d.isNegative) return '';
  final days = d.inDays;
  final hours = d.inHours % 24;
  final minutes = d.inMinutes % 60;
  final dS = tr('daysShort'), hS = tr('hoursShort'), mS = tr('minutesShort');
  if (days > 0) return '$days$dS $hours$hS';
  if (hours > 0) return '$hours$hS $minutes$mS';
  return '$minutes$mS';
}
