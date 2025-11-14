import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _anniversaryReminder = true;
  bool _newLetter = true;
  bool _matchingStatus = true;
  bool _nightSilent = true;
  bool _marketingOptIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('설정'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.settings),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '알림 & 커뮤니케이션',
              subtitle: '기념일, 댓글, 상호 위로 매칭 등 주요 알림을 한곳에서 관리해요.',
              icon: Icons.notifications_outlined,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('기념일 알림'),
                    subtitle: const Text('기념일 7일 전 / 당일에 푸시 알림을 발송합니다.'),
                    value: _anniversaryReminder,
                    onChanged: (value) => setState(() => _anniversaryReminder = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('추모글 댓글·감사 메시지 알림'),
                    subtitle: const Text('추모관에 새로운 댓글이나 감사 메시지가 등록되면 알려드려요.'),
                    value: _newLetter,
                    onChanged: (value) => setState(() => _newLetter = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('상호 위로 매칭 알림'),
                    subtitle: const Text('매칭 수락, 대화 요청, 프로필 열람 알림을 받을 수 있어요.'),
                    value: _matchingStatus,
                    onChanged: (value) => setState(() => _matchingStatus = value),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: _anniversaryReminder || _newLetter || _matchingStatus
                        ? '알림은 기기 설정에서 권한이 허용된 경우에만 정상 발송됩니다.'
                        : '모든 알림이 꺼져 있습니다. 필요한 항목을 선택해 주세요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '야간 모드 & 이메일',
              subtitle: '푸시 알림을 받기 어려운 시간대와 이메일 수신 여부를 설정하세요.',
              icon: Icons.nightlight_outlined,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('야간 시간 푸시 알림 끄기'),
                    subtitle: const Text('오후 10시부터 오전 8시까지는 푸시 알림을 보내지 않습니다.'),
                    value: _nightSilent,
                    onChanged: (value) => setState(() => _nightSilent = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('마케팅 이메일 수신'),
                    subtitle: const Text('감사 혜택, 서비스 업데이트 소식을 이메일로 받아보세요.'),
                    value: _marketingOptIn,
                    onChanged: (value) => setState(() => _marketingOptIn = value),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  AppHelperText(
                    icon: Icons.lightbulb_outline,
                    text: _marketingOptIn
                        ? '언제든 수신 거부할 수 있으며, 중요한 공지 메일은 계속 발송됩니다.'
                        : '혜택 소식을 놓치지 않으려면 이메일 수신을 켜주세요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '알림 권한 확인',
              subtitle: '기기 알림 권한이 비활성화되어 있으면 어떤 알림도 받을 수 없어요.',
              icon: Icons.phonelink_setup_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHelperText(
                    icon: Icons.info_outline,
                    text: '기기 설정 > 앱 > TalkBoard > 알림에서 권한을 확인해 주세요.',
                  ),
                  const SizedBox(height: 12),
                  AppOutlinedButton(
                    label: '권한 설정 바로 가기',
                    leadingIcon: Icons.open_in_new,
                    badgeText: '준비 중',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('권한 설정 연동은 추후 업데이트될 예정입니다.'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '계정 & 보안',
              subtitle: '비밀번호 변경, 로그인 기기 관리, 개인정보 이용 내역을 확인할 수 있어요.',
              icon: Icons.lock_outline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.security_outlined,
                    text: '2단계 인증과 로그인 이력 확인 기능은 준비 중입니다. 곧 안전한 계정 관리를 지원할게요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '데이터 & 백업',
              subtitle: '추모관 백업, 데이터 다운로드, 개인정보 수집동의 현황을 확인하세요.',
              icon: Icons.cloud_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.cloud_sync_outlined,
                    text: '데이터 백업 기능은 준비 중입니다. 추후 CSV/JSON 형식으로 추억을 내려받을 수 있어요.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppPrimaryButton(
              label: '설정 저장하기',
              icon: Icons.save_outlined,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('설정이 저장되었습니다.')), 
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
