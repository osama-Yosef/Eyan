import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../models/chat.dart';
import '../models/doctor.dart';
import '../models/prescription.dart';

class AppData extends ChangeNotifier {
  AppData._internal() {
    _seedAppointments();
    _seedPrescriptions();
    _seedChats();
  }

  static final AppData instance = AppData._internal();

  final List<Doctor> doctors = [
    const Doctor(
      id: 'd1', nameEn: 'Dr. Ahmed El-Masry', nameAr: 'د. أحمد المصري',
      specialtyKey: 'specCardiologist',
      bioEn: 'Consultant cardiologist with a focus on preventive heart care and echocardiography, dedicated to clear, calm explanations for every patient.',
      bioAr: 'استشاري قلب وأوعية دموية، مهتم بالطب الوقائي وأشعة الإيكو على القلب، وحريص إنه يشرح لمريضه كل حاجة ببساطة.',
      addressEn: 'Nasr City, Cairo', addressAr: 'مدينة نصر، القاهرة',
      workingHoursEn: 'Sat - Thu, 5:00 PM - 10:00 PM', workingHoursAr: 'السبت - الخميس، 5:00م - 10:00م',
      price: 350, rating: 4.9, reviewsCount: 218, patientsCount: 3200, experienceYears: 16,
      avatarColor: Color(0xFF0EA5E9), initials: 'AM',
    ),
    const Doctor(
      id: 'd2', nameEn: 'Dr. Sara Abdullah', nameAr: 'د. سارة عبدالله',
      specialtyKey: 'specDermatologist',
      bioEn: 'Dermatologist specialized in skin, hair and laser treatments with a gentle, modern approach to skincare.',
      bioAr: 'أخصائية جلدية وتجميل، متخصصة في مشاكل البشرة والشعر والليزر بأحدث الطرق.',
      addressEn: 'Maadi, Cairo', addressAr: 'المعادي، القاهرة',
      workingHoursEn: 'Sun - Fri, 1:00 PM - 8:00 PM', workingHoursAr: 'الأحد - الجمعة، 1:00م - 8:00م',
      price: 300, rating: 4.8, reviewsCount: 176, patientsCount: 2450, experienceYears: 11,
      avatarColor: Color(0xFFEC4899), initials: 'SA',
    ),
    const Doctor(
      id: 'd3', nameEn: 'Dr. Mahmoud Hassan', nameAr: 'د. محمود حسن',
      specialtyKey: 'specDentist',
      bioEn: 'Dental surgeon experienced in cosmetic dentistry, implants and painless root canal treatment.',
      bioAr: 'دكتور أسنان وجراحة فم، خبرة كبيرة في تجميل الأسنان والزراعة وعلاج العصب بدون ألم.',
      addressEn: 'Heliopolis, Cairo', addressAr: 'مصر الجديدة، القاهرة',
      workingHoursEn: 'Sat - Thu, 11:00 AM - 9:00 PM', workingHoursAr: 'السبت - الخميس، 11:00ص - 9:00م',
      price: 250, rating: 4.7, reviewsCount: 302, patientsCount: 4100, experienceYears: 14,
      avatarColor: Color(0xFF8B5CF6), initials: 'MH',
    ),
    const Doctor(
      id: 'd4', nameEn: 'Dr. Nour Elhoda Fathy', nameAr: 'د. نور الهدى فتحي',
      specialtyKey: 'specPediatrician',
      bioEn: 'Pediatrician who loves working with kids, focused on growth follow-up, vaccinations and newborn care.',
      bioAr: 'دكتورة أطفال بتحب شغلها مع الأطفال، مهتمة بمتابعة النمو والتطعيمات ورعاية حديثي الولادة.',
      addressEn: 'Dokki, Giza', addressAr: 'الدقي، الجيزة',
      workingHoursEn: 'Sat - Thu, 4:00 PM - 10:00 PM', workingHoursAr: 'السبت - الخميس، 4:00م - 10:00م',
      price: 200, rating: 4.9, reviewsCount: 410, patientsCount: 5600, experienceYears: 9,
      avatarColor: Color(0xFF14B8A6), initials: 'NF',
    ),
    const Doctor(
      id: 'd5', nameEn: 'Dr. Kareem Adel', nameAr: 'د. كريم عادل',
      specialtyKey: 'specOrthopedic',
      bioEn: 'Orthopedic surgeon specialized in sports injuries, joint pain and physical rehabilitation.',
      bioAr: 'استشاري عظام متخصص في إصابات الملاعب وآلام المفاصل والتأهيل الحركي.',
      addressEn: 'Mohandessin, Giza', addressAr: 'المهندسين، الجيزة',
      workingHoursEn: 'Sun - Thu, 3:00 PM - 9:00 PM', workingHoursAr: 'الأحد - الخميس، 3:00م - 9:00م',
      price: 400, rating: 4.8, reviewsCount: 154, patientsCount: 1980, experienceYears: 19,
      avatarColor: Color(0xFFF59E0B), initials: 'KA',
    ),
    const Doctor(
      id: 'd6', nameEn: 'Dr. Yasmin Tarek', nameAr: 'د. ياسمين طارق',
      specialtyKey: 'specENT',
      bioEn: 'ENT specialist treating sinus, hearing and throat conditions for both adults and children.',
      bioAr: 'أخصائية أنف وأذن وحنجرة، بتتابع حالات الجيوب الأنفية والسمع والحلق للكبار والأطفال.',
      addressEn: 'Zamalek, Cairo', addressAr: 'الزمالك، القاهرة',
      workingHoursEn: 'Sat - Wed, 12:00 PM - 6:00 PM', workingHoursAr: 'السبت - الأربعاء، 12:00م - 6:00م',
      price: 280, rating: 4.6, reviewsCount: 121, patientsCount: 1670, experienceYears: 8,
      avatarColor: Color(0xFF6366F1), initials: 'YT',
    ),
    const Doctor(
      id: 'd7', nameEn: 'Dr. Omar Sherif', nameAr: 'د. عمر شريف',
      specialtyKey: 'specOphthalmologist',
      bioEn: 'Ophthalmologist offering full eye exams, laser vision correction consultations and contact lens fittings.',
      bioAr: 'دكتور عيون، بيعمل فحص شامل للعين واستشارات تصحيح النظر بالليزر وتركيب العدسات اللاصقة.',
      addressEn: '6th of October City', addressAr: 'السادس من أكتوبر',
      workingHoursEn: 'Sat - Thu, 2:00 PM - 8:00 PM', workingHoursAr: 'السبت - الخميس، 2:00م - 8:00م',
      price: 320, rating: 4.7, reviewsCount: 98, patientsCount: 1420, experienceYears: 12,
      avatarColor: Color(0xFF0EA5E9), initials: 'OS',
    ),
    const Doctor(
      id: 'd8', nameEn: 'Dr. Hala Ramzy', nameAr: 'د. هالة رمزي',
      specialtyKey: 'specNeurologist',
      bioEn: 'Neurologist experienced in migraine management, nerve disorders and post-stroke rehabilitation.',
      bioAr: 'استشارية مخ وأعصاب، خبرة في علاج الصداع النصفي وأمراض الأعصاب والتأهيل بعد الجلطات.',
      addressEn: 'New Cairo', addressAr: 'القاهرة الجديدة',
      workingHoursEn: 'Sun - Thu, 5:00 PM - 9:00 PM', workingHoursAr: 'الأحد - الخميس، 5:00م - 9:00م',
      price: 450, rating: 4.9, reviewsCount: 87, patientsCount: 980, experienceYears: 21,
      avatarColor: Color(0xFFEF4444), initials: 'HR',
    ),
    const Doctor(
      id: 'd9', nameEn: 'Dr. Mona Ibrahim', nameAr: 'د. منى إبراهيم',
      specialtyKey: 'specGynecologist',
      bioEn: 'Obstetrician & gynecologist providing compassionate care for pregnancy follow-up and women\'s health.',
      bioAr: 'استشارية نساء وتوليد، بتقدم رعاية كاملة لمتابعة الحمل وصحة المرأة بكل اهتمام.',
      addressEn: 'Shubra, Cairo', addressAr: 'شبرا، القاهرة',
      workingHoursEn: 'Sat - Thu, 1:00 PM - 7:00 PM', workingHoursAr: 'السبت - الخميس، 1:00م - 7:00م',
      price: 300, rating: 4.8, reviewsCount: 265, patientsCount: 3800, experienceYears: 15,
      avatarColor: Color(0xFFEC4899), initials: 'MI',
    ),
    const Doctor(
      id: 'd10', nameEn: 'Dr. Tarek Salama', nameAr: 'د. طارق سلامة',
      specialtyKey: 'specGeneral',
      bioEn: 'General practitioner for everyday illnesses, checkups and family medicine.',
      bioAr: 'دكتور باطنة عامة، بيتابع الحالات اليومية والفحص الدوري وطب الأسرة.',
      addressEn: 'Alexandria - Smouha', addressAr: 'الإسكندرية - سموحة',
      workingHoursEn: 'Everyday, 10:00 AM - 11:00 PM', workingHoursAr: 'كل يوم، 10:00ص - 11:00م',
      price: 150, rating: 4.6, reviewsCount: 340, patientsCount: 6100, experienceYears: 10,
      avatarColor: Color(0xFF14B8A6), initials: 'TS',
    ),
  ];

  final List<Appointment> appointments = [];
  final List<Prescription> prescriptions = [];
  final List<ChatThread> chatThreads = [];

  Doctor doctorById(String id) => doctors.firstWhere((d) => d.id == id);

  List<Appointment> get upcomingAppointments {
    final list = appointments.where((a) => a.status == AppointmentStatus.upcoming).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return list;
  }

  List<Appointment> get pastAppointments {
    final list = appointments.where((a) => a.status != AppointmentStatus.upcoming).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return list;
  }

  Appointment? get nextUpcoming => upcomingAppointments.isEmpty ? null : upcomingAppointments.first;

  Appointment bookAppointment({required Doctor doctor, required DateTime date, required TimeOfDay time}) {
    final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    final appt = Appointment(
      id: 'a${appointments.length + 1}-${DateTime.now().millisecondsSinceEpoch}',
      doctorId: doctor.id,
      dateTime: dt,
      price: doctor.price,
      bookingRef: 'EY-${104200 + appointments.length}',
    );
    appointments.add(appt);
    notifyListeners();
    return appt;
  }

  void cancelAppointment(String id) {
    final a = appointments.firstWhere((x) => x.id == id);
    a.status = AppointmentStatus.cancelled;
    notifyListeners();
  }

  ChatThread threadForDoctor(String doctorId) {
    return chatThreads.firstWhere(
      (t) => t.doctorId == doctorId,
      orElse: () {
        final t = ChatThread(doctorId: doctorId, messages: []);
        chatThreads.add(t);
        return t;
      },
    );
  }

  void sendMessage(String doctorId, String text) {
    final thread = threadForDoctor(doctorId);
    thread.messages.add(ChatMessage(text: text, time: DateTime.now(), fromMe: true));
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1400), () {
      thread.messages.add(ChatMessage(text: _autoReply(), time: DateTime.now(), fromMe: false));
      notifyListeners();
    });
  }

  int _replyIndex = 0;
  String _autoReply() {
    const replies = [
      'تمام، وصلت الرسالة، هرد عليك بعد الكشف.',
      'خد الدوا بانتظام وابعتلي تحدث بحالتك بعد يومين.',
      'ملاحظة كويسة، هنتكلم فيها في الكشف الجاي.',
      'متقلقش، ده وارد يحصل، اتابع الإرشادات اللي قلتلك عليها.',
    ];
    final r = replies[_replyIndex % replies.length];
    _replyIndex++;
    return r;
  }

  void _seedAppointments() {
    final now = DateTime.now();
    appointments.addAll([
      Appointment(
        id: 'seed1', doctorId: 'd1',
        dateTime: DateTime(now.year, now.month, now.day, 18, 30).add(const Duration(days: 2)),
        price: 350, bookingRef: 'EY-104201',
      ),
      Appointment(
        id: 'seed2', doctorId: 'd3',
        dateTime: now.subtract(const Duration(days: 14, hours: 2)),
        price: 250, bookingRef: 'EY-104150', status: AppointmentStatus.completed,
      ),
      Appointment(
        id: 'seed3', doctorId: 'd4',
        dateTime: now.subtract(const Duration(days: 40)),
        price: 200, bookingRef: 'EY-103980', status: AppointmentStatus.completed,
      ),
    ]);
  }

  void _seedPrescriptions() {
    prescriptions.addAll([
      Prescription(
        id: 'p1', doctorId: 'd3', date: DateTime.now().subtract(const Duration(days: 14)),
        diagnosisEn: 'Mild gum inflammation', diagnosisAr: 'التهاب بسيط في اللثة',
        notesEn: 'Avoid very hot or cold food for a week and use a soft toothbrush.',
        notesAr: 'تجنب الأكل الساخن أو البارد جدًا لمدة أسبوع واستخدم فرشاة أسنان ناعمة.',
        medicines: const [
          Medicine(name: 'Hexitol Mouthwash', dosageEn: '15 ml', dosageAr: '15 مل', frequencyEn: 'Twice a day', frequencyAr: 'مرتين يوميًا', durationEn: '7 days', durationAr: '7 أيام'),
          Medicine(name: 'Cataflam 50mg', dosageEn: '1 tablet', dosageAr: 'قرص واحد', frequencyEn: 'When needed for pain', frequencyAr: 'عند الحاجة للألم', durationEn: '5 days', durationAr: '5 أيام'),
        ],
      ),
      Prescription(
        id: 'p2', doctorId: 'd4', date: DateTime.now().subtract(const Duration(days: 40)),
        diagnosisEn: 'Seasonal flu', diagnosisAr: 'أنفلونزا موسمية',
        notesEn: 'Plenty of fluids and rest. Return if fever continues past 3 days.',
        notesAr: 'الإكثار من السوائل والراحة، ولازم تيجي تاني لو الحرارة استمرت أكتر من 3 أيام.',
        medicines: const [
          Medicine(name: 'Panadol Extra', dosageEn: '1 tablet', dosageAr: 'قرص واحد', frequencyEn: 'Every 6 hours', frequencyAr: 'كل 6 ساعات', durationEn: '3 days', durationAr: '3 أيام'),
          Medicine(name: 'Flavored Vitamin C', dosageEn: '1 sachet', dosageAr: 'كيس واحد', frequencyEn: 'Once daily', frequencyAr: 'مرة يوميًا', durationEn: '10 days', durationAr: '10 أيام'),
        ],
      ),
    ]);
  }

  void _seedChats() {
    final now = DateTime.now();
    chatThreads.addAll([
      ChatThread(doctorId: 'd1', online: true, messages: [
        ChatMessage(text: 'أهلاً بيك، إزيك النهارده؟ حاسس بتحسن بعد الجلسة اللي فاتت؟', time: now.subtract(const Duration(hours: 20)), fromMe: false),
        ChatMessage(text: 'الحمد لله كتير أحسن يا دكتور، بس لسه حاسس بضيق بسيط في التنفس أحيانًا', time: now.subtract(const Duration(hours: 19, minutes: 40)), fromMe: true),
        ChatMessage(text: 'تمام، استمر على الدوا زي ما قلتلك واحرص إنك تيجي المعاد الجاي بالتحاليل', time: now.subtract(const Duration(hours: 19)), fromMe: false),
      ]),
      ChatThread(doctorId: 'd3', online: false, messages: [
        ChatMessage(text: 'دكتور اللثة لسه بتوجعني شوية بعد الأكل', time: now.subtract(const Duration(days: 2)), fromMe: true),
        ChatMessage(text: 'طبيعي في أول كام يوم، استمر على غسول الفم وهتلاقي تحسن واضح', time: now.subtract(const Duration(days: 2, hours: -1)), fromMe: false),
      ]),
    ]);
  }
}
