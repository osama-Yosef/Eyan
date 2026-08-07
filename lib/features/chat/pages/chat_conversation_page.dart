import 'package:flutter/material.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../data/app_data.dart';
import '../../../models/chat.dart';

class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key, required this.doctorId});
  final String doctorId;

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final _ctrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    AppData.instance.sendMessage(widget.doctorId, text);
    _ctrl.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctor = AppData.instance.doctorById(widget.doctorId);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            AppAvatar(initials: doctor.initials, color: doctor.avatarColor, size: 38, online: AppData.instance.threadForDoctor(doctor.id).online),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(doctor.name, style: AppTextStyles.headingSmall.copyWith(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(
                    AppData.instance.threadForDoctor(doctor.id).online ? tr('online') : doctor.specialty,
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: AppData.instance,
        builder: (context, _) {
          final thread = AppData.instance.threadForDoctor(widget.doctorId);
          final messages = thread.messages.reversed.toList();
          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? Center(child: Text(tr('noMessages'), style: AppTextStyles.bodyMedium))
                    : ListView.builder(
                        controller: _scrollCtrl,
                        reverse: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: messages.length,
                        itemBuilder: (context, i) => _Bubble(message: messages[i]),
                      ),
              ),
              _Composer(controller: _ctrl, onSend: _send),
            ],
          );
        },
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final mine = message.fromMe;
    final time = '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}';
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        decoration: BoxDecoration(
          color: mine ? AppColors.chatBubbleMine : AppColors.chatBubbleOther,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(mine ? 16 : 4),
            bottomRight: Radius.circular(mine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message.text, style: AppTextStyles.bodyMedium.copyWith(color: mine ? Colors.white : AppColors.textPrimary, height: 1.4)),
            const SizedBox(height: 4),
            Text(time, style: AppTextStyles.bodySmall.copyWith(color: mine ? Colors.white.withValues(alpha: 0.7) : AppColors.textHint, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 14, offset: const Offset(0, -4))]),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                decoration: InputDecoration(
                  hintText: tr('typeMessage'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  fillColor: AppColors.background,
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: onSend,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
