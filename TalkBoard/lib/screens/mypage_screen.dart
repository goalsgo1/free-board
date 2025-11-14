import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/profile_edit_screen.dart';
import 'package:free_board/screens/premium_subscription_screen.dart';
import 'package:free_board/screens/donation_history_screen.dart';
import 'package:free_board/screens/settings_screen.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  static const routeName = '/mypage';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool _anniversaryReminder = true;
  bool _marketingOptIn = false;

  static const List<_QuickAction> _quickActions = [
    _QuickAction(
      label: '앱 설정',
      icon: Icons.settings_outlined,
      routeName: SettingsScreen.routeName,
    ),
    _QuickAction(
      label: '추모금 내역',
      icon: Icons.volunteer_activism_outlined,
      routeName: DonationHistoryScreen.routeName,
    ),
    _QuickAction(
      label: '데이터 백업',
      icon: Icons.cloud_download_outlined,
      message: '백업 기능은 순차적으로 공개됩니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.mypage),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '나의 추모 여정',
              subtitle: '추모관 활동과 혜택 참여 현황을 한눈에 확인하세요.',
              icon: Icons.favorite_outline,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 0.12),
                            width: 1.4,
                          ),
                        ),
                        child: const Icon(Icons.person, size: 28, color: Colors.black),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '임다은 님',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '2023년 11월 가입 · 추모관 2곳 관리 중',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      AppOutlinedButton(
                        label: '정보 수정',
                        leadingIcon: Icons.edit_outlined,
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            ProfileEditScreen.routeName,
                          );
                          if (!context.mounted) return;
                          if (result == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('프로필 정보가 업데이트되었습니다.'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      _ProfileStat(label: '추모관 방문', value: '132회'),
                      SizedBox(width: 12),
                      _ProfileStat(label: '남긴 편지', value: '24통'),
                      SizedBox(width: 12),
                      _ProfileStat(label: '참여한 혜택', value: '3건'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '빠른 메뉴',
              subtitle: '자주 사용하는 기능을 빠르게 실행해 보세요.',
              icon: Icons.dashboard_customize_outlined,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _quickActions
                    .map(
                      (action) => SizedBox(
                        width: 160,
                        child: AppOutlinedButton(
                          label: action.label,
                          leadingIcon: action.icon,
                          badgeText: action.message != null ? '준비 중' : null,
                          onPressed: () {
                            if (action.routeName != null) {
                              Navigator.pushNamed(context, action.routeName!);
                              return;
                            }
                            if (action.message != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(action.message!)),
                              );
                            }
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '구독 & 혜택 현황',
              subtitle: '현재 이용 중인 구독과 혜택 신청 상태를 확인할 수 있어요.',
              icon: Icons.workspace_premium_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    label: '프리미엄 구독',
                    value: '체험판 (3일 남음)',
                    highlight: true,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: 'AI 기억 답장 베타',
                    value: '대기 중 · 순번 42번',
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    label: '감사 혜택 신청',
                    value: '겨울 추모 꽃다발 (검토 중)',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppOutlinedButton(
                          label: '구독 관리',
                          leadingIcon: Icons.settings_suggest_outlined,
                          onPressed: () {
                            Navigator.pushNamed(context, PremiumSubscriptionScreen.routeName);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppPrimaryButton(
                          label: '감사 혜택 확인',
                          icon: Icons.card_giftcard_outlined,
                          onPressed: () {
                            Navigator.pushNamed(context, '/gratitude-benefits');
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
              title: '알림 & 공유 설정',
              subtitle: '기념일과 소식 알림을 원하는 방식으로 받아보세요.',
              icon: Icons.notifications_none_outlined,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('기념일 알림 받기'),
                    subtitle: const Text('기념일 7일 전 / 당일에 푸시 알림이 발송됩니다.'),
                    value: _anniversaryReminder,
                    onChanged: (value) => setState(() => _anniversaryReminder = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('신규 혜택 및 소식 수신'),
                    subtitle: const Text('기억의 정원 소식, 감사 혜택, 업데이트 알림을 이메일로 받아요.'),
                    value: _marketingOptIn,
                    onChanged: (value) => setState(() => _marketingOptIn = value),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: _marketingOptIn
                        ? '언제든 마케팅 수신을 해제할 수 있어요.'
                        : '혜택 소식을 놓치지 않으려면 수신을 허용해 주세요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '도움이 필요하신가요?',
              subtitle: '자주 묻는 질문과 1:1 문의 채널을 안내해 드릴게요.',
              icon: Icons.support_agent_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FaqLink(
                    label: '자주 묻는 질문',
                    description: '추모관 관리, AI 기능, 혜택 이용 방법을 확인하세요.',
                  ),
                  const SizedBox(height: 12),
                  _FaqLink(
                    label: '1:1 문의 등록',
                    description: '운영팀이 24시간 이내 답변 드립니다. 사진/파일 첨부 가능.',
                  ),
                  const SizedBox(height: 12),
                  _FaqLink(
                    label: '개인정보 처리방침',
                    description: '데이터 암호화와 보관 정책을 확인할 수 있어요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    label: '로그아웃',
                    leadingIcon: Icons.logout,
                    badgeText: '준비 중',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('로그아웃 기능은 준비 중입니다.')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    label: '회원탈퇴 (준비 중)',
                    icon: Icons.delete_outline,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('회원 탈퇴는 고객센터를 통해 진행해 주세요.')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: highlight
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(0, 0, 0, 0.7),
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class _FaqLink extends StatelessWidget {
  const _FaqLink({required this.label, required this.description});

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"$label" 페이지는 준비 중입니다.')),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.12), width: 1.2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        '$label (준비 중)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.label,
    required this.icon,
    this.message,
    this.routeName,
  });

  final String label;
  final IconData icon;
  final String? message;
  final String? routeName;
}
