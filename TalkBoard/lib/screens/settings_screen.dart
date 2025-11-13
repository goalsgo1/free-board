import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/notification_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            AppSurfaceCard(
              title: '알림 & 커뮤니케이션',
              subtitle: '기념일 알림, 이메일 수신, 기기 알림 권한을 관리해요.',
              icon: Icons.notifications_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHelperText(
                    icon: Icons.info_outline,
                    text: '기기 설정에서 알림 권한을 허용해야 추모일 알림을 받을 수 있어요.',
                  ),
                  const SizedBox(height: 16),
                  AppPrimaryButton(
                    label: '알림 설정 관리',
                    icon: Icons.settings_outlined,
                    onPressed: () {
                      Navigator.pushNamed(context, NotificationSettingsScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AppSurfaceCard(
              title: '계정 & 보안',
              subtitle: '비밀번호, 로그인 기기, 개인정보 이용 동의를 확인할 수 있어요.',
              icon: Icons.lock_outline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppHelperText(
                    icon: Icons.info_outline,
                    text: '계정 보안 기능은 곧 제공될 예정입니다. 2단계 인증, 로그인 기기 관리 등을 준비 중이에요.',
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
          ],
        ),
      ),
    );
  }
}
