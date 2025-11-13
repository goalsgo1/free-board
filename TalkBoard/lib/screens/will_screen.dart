import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/will_guide_screen.dart';

class WillScreen extends StatefulWidget {
  const WillScreen({super.key});

  static const routeName = '/will';

  @override
  State<WillScreen> createState() => _WillScreenState();
}

class _WillScreenState extends State<WillScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _legacyNotesController = TextEditingController();
  bool _shareWithFamily = true;
  bool _enableReminders = true;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    _guardianController.dispose();
    _legacyNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('유언장 작성'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              AppSurfaceCard(
                title: '마음의 방향 정하기',
                subtitle: '가족에게 남기고 싶은 메시지와 자산 배분 계획을 차근차근 정리할 수 있어요.',
                icon: Icons.gavel_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppHelperText(
                      icon: Icons.info_outline,
                      text: '작성한 유언장은 암호화되어 저장되며, 열람 권한은 지정된 보호자에게만 부여됩니다.',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppOutlinedButton(
                            label: '작성 가이드 보기',
                            leadingIcon: Icons.menu_book_outlined,
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              await navigator.pushNamed(WillGuideScreen.routeName);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppPrimaryButton(
                            label: '자동 템플릿 작성',
                            icon: Icons.auto_awesome_outlined,
                            onPressed: () {
                              setState(() {
                                _titleController.text = '사랑하는 가족에게';
                                _messageController.text =
                                    '가족 모두가 서로를 지켜주길 바라며, 나의 바람을 몇 가지 적어두었습니다.';
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('템플릿이 적용되었습니다. 내용을 확인해 주세요.')),
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
                title: '유언장 기본 정보',
                subtitle: '제목과 전달하고 싶은 메시지를 입력하세요.',
                icon: Icons.edit_note_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _titleController,
                      label: '유언장 제목',
                      hint: '예: 사랑하는 가족에게 전하는 마음',
                      prefixIcon: const Icon(Icons.title),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '유언장의 제목을 입력해 주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _messageController,
                      label: '전하고 싶은 말',
                      hint: '남겨두고 싶은 마음을 자유롭게 작성해 주세요.',
                      maxLines: 8,
                      prefixIcon: const Icon(Icons.favorite_border),
                      validator: (value) {
                        if (value == null || value.trim().length < 20) {
                          return '20자 이상으로 마음을 남겨주세요.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '법적 대리인 및 수신 대상',
                subtitle: '관리자 또는 가족 등 열람 권한이 필요한 사람을 지정합니다.',
                icon: Icons.shield_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _guardianController,
                      label: '대표 열람자 / 보호자',
                      hint: '예: 김혜진 (언니)',
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('가족 전체와 공유'),
                      subtitle: const Text('비활성화하면 지정된 보호자에게만 공개됩니다.'),
                      value: _shareWithFamily,
                      onChanged: (value) {
                        setState(() {
                          _shareWithFamily = value;
                        });
                      },
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('기념일 알림 보내기'),
                      subtitle: const Text('기일이나 기념일에 유언장을 자동으로 전달할 수 있습니다.'),
                      value: _enableReminders,
                      onChanged: (value) {
                        setState(() {
                          _enableReminders = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '재산·추억 배분 메모',
                subtitle: '추억 물품이나 재산을 어떻게 나누고 싶은지 기록하세요.',
                icon: Icons.inventory_2_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _legacyNotesController,
                      label: '배분 메모',
                      hint: '예: 사진 앨범은 언니에게, 반려견은 친구 지민에게 부탁하고 싶어요.',
                      maxLines: 6,
                      prefixIcon: const Icon(Icons.assignment_outlined),
                    ),
                    const SizedBox(height: 16),
                    AppHelperText(
                      icon: Icons.lightbulb_outline,
                      text: _shareWithFamily
                          ? '가족 전체와 공유될 예정입니다. 민감 정보는 열람자 설정에서 재검토해 주세요.'
                          : '현재 보호자에게만 공유됩니다. 가족 공개를 원하면 상단 스위치를 켜주세요.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '저장 및 서명',
                subtitle: '임시 저장 후 전문가와 검토하거나, 서명 이미지를 첨부하세요.',
                icon: Icons.checklist_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppOutlinedButton(
                            label: '임시 저장',
                            leadingIcon: Icons.save_outlined,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('임시 저장 기능은 준비 중입니다.')),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppOutlinedButton(
                            label: '법무 검토 의뢰',
                            leadingIcon: Icons.support_agent_outlined,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('법무 검토 의뢰는 곧 열릴 예정입니다.')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppPrimaryButton(
                      label: '유언장 서명 완료하기',
                      icon: Icons.check_circle_outline,
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('필수 항목을 확인해 주세요.')),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('유언장이 안전하게 저장되었습니다.')),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '최근 작성 내역',
                subtitle: '임시 저장된 초안이나 제출 완료된 유언장을 확인할 수 있어요.',
                icon: Icons.history_outlined,
                child: Column(
                  children: const [
                    _SavedWillTile(
                      title: '사랑하는 가족에게',
                      updatedAt: '5분 전 수정 · 초안',
                      statusLabel: '초안',
                    ),
                    SizedBox(height: 12),
                    _SavedWillTile(
                      title: '반려동물 돌봄 기록',
                      updatedAt: '어제 · 서명 완료',
                      statusLabel: '완료',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SavedWillTile extends StatelessWidget {
  const _SavedWillTile({
    required this.title,
    required this.updatedAt,
    required this.statusLabel,
  });

  final String title;
  final String updatedAt;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  updatedAt,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              statusLabel,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


