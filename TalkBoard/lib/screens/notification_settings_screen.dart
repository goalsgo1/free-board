import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  static const routeName = '/notification-settings';

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _anniversaryReminder = true;
  bool _newLetter = true;
  bool _matchingStatus = true;
  bool _marketingOptIn = false;
  bool _nightSilent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('알림 설정'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '주요 알림',
              subtitle: '기념일, 추모글 업데이트, 매칭 상태 알림을 관리해요.',
              icon: Icons.notifications_active_outlined,
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('기념일 알림'),
                    subtitle: const Text('기념일 7일 전 / 당일에 푸시 알림을 보냅니다.'),
                    value: _anniversaryReminder,
                    onChanged: (value) => setState(() => _anniversaryReminder = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('추모글 댓글·감사 메시지'),
                    subtitle: const Text('추모관에 새로운 댓글이나 감사 메시지가 올라오면 알려드립니다.'),
                    value: _newLetter,
                    onChanged: (value) => setState(() => _newLetter = value),
                    activeColor: Colors.black,
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('상호 위로 매칭 활동'),
                    subtitle: const Text('매칭 수락, 대화 요청, 프로필 열람 알림을 받을 수 있어요.'),
                    value: _matchingStatus,
                    onChanged: (value) => setState(() => _matchingStatus = value),
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '야간 모드 & 이메일',
              subtitle: '야간 시간대 푸시와 소식 이메일 수신 여부를 설정해요.',
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
                    subtitle: const Text('감사 혜택, 업데이트 소식을 이메일로 받아볼 수 있어요.'),
                    value: _marketingOptIn,
                    onChanged: (value) => setState(() => _marketingOptIn = value),
                    activeColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  AppHelperText(
                    icon: Icons.info_outline,
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
              subtitle: '기기 시스템에서 푸시 알림 권한이 꺼져 있으면 알림을 받을 수 없어요.',
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
                    label: '권한 설정 열기',
                    leadingIcon: Icons.open_in_new,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('권한 설정 화면은 추후 시스템 연동 예정입니다.')),
                      );
                    },
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
                  const SnackBar(content: Text('알림 설정이 저장되었습니다.')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
