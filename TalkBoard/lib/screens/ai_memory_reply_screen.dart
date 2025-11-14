import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class AiMemoryReplyScreen extends StatefulWidget {
  const AiMemoryReplyScreen({super.key});

  static const routeName = '/ai-memory-reply';

  @override
  State<AiMemoryReplyScreen> createState() => _AiMemoryReplyScreenState();
}

class _AiMemoryReplyScreenState extends State<AiMemoryReplyScreen> {
  final TextEditingController _memorialController =
      TextEditingController(text: '박정윤 추모관');
  final TextEditingController _promptController = TextEditingController();
  bool _includeLetters = true;
  bool _includeVoice = true;
  bool _includeChatLogs = false;

  static const List<_SavedReply> _sampleReplies = [
    _SavedReply(
      title: '엄마에게 남기는 새벽 인사',
      createdAt: '5분 전 생성 · 1.2k 공감 예상',
      preview:
          '“새벽 공기에서 당신의 손길이 느껴져요. 오늘도 용기 내어 하루를 시작할게요.”',
      tags: ['새벽 산책', '위로', '일상'],
    ),
    _SavedReply(
      title: '기억하고 싶은 작은 습관',
      createdAt: '어제 · 초안 저장',
      preview: '“책갈피 사이에 넣어둔 메모처럼 우리 추억도 고스란히 남아있어요.”',
      tags: ['책갈피', '메모', '추억 보관'],
    ),
  ];

  @override
  void dispose() {
    _memorialController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('AI 기억 답장'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.home),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: 'AI 기억 답장은 아직 준비 중이에요',
              subtitle: '고인의 말투와 추억 자료를 기반으로 따뜻한 답장을 제안하는 기능입니다.',
              icon: Icons.smart_toy_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: '추모관에 저장된 편지·음성·사진을 학습해 말투를 복원합니다.',
                  ),
                  SizedBox(height: 8),
                  AppHelperText(
                    icon: Icons.verified_user_outlined,
                    text: '모든 데이터는 암호화된 공간에서 처리되며, 언제든 삭제를 요청할 수 있어요.',
                  ),
                  SizedBox(height: 8),
                  AppHelperText(
                    icon: Icons.lightbulb_outline,
                    text: '지금은 미리보기 화면만 제공되며, 실제 생성 기능은 순차적으로 공개될 예정입니다.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '추모관 & 자료 선택',
              subtitle: '어떤 추모관에서 답장을 생성할지 선택하고 참고할 자료를 고르세요.',
              icon: Icons.collections_bookmark_outlined,
              child: Column(
                children: [
                  AppTextField(
                    controller: _memorialController,
                    label: '추모관 이름',
                    hint: '예: 박정윤 추모 정원',
                    prefixIcon: const Icon(Icons.park_outlined),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('편지 & 편지 답장 포함'),
                    value: _includeLetters,
                    onChanged: (value) {
                      setState(() => _includeLetters = value);
                    },
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('음성 메모 포함'),
                    value: _includeVoice,
                    onChanged: (value) {
                      setState(() => _includeVoice = value);
                    },
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('채팅 로그 포함'),
                    subtitle: const Text('대화 기록은 익명 처리 후 분석됩니다.'),
                    value: _includeChatLogs,
                    onChanged: (value) {
                      setState(() => _includeChatLogs = value);
                    },
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '답장 요청 메시지',
              subtitle: 'AI에게 전하고 싶은 상황이나 감정을 짧게 설명해주세요.',
              icon: Icons.edit_note_outlined,
              child: Column(
                children: [
                  AppTextField(
                    controller: _promptController,
                    label: '요청 메시지',
                    hint: '예: 오늘은 엄마 생신이에요. 따뜻한 격려를 듣고 싶어요.',
                    maxLines: 5,
                    prefixIcon: const Icon(Icons.mood_outlined),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppOutlinedButton(
                          label: '자료 업로드',
                          leadingIcon: Icons.cloud_upload_outlined,
                          badgeText: '준비 중',
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('자료 업로드 기능은 준비 중입니다.')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppPrimaryButton(
                          label: 'AI 답장 미리보기 (준비 중)',
                          icon: Icons.auto_awesome_outlined,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('AI 답장 생성은 곧 제공될 예정입니다.')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '기억 답장 예시',
              subtitle: '최근 생성된 답장과 초안을 미리 확인할 수 있어요.',
              icon: Icons.mail_outline,
              child: Column(
                children: [
                  for (final reply in _sampleReplies) ...[
                    _SavedReplyPreview(reply: reply),
                    if (reply != _sampleReplies.last) const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 16),
                  AppOutlinedButton(
                    label: '더 많은 답장 보기',
                    leadingIcon: Icons.history_outlined,
                  badgeText: '준비 중',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('AI 답장 히스토리는 준비 중입니다.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: '홈으로 돌아가기',
              icon: Icons.home_outlined,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedReply {
  const _SavedReply({
    required this.title,
    required this.createdAt,
    required this.preview,
    required this.tags,
  });

  final String title;
  final String createdAt;
  final String preview;
  final List<String> tags;
}

class _SavedReplyPreview extends StatelessWidget {
  const _SavedReplyPreview({required this.reply});

  final _SavedReply reply;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reply.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            reply.createdAt,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
          ),
          const SizedBox(height: 12),
          Text(
            reply.preview,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: reply.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1),
                    ),
                    child: Text(
                      '#$tag',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
