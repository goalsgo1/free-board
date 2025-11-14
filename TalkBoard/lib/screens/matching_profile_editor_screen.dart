import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class MatchingProfileEditorScreen extends StatefulWidget {
  const MatchingProfileEditorScreen({super.key});

  static const routeName = '/matching-profile-editor';

  @override
  State<MatchingProfileEditorScreen> createState() => _MatchingProfileEditorScreenState();
}

class _MatchingProfileEditorScreenState extends State<MatchingProfileEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  final TextEditingController _memoryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  bool _offerComfort = false;
  bool _shareAnniversary = true;
  bool _allowAnonymousChat = true;

  @override
  void dispose() {
    _headlineController.dispose();
    _storyController.dispose();
    _availabilityController.dispose();
    _memoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('내 프로필 작성'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.matching),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              AppSurfaceCard(
                title: '기본 소개',
                subtitle: '어떤 위로를 나누고 싶은지 한 문장으로 적어주세요.',
                icon: Icons.person_pin_circle_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _headlineController,
                      label: '프로필 한 줄 소개',
                      hint: '예: 딸을 잃은 엄마, 편지로 위로를 나누고 싶어요',
                      prefixIcon: const Icon(Icons.short_text),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '프로필 소개를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _storyController,
                      label: '상세 소개',
                      hint: '상실 경험과 앞으로 나누고 싶은 이야기, 기대하는 관계를 적어주세요.',
                      maxLines: 8,
                      prefixIcon: const Icon(Icons.article_outlined),
                      validator: (value) {
                        if (value == null || value.trim().length < 30) {
                          return '30자 이상으로 마음을 나눠주세요.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '소통 설정',
                subtitle: '어떤 방식으로 위로를 주고받고 싶은지 알려주세요.',
                icon: Icons.handshake_outlined,
                child: Column(
                  children: [
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('먼저 위로를 건네고 싶어요'),
                      subtitle: const Text('활성화 시 “위로 전하고 싶어요” 목록에도 노출됩니다.'),
                      value: _offerComfort,
                      onChanged: (value) {
                        setState(() => _offerComfort = value);
                      },
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('기념일을 함께 기억하고 싶어요'),
                      subtitle: const Text('기념일 정보를 공유하면 추천 알고리즘이 더욱 정밀해집니다.'),
                      value: _shareAnniversary,
                      onChanged: (value) {
                        setState(() => _shareAnniversary = value);
                      },
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('익명 채팅부터 시작'),
                      subtitle: const Text('비활성화 시 매칭 직후 닉네임이 공개됩니다.'),
                      value: _allowAnonymousChat,
                      onChanged: (value) {
                        setState(() => _allowAnonymousChat = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: _availabilityController,
                      label: '연락 가능 시간/채널',
                      hint: '예: 평일 저녁 8시 이후, 편지/문자 선호',
                      prefixIcon: const Icon(Icons.schedule_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '추억 & 키워드',
                subtitle: '함께 나누고 싶은 추억이나 키워드를 남겨 주세요.',
                icon: Icons.collections_bookmark_outlined,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _memoryController,
                      label: '공유하고 싶은 추억',
                      hint: '예: 매년 함께 듣던 음악, 기억하고 싶은 장소 등',
                      maxLines: 5,
                      prefixIcon: const Icon(Icons.photo_library_outlined),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _tagsController,
                      label: '키워드 태그 (쉼표로 구분)',
                      hint: '예: 엄마, 편지, 주말 산책',
                      prefixIcon: const Icon(Icons.sell_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSurfaceCard(
                title: '작성 전 확인 사항',
                subtitle: '개인정보 보호 원칙과 운영 정책을 다시 한번 확인해 주세요.',
                icon: Icons.rule_folder_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AppHelperText(
                      icon: Icons.lock_outline,
                      text: '연락처, 계좌번호 등 개인정보는 작성하지 않습니다. 필요 시 추후 동의 절차를 거칩니다.',
                    ),
                    SizedBox(height: 8),
                    AppHelperText(
                      icon: Icons.shield_outlined,
                      text: '작성 내용은 운영팀 검토 후 공개되며, 부적절한 표현은 수정 요청될 수 있습니다.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      label: '임시 저장',
                      leadingIcon: Icons.save_outlined,
                      badgeText: '준비 중',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('임시 저장 기능은 준비 중입니다.')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryButton(
                      label: '프로필 제출하기',
                      icon: Icons.check_circle_outline,
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('필수 항목을 확인해 주세요.')),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('프로필이 등록 요청되었습니다. 검토 후 알려드릴게요.')),
                        );
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
