<div align="center">

<img src="docs/cover.png" alt="Eyan" width="100%" />

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
[![i18n](https://img.shields.io/badge/Languages-Arabic%20·%20English-059669?style=flat-square)](#features)
[![Status](https://img.shields.io/badge/Status-UI%20complete%20·%20backend%20next-F59E0B?style=flat-square)](#status-and-roadmap)

**Book a doctor in a few taps.**
Find a clinic by doctor or specialty, pick a free time slot, keep track of your appointments,
read your prescriptions and message your doctor.

عيان — تطبيق حجز مواعيد الأطباء، بواجهة عربية وإنجليزية كاملة.

</div>

---

## Screenshots

<table>
  <tr>
    <td align="center"><img src="docs/screenshots/home.png" width="200" alt="Home"/><br/><sub><b>Home</b><br/>Search, specialties, next visit</sub></td>
    <td align="center"><img src="docs/screenshots/doctor.png" width="200" alt="Doctor"/><br/><sub><b>Doctor profile</b><br/>Rating, patients, experience</sub></td>
    <td align="center"><img src="docs/screenshots/booking.png" width="200" alt="Booking"/><br/><sub><b>Pick a slot</b><br/>Day strip and free times</sub></td>
    <td align="center"><img src="docs/screenshots/booking-confirmed.png" width="200" alt="Confirmed"/><br/><sub><b>Booked</b><br/>Confirmation and booking number</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/appointments.png" width="200" alt="Appointments"/><br/><sub><b>My appointments</b><br/>Upcoming and past</sub></td>
    <td align="center"><img src="docs/screenshots/prescriptions.png" width="200" alt="Prescriptions"/><br/><sub><b>Prescriptions</b><br/>Every visit's prescription</sub></td>
    <td align="center"><img src="docs/screenshots/prescription-details.png" width="200" alt="Prescription"/><br/><sub><b>Prescription</b><br/>Diagnosis, medicines, dosage, notes</sub></td>
    <td align="center"><img src="docs/screenshots/chats.png" width="200" alt="Chats"/><br/><sub><b>Conversations</b><br/>Online status and last message</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/screenshots/chat.png" width="200" alt="Chat"/><br/><sub><b>Chat</b><br/>Messaging with the doctor</sub></td>
    <td align="center"><img src="docs/screenshots/profile.png" width="200" alt="Profile"/><br/><sub><b>Profile</b><br/>Language, records, settings</sub></td>
    <td align="center"><img src="docs/screenshots/profile-en.png" width="200" alt="English"/><br/><sub><b>English</b><br/>Switches to LTR instantly</sub></td>
    <td align="center"><img src="docs/screenshots/login.png" width="200" alt="Login"/><br/><sub><b>Sign in</b><br/>Email, Google or Apple</sub></td>
  </tr>
</table>

## Features

- **Find a doctor:** search by doctor name or specialty, filter by specialty, see rating, number of reviews, area and consultation fee
- **Upcoming visit card** on the home screen with a live countdown
- **Doctor profile:** bio, working hours, clinic address, experience, patients and rating
- **Booking flow:** choose a day, choose a free time slot (booked slots are crossed out), review the summary and confirm
- **Appointments:** upcoming and past tabs, status badges, details and cancellation
- **Prescriptions:** a list per visit and a detail view with diagnosis, medicines, dosage and duration, the doctor's notes, and share / download
- **Chat:** conversation list with online status and a messaging screen
- **Profile:** account card, language switch, medical records, notifications, settings, help and logout
- **Bilingual:** full Arabic and English UI with automatic RTL / LTR switching at runtime

## Tech stack

| Area | Choice |
|:--|:--|
| Framework | Flutter, Dart |
| Localization | `flutter_localizations` with a lightweight string table and a `LocaleController` |
| Design | custom theme (brand color `#059669`), shared widgets for buttons, fields, avatars, status pills and empty states |
| Data | in-memory data layer (`lib/data/app_data.dart`) behind typed models |

The app has no third-party packages beyond the Flutter SDK.

```
lib/
  core/            theme, localization, shared widgets, date utilities
  data/            data store (AppData)
  models/          Doctor, Appointment, Prescription, ChatThread, ...
  features/
    auth/          splash, login, register
    home/          clinic and doctor listing
    doctor/        doctor profile and booking flow
    appointments/  appointment list and details
    prescriptions/ prescription list and details
    chat/          conversation list and chat screen
    profile/       account and settings
    root/          bottom navigation shell
```

## Getting started

```bash
flutter pub get
flutter run              # Android / iOS
flutter run -d chrome    # web preview
```

Any email and a password of six characters or more will sign you in.

## Status and roadmap

The full patient experience is built and navigable. Data currently comes from the in-app data
layer, and the models are ready to be backed by a real service.

- [ ] Supabase backend for clinics, doctors, time slots and bookings
- [ ] Real authentication in place of the local sign-in flow
- [ ] Push notifications for appointment reminders

## Author

**Osama Yosef** · Flutter developer, Cairo

[![GitHub](https://img.shields.io/badge/GitHub-osama--Yosef-181717?style=flat-square&logo=github)](https://github.com/osama-Yosef)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Osama%20Yosef-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/osama-yosef-819268319)
[![Upwork](https://img.shields.io/badge/Upwork-Hire%20me-6FDA44?style=flat-square&logo=upwork&logoColor=white)](https://upwork.com/freelancers/~014ebd205ef38ca04c)
[![Email](https://img.shields.io/badge/Email-osamayosef038%40gmail.com-EA4335?style=flat-square&logo=gmail&logoColor=white)](mailto:osamayosef038@gmail.com)
