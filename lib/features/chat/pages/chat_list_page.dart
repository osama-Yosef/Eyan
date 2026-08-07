import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/app_data.dart';
import '../../../models/chat.dart';
import 'chat_conversation_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final threads = [...AppData.instance.chatThreads]..sort((a, b) => b.last.time.compareTo(a.last.time));
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [Text(tr('messages'), style: AppTextStyles.displayMedium.copyWith(fontSize: 24))],
                  ),
                ),
                Expanded(
                  child: threads.isEmpty
                      ? Center(child: EmptyState(icon: Icons.chat_bubble_outline_rounded, title: tr('noMessages'), subtitle: tr('startChat')))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                          itemCount: threads.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 10),
                          itemBuilder: (context, i) => _ThreadTile(thread: threads[i]),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.thread});
  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    final doctor = AppData.instance.doctorById(thread.doctorId);
    final unread = thread.unread > 0;
    final time = '${thread.last.time.hour.toString().padLeft(2, '0')}:${thread.last.time.minute.toString().padLeft(2, '0')}';
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatConversationPage(doctorId: doctor.id))),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.divider)),
        child: Row(
          children: [
            AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 54, online: thread.online),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: AppTextStyles.headingSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(thread.last.text, style: AppTextStyles.bodyMedium.copyWith(color: unread ? AppColors.textPrimary : AppColors.textSecondary, fontWeight: unread ? FontWeight.w600 : FontWeight.w400), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time, style: AppTextStyles.bodySmall),
                const SizedBox(height: 8),
                if (unread)
                  Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
