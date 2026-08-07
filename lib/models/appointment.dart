enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment {
  Appointment({
    required this.id,
    required this.doctorId,
    required this.dateTime,
    required this.price,
    required this.bookingRef,
    this.status = AppointmentStatus.upcoming,
  });

  final String id;
  final String doctorId;
  final DateTime dateTime;
  final double price;
  final String bookingRef;
  AppointmentStatus status;
}
