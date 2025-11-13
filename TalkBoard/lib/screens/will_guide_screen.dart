import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class WillGuideScreen extends StatelessWidget {
  const WillGuideScreen({super.key});

  static const routeName = '/will-guide';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('유언장 작성 가이드'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.home),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          AppSurfaceCard(
            title: '작성 단계별 안내',
            subtitle: '유언장을 작성하기 전 전체 흐름을 먼저 파악해 보세요.',
            icon: Icons.timeline_outlined,
            child: const AppChecklist(
              items: [
                '의미와 목적 정리: 남기고 싶은 메시지와 자산 배분 방향을 정리합니다.',
                '공동 작성자·보호자 결정: 열람 권한을 가질 사람과 법적 대리인을 선택합니다.',
                '기본 정보 작성: 제목, 메시지, 기념일 알림 여부 등을 기록합니다.',
                '재산·추억 배분 계획: 사람·기관·추억 물품별로 전달 방식을 정합니다.',
                '검토 및 보관: 법무 검토 요청 후 암호화 저장소나 보호자에게 보관을 알립니다.',
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '필수 준비 사항',
            subtitle: '작성 전에 아래 항목을 미리 정리하면 작성이 훨씬 수월해요.',
            icon: Icons.task_alt_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.family_restroom_outlined,
                  text: '유언을 전달할 가족·지인 목록과 연락 가능 수단을 정리합니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.inventory_outlined,
                  text: '금융 자산, 부동산, 추억 물품 등 배분 대상 목록을 작성합니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.verified_user_outlined,
                  text: '법적 효력을 위해 필요한 증인·공증 계획을 확인합니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.lock_outline,
                  text: '민감 정보는 암호화 상태로 보관하고 접근 권한을 최소화합니다.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppSurfaceCard(
            title: '작성 팁 & 주의 사항',
            subtitle: '진정성 있는 메시지를 남기고 법적 요건도 충족하도록 점검하세요.',
            icon: Icons.tips_and_updates_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppHelperText(
                  icon: Icons.edit_note_outlined,
                  text: '감정 표현과 구체적 지시를 균형 있게 작성하면 유족이 이해하기 쉽습니다.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.gavel_outlined,
                  text: '전자 서명 또는 자필 서명을 남기고, 작성 일자를 반드시 기재하세요.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.warning_amber_outlined,
                  text: '법적 효력은 국가마다 요구 조건이 다르므로, 필요한 경우 전문가 검토를 받으세요.',
                ),
                SizedBox(height: 8),
                AppHelperText(
                  icon: Icons.refresh_outlined,
                  text: '상황이 바뀌면 최신 정보로 갱신하고 이전 버전은 폐기하도록 안내하세요.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppPrimaryButton(
            label: '유언장 작성으로 돌아가기',
            icon: Icons.arrow_back,
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}
