import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

class MatchingProfileGuideScreen extends StatelessWidget {
  const MatchingProfileGuideScreen({super.key});

  static const routeName = '/matching-profile-guide';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('프로필 등록 가이드'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.matching),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: const [
          _GuideIntroCard(),
          SizedBox(height: 20),
          _ProfileChecklistCard(),
          SizedBox(height: 20),
          _SafetyCard(),
          SizedBox(height: 20),
          _NextStepsCard(),
        ],
      ),
    );
  }
}

class _GuideIntroCard extends StatelessWidget {
  const _GuideIntroCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '따뜻한 연결을 위한 준비',
      subtitle: '프로필은 당신의 마음을 소개하는 첫인상입니다. 아래 가이드라인을 참고해 주세요.',
      icon: Icons.fact_check_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppHelperText(
            icon: Icons.favorite_outline,
            text: '상실 경험, 지금 느끼는 감정, 나누고 싶은 위로 방식을 솔직하게 작성해 주세요.',
          ),
          SizedBox(height: 12),
          AppHelperText(
            icon: Icons.timer_outlined,
            text: '프로필 검토는 영업일 기준 1일 이내에 완료됩니다. 승인 상태는 내 매칭 탭에서 확인할 수 있어요.',
          ),
        ],
      ),
    );
  }
}

class _ProfileChecklistCard extends StatelessWidget {
  const _ProfileChecklistCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return AppSurfaceCard(
      title: '프로필 작성 체크리스트',
      subtitle: '아래 항목을 기준으로 작성하면 매칭 성공률이 높아집니다.',
      icon: Icons.checklist_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('필수 항목', style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.black)),
          const SizedBox(height: 8),
          const AppHelperText(
            icon: Icons.edit_note_outlined,
            text: '소개 한 줄: 상실 경험과 위로를 나누고 싶은 이유를 간단히 적어 주세요.',
          ),
          const AppHelperText(
            icon: Icons.people_outline,
            text: '나누고 싶은 관계: 부모-자녀, 형제, 반려 가족 등 원하는 매칭 유형을 구체적으로 알려주세요.',
          ),
          const AppHelperText(
            icon: Icons.schedule_outlined,
            text: '연락 가능 시간: 전화, 문자, 편지 등 선호 채널과 가능한 시간을 입력해 주세요.',
          ),
          const SizedBox(height: 20),
          Text('선택 항목', style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700, color: Colors.black)),
          const SizedBox(height: 8),
          const AppHelperText(
            icon: Icons.photo_camera_outlined,
            text: '프로필 사진: 얼굴 대신 상징 이미지를 사용해도 좋아요. 따뜻한 분위기의 사진을 추천합니다.',
          ),
          const AppHelperText(
            icon: Icons.mood_outlined,
            text: '마음 표현 카드: 요즘의 감정이나 마음가짐을 세 가지 키워드로 남겨 주세요.',
          ),
          const AppHelperText(
            icon: Icons.note_add_outlined,
            text: '공유하고 싶은 추억: 함께 나누고 싶은 이야기나 기념일을 짧게 소개해 주세요.',
          ),
        ],
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '안전 및 검토 정책',
      subtitle: '모든 프로필은 운영팀의 검토를 거쳐 안전하게 노출됩니다.',
      icon: Icons.security_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppHelperText(
            icon: Icons.privacy_tip_outlined,
            text: '연락처, 주소, 금융 정보는 입력하지 마세요. 최초 대화는 익명으로 진행됩니다.',
          ),
          AppHelperText(
            icon: Icons.flag_outlined,
            text: '부적절한 언행이 발견되면 언제든 신고해 주세요. 24시간 이내에 조치합니다.',
          ),
          AppHelperText(
            icon: Icons.tag_faces_outlined,
            text: '위로 경험을 나눌 수 있는지, 서로에게 도움이 되는지 운영팀이 함께 고민합니다.',
          ),
        ],
      ),
    );
  }
}

class _NextStepsCard extends StatelessWidget {
  const _NextStepsCard();

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      title: '다음 단계',
      subtitle: '가이드를 모두 확인했다면 프로필을 등록하고 따뜻한 연결을 시작해 보세요.',
      icon: Icons.arrow_forward,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHelperText(
            icon: Icons.chat_bubble_outline,
            text: '프로필 등록 후 익명 채팅으로 첫 인사를 나누고, 충분한 대화를 거쳐 매칭을 확정하세요.',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppOutlinedButton(
                  label: '목록으로 돌아가기',
                  leadingIcon: Icons.home_outlined,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppPrimaryButton(
                  label: '내 프로필 작성하기',
                  icon: Icons.person_add_alt_1_outlined,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
