import 'package:flutter/material.dart';
import 'package:free_board/providers/accessibility_provider.dart';
import 'package:free_board/providers/auth_provider.dart';
import 'package:free_board/screens/matching_screen.dart';
import 'package:free_board/screens/memorial_detail_screen.dart';
import 'package:free_board/screens/memorial_edit_screen.dart';
import 'package:free_board/screens/memorial_letter_screen.dart';
import 'package:free_board/screens/memorial_list_screen.dart';
import 'package:free_board/screens/prayer_request_screen.dart';
import 'package:free_board/screens/prayer_request_detail_screen.dart';
import 'package:free_board/screens/prayer_request_create_screen.dart';
import 'package:free_board/screens/emotion_board_screen.dart';
import 'package:free_board/screens/emotion_post_create_screen.dart';
import 'package:free_board/screens/regret_letter_board_screen.dart';
import 'package:free_board/screens/regret_letter_create_screen.dart';
import 'package:free_board/screens/regret_letter_detail_screen.dart';
import 'package:free_board/screens/memorial_stats_screen.dart';
import 'package:free_board/screens/will_screen.dart';
import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:provider/provider.dart';
import 'package:free_board/screens/matching_profile_guide_screen.dart';
import 'package:free_board/screens/matching_profile_editor_screen.dart';
import 'package:free_board/screens/will_guide_screen.dart';
import 'package:free_board/screens/ai_memory_reply_screen.dart';
import 'package:free_board/screens/gratitude_benefits_screen.dart';
import 'package:free_board/screens/mypage_screen.dart';
import 'package:free_board/screens/profile_edit_screen.dart';
import 'package:free_board/screens/premium_subscription_screen.dart';
import 'package:free_board/screens/donation_history_screen.dart';
import 'package:free_board/screens/settings_screen.dart';
import 'package:free_board/widgets/app_bottom_nav_bar.dart';

Color _colorWithOpacity(Color color, double opacity) {
  return color.withAlpha((opacity.clamp(0.0, 1.0) * 255).round());
}

class AppPageInfo {
  const AppPageInfo({
    required this.title,
    required this.route,
    required this.icon,
    required this.description,
    required this.builder,
  });

  final String title;
  final String route;
  final IconData icon;
  final String description;
  final WidgetBuilder builder;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  static final List<_MemorialHighlightData> _todayMemorials = [
    const _MemorialHighlightData(
      title: '박정윤님 1주기',
      message: '오늘은 첫 번째 기일입니다. 함께했던 미소를 기억해요.',
      dateLabel: '오늘 · 3월 15일',
      imageUrl: 'https://picsum.photos/seed/memory1/420/520',
    ),
    const _MemorialHighlightData(
      title: '고양이 감자 2주기',
      message: '따뜻한 품을 그리워하며 작은 간식을 준비했습니다.',
      dateLabel: '오늘 · 3월 15일',
      imageUrl: 'https://picsum.photos/seed/memory2/420/520',
    ),
    const _MemorialHighlightData(
      title: '한지우님 생신',
      message: '생전 좋아하시던 노래로 추억을 꺼내보는 건 어떨까요?',
      dateLabel: '오늘 · 3월 15일',
      imageUrl: 'https://picsum.photos/seed/memory3/420/520',
    ),
  ];

  static final List<_MemorialHighlightData> _recentMemorials = [
    const _MemorialHighlightData(
      title: '이수진님 추모관',
      message: '가족과 친구들이 남긴 24개의 추모 편지',
      dateLabel: '최근 등록 · 2시간 전',
      imageUrl: 'https://picsum.photos/seed/memory4/420/520',
    ),
    const _MemorialHighlightData(
      title: '반려견 모카 추억첩',
      message: '산책 사진과 영상들이 가득 담긴 공간',
      dateLabel: '최근 등록 · 5시간 전',
      imageUrl: 'https://picsum.photos/seed/memory5/420/520',
    ),
    const _MemorialHighlightData(
      title: '김은호님 기념 추억첩',
      message: '아버지를 그리워하는 가족의 마음을 담았습니다.',
      dateLabel: '최근 등록 · 어제',
      imageUrl: 'https://picsum.photos/seed/memory6/420/520',
    ),
  ];

  static final List<_HomeStat> _stats = [
    const _HomeStat('추모관', '12곳', Icons.auto_awesome_outlined, Color(0xFF8D6E63)),
    const _HomeStat('위로 받은 인원', '87명', Icons.volunteer_activism_outlined, Color(0xFF42A5F5)),
    const _HomeStat('이번 주 추모금', '128,000원', Icons.savings_outlined, Color(0xFF66BB6A)),
  ];

  @override
  Widget build(BuildContext context) {
    final textScale = context.watch<AccessibilityProvider>().textScale;
    final double highlightListHeight =
        (320 + (textScale - 1.0) * 160).clamp(320, 440);
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('기억의 정원'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          const AccessibilityButton(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: '알림 보기',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.home),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        children: [
          AppSurfaceCard(
            title: '기억의 정원에 오신 것을 환영합니다',
            subtitle: '함께 공감하고 위로하며 소중한 기억을 간직하세요.',
            icon: Icons.favorite,
            accentColor: AppPalette.warmBrown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '슬픔은 나눌 때 치유됩니다. 오늘도 따뜻한 마음을 전해보세요.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: AppPalette.ink,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                const AppHelperText(
                  icon: Icons.tips_and_updates_outlined,
                  text: '기념일 알림과 추천 추모글을 참고하여 소중한 추억을 함께 나눠보세요.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: AppOutlinedButton(
              label: '기억의 정원 가이드로 이동',
              leadingIcon: Icons.map_outlined,
              onPressed: () {
                Navigator.pushNamed(context, '/home-navigator');
              },
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '오늘의 기념일',
            subtitle: '오늘 기억해야 할 소중한 분들을 모았어요.',
            icon: Icons.cake_outlined,
            accentColor: AppPalette.accentPink,
            child: Column(
              children: _todayMemorials
                  .map(
                    (memorial) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _AnniversaryTile(memorial: memorial),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          const _HomeSectionHeader(
            title: '오늘의 추모',
            subtitle: '사람과 반려동물의 이야기를 둘러보세요.',
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: highlightListHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: _todayMemorials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return _MemorialHighlightCard(
                  highlight: _todayMemorials[index],
                  primaryAction: () {},
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          const _HomeSectionHeader(
            title: '최근 등록된 추모관',
            subtitle: '따끈한 추모 공간을 방문해보세요.',
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: highlightListHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: _recentMemorials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return _MemorialHighlightCard(
                  highlight: _recentMemorials[index],
                  primaryAction: () {},
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          AppSurfaceCard(
            title: '나의 기록 요약',
            subtitle: '최근 일주일 기준으로 정리했어요.',
            icon: Icons.insights_outlined,
            accentColor: AppPalette.accentMint,
            iconColor: AppPalette.accentMint,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _stats
                      .map(
                        (stat) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: _HomeStatTile(stat: stat),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const AppHelperText(
                  text: '통계는 추모관 업데이트 및 기도 참여 현황에 따라 매일 오전 갱신됩니다.',
                  icon: Icons.info_outline,
                ),
                const SizedBox(height: 16),
                AppOutlinedButton(
                  label: '추모관 통계 자세히 보기',
                  leadingIcon: Icons.bar_chart_outlined,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      MemorialStatsScreen.routeName,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _HomeSectionHeader extends StatelessWidget {
  const _HomeSectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppPalette.warmBrown,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppPalette.caption,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppPalette.warmBrown,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '전체 보기 (준비 중)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 14),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnniversaryTile extends StatelessWidget {
  const _AnniversaryTile({required this.memorial});

  final _MemorialHighlightData memorial;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.warmBeige, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _colorWithOpacity(Colors.black, 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double contentWidth = constraints.maxWidth - 80;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      memorial.imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: contentWidth > 0 ? contentWidth : constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memorial.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppPalette.warmBrown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          memorial.message,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: AppPalette.caption,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.event, size: 14, color: AppPalette.warmBrown),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                memorial.dateLabel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppPalette.caption,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const [
                  _BadgeChip(label: '추모관 방문 152명'),
                  _BadgeChip(label: '댓글 24'),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: AppOutlinedButton(
                  label: '추모하러 가기',
                  leadingIcon: Icons.arrow_forward,
                  badgeText: '준비 중',
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MemorialHighlightCard extends StatelessWidget {
  const _MemorialHighlightCard({
    required this.highlight,
    required this.primaryAction,
  });

  final _MemorialHighlightData highlight;
  final VoidCallback primaryAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              highlight.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    highlight.title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      highlight.message,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    highlight.dateLabel,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: AppOutlinedButton(
                      label: '살펴보기',
                      leadingIcon: Icons.open_in_new,
                  badgeText: '준비 중',
                      onPressed: primaryAction,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeStatTile extends StatelessWidget {
  const _HomeStatTile({required this.stat});

  final _HomeStat stat;

  @override
  Widget build(BuildContext context) {
    final Color resolvedColor = Colors.white;
    final Color foreground = Colors.black;
    return Container(
      decoration: BoxDecoration(
        color: resolvedColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.08), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(stat.icon, color: foreground, size: 28),
          const SizedBox(height: 12),
          Text(
            stat.value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            stat.label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: foreground.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _MemorialHighlightData {
  const _MemorialHighlightData({
    required this.title,
    required this.message,
    required this.dateLabel,
    required this.imageUrl,
  });

  final String title;
  final String message;
  final String dateLabel;
  final String imageUrl;
}

class _HomeStat {
  const _HomeStat(this.label, this.value, this.icon, this.color);

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}

class _NavigatorAction {
  const _NavigatorAction({
    required this.label,
    this.routeName,
  });

  final String label;
  final String? routeName;
}

class _NavigatorCategory {
  const _NavigatorCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.actions,
    required this.tips,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final List<_NavigatorAction> actions;
  final List<String> tips;
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _colorWithOpacity(AppPalette.warmBrown, 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppPalette.warmBrown,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class HomeNavigatorScreen extends StatelessWidget {
  const HomeNavigatorScreen({super.key});

  static final List<_NavigatorCategory> _categories = [
    _NavigatorCategory(
      title: '추모관 관리',
      description: '추모관 생성부터 통계까지 한 번에 이동하세요.',
      icon: Icons.auto_awesome_mosaic_outlined,
      accentColor: const Color(0xFF8B7355),
      actions: [
        const _NavigatorAction(label: '추모관 목록', routeName: '/memorial-list'),
        const _NavigatorAction(label: '추모관 생성/수정', routeName: '/memorial-edit'),
        const _NavigatorAction(
          label: '추모관 통계',
          routeName: MemorialStatsScreen.routeName,
        ),
      ],
      tips: const [
        '홈 > 바로 가기 > 추모관 목록',
        '특정 추모관 상세에서 사진/영상/편지 관리',
      ],
    ),
    _NavigatorCategory(
      title: '공감 & 위로',
      description: '기도, 감정 공유, 후회 없는 편지 등 위로 기능 모음입니다.',
      icon: Icons.favorite_outline,
      accentColor: const Color(0xFFFF6B81),
      actions: [
        const _NavigatorAction(
          label: '기도 목록',
          routeName: '/prayer-request',
        ),
        const _NavigatorAction(
          label: '기도 요청 작성',
          routeName: PrayerRequestCreateScreen.routeName,
        ),
        const _NavigatorAction(
          label: '감정 공유 게시판',
          routeName: EmotionBoardScreen.routeName,
        ),
        const _NavigatorAction(
          label: '감정 글 작성',
          routeName: EmotionPostCreateScreen.routeName,
        ),
        const _NavigatorAction(
          label: '후회 없는 편지 게시판',
          routeName: RegretLetterBoardScreen.routeName,
        ),
        const _NavigatorAction(
          label: '후회 없는 편지 작성',
          routeName: RegretLetterCreateScreen.routeName,
        ),
      ],
      tips: const [
        '기도글 작성 후 함께 기도 참여 알림 전송',
        '감정 공유에서 좋아요/댓글로 위로 나누기',
        '후회 없는 편지로 전하지 못한 마음 공유',
      ],
    ),
    _NavigatorCategory(
      title: 'AI & 특별 기능',
      description: 'AI 기억 답장, 유언장, 상호 위로 매칭 기능을 안내합니다.',
      icon: Icons.smart_toy_outlined,
      accentColor: const Color(0xFF7E57C2),
      actions: [
        const _NavigatorAction(label: '상호 위로 매칭', routeName: MatchingScreen.routeName),
        const _NavigatorAction(label: 'AI 기억 답장', routeName: AiMemoryReplyScreen.routeName),
        const _NavigatorAction(label: '유언장', routeName: WillScreen.routeName),
      ],
      tips: const [
        'AI 기억 답장은 곧 답장 생성 기능과 함께 공개될 예정입니다.',
        '프로필 등록 후 상호 위로 매칭 신청',
        '유언장 템플릿으로 빠르게 초안 작성',
      ],
    ),
    _NavigatorCategory(
      title: '감사 혜택',
      description: '감사 혜택과 이벤트 정보를 빠르게 확인합니다.',
      icon: Icons.card_giftcard,
      accentColor: const Color(0xFF42A5F5),
      actions: [
        const _NavigatorAction(label: '감사 혜택', routeName: GratitudeBenefitsScreen.routeName),
      ],
      tips: const [
        '감사 혜택 배너에서 최신 쿠폰과 이벤트를 확인하세요.',
      ],
    ),
    _NavigatorCategory(
      title: '설정 & 계정 관리',
      description: '마이페이지, 앱 설정 등 계정 관련 화면으로 이동합니다.',
      icon: Icons.settings_outlined,
      accentColor: const Color(0xFF546E7A),
      actions: [
        const _NavigatorAction(label: '마이페이지', routeName: MyPageScreen.routeName),
        const _NavigatorAction(label: '앱 설정', routeName: SettingsScreen.routeName),
      ],
      tips: const [
        '마이페이지에서 프로필/추모금/구독 관리',
        '앱 설정에서 알림·야간 모드·데이터 백업 옵션 확인',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: const Text('기억의 정원 가이드'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: const [AccessibilityButton()],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentTab: AppNavTab.home),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return AppSurfaceCard(
            title: category.title,
            subtitle: category.description,
            icon: category.icon,
            accentColor: category.accentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: category.actions
                      .map(
                        (action) => AppOutlinedButton(
                          label: action.label,
                          leadingIcon: Icons.arrow_forward,
                          onPressed: action.routeName == null
                              ? null
                              : () {
                                  Navigator.pushNamed(context, action.routeName!);
                                },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  '추천 이동 경로',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppPalette.warmBrown,
                  ),
                ),
                const SizedBox(height: 8),
                AppChecklist(items: category.tips),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemCount: _categories.length,
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        actions: const [AccessibilityButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '기능 구현은 추후 단계에서 추가됩니다.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<AppPageInfo> appPageInfos = [
  AppPageInfo(
    title: '홈 화면',
    route: HomeScreen.routeName,
    icon: Icons.home,
    description: '추천 추모글, 기념일 알림, 최근 추모관 등 핵심 콘텐츠 허브.',
    builder: (_) => const HomeScreen(),
  ),
  AppPageInfo(
    title: '홈 내비게이터',
    route: '/home-navigator',
    icon: Icons.explore,
    description: '앱 전체 기능을 한눈에 보고 빠르게 이동할 수 있는 기능 지도.',
    builder: (_) => const HomeNavigatorScreen(),
  ),
  AppPageInfo(
    title: '추모관 목록',
    route: '/memorial-list',
    icon: Icons.view_list,
    description: '내가 만든 추모관을 조회하고 검색/필터링할 수 있는 목록 화면.',
    builder: (_) => const MemorialListScreen(),
  ),
  AppPageInfo(
    title: '추모관 상세',
    route: '/memorial-detail',
    icon: Icons.auto_awesome_mosaic,
    description: '고인 정보, 사진/영상, 편지, 댓글 등을 종합적으로 보여주는 화면.',
    builder: (_) => const MemorialDetailScreen(),
  ),
  AppPageInfo(
    title: '추모 편지 작성',
    route: '/memorial-letter',
    icon: Icons.edit_note,
    description: '추모관에 편지를 남기고 공개 범위를 설정합니다.',
    builder: (_) => const MemorialLetterScreen(),
  ),
  AppPageInfo(
    title: '추모관 생성/수정',
    route: '/memorial-edit',
    icon: Icons.edit,
    description: '사진, 편지, 공개 설정 등을 입력해 추모관을 만들고 수정하는 화면.',
    builder: (_) => const MemorialEditScreen(),
  ),
  AppPageInfo(
    title: '추모관 통계',
    route: MemorialStatsScreen.routeName,
    icon: Icons.bar_chart,
    description: '방문 수, 편지, 추모금 등 추모관 활동을 시각적으로 확인하는 화면.',
    builder: (_) => const MemorialStatsScreen(),
  ),
  AppPageInfo(
    title: '기도 목록',
    route: '/prayer-request',
    icon: Icons.bolt,
    description: '기도글을 모아 보고 함께 기도로 응답하는 공간.',
    builder: (_) => const PrayerRequestScreen(),
  ),
  AppPageInfo(
    title: '기도 상세',
    route: '/prayer-detail',
    icon: Icons.self_improvement,
    description: '기도 제목과 응원 메시지를 상세히 확인하는 화면.',
    builder: (_) => const PrayerRequestDetailScreen(),
  ),
  AppPageInfo(
    title: '기도 요청 작성',
    route: PrayerRequestCreateScreen.routeName,
    icon: Icons.edit_note,
    description: '새 기도 제목을 등록하고 공유할 내용을 작성합니다.',
    builder: (_) => const PrayerRequestCreateScreen(),
  ),
  AppPageInfo(
    title: '감정 공유 게시판',
    route: EmotionBoardScreen.routeName,
    icon: Icons.forum,
    description: '감사, 그리움, 위로 등의 감정을 나누고 공감하는 커뮤니티 게시판.',
    builder: (_) => const EmotionBoardScreen(),
  ),
  AppPageInfo(
    title: '감정 글 작성',
    route: EmotionPostCreateScreen.routeName,
    icon: Icons.edit_note,
    description: '감정 나눔 글을 작성하고 태그와 공개 범위를 설정합니다.',
    builder: (_) => const EmotionPostCreateScreen(),
  ),
  AppPageInfo(
    title: '후회 없는 편지',
    route: RegretLetterBoardScreen.routeName,
    icon: Icons.mail_outline,
    description: '전하지 못한 말을 편지로 남기고 공감/댓글로 위로받는 공간.',
    builder: (_) => const RegretLetterBoardScreen(),
  ),
  AppPageInfo(
    title: '후회 없는 편지 작성',
    route: RegretLetterCreateScreen.routeName,
    icon: Icons.create_outlined,
    description: '후회 없는 편지를 작성하고 공개 범위 및 태그를 설정합니다.',
    builder: (_) => const RegretLetterCreateScreen(),
  ),
  AppPageInfo(
    title: '후회 없는 편지 자세히 보기',
    route: RegretLetterDetailScreen.routeName,
    icon: Icons.email_outlined,
    description: '등록된 후회 없는 편지의 전문과 공감, 댓글 흐름을 확인합니다.',
    builder: (_) => const RegretLetterDetailScreen(),
  ),
  AppPageInfo(
    title: '유언장',
    route: WillScreen.routeName,
    icon: Icons.gavel,
    description: '미리 유언을 작성하고 템플릿을 참고할 수 있는 화면.',
    builder: (_) => const WillScreen(),
  ),
  AppPageInfo(
    title: '상호 위로 매칭',
    route: MatchingScreen.routeName,
    icon: Icons.handshake,
    description: '상실 경험을 가진 사람들끼리 프로필 매칭과 채팅을 지원.',
    builder: (_) => const MatchingScreen(),
  ),
  AppPageInfo(
    title: '상호 위로 매칭 가이드',
    route: MatchingProfileGuideScreen.routeName,
    icon: Icons.lightbulb_outline,
    description: '상호 위로 매칭 기능을 이해하고 활용하는 방법을 안내하는 화면.',
    builder: (_) => const MatchingProfileGuideScreen(),
  ),
  AppPageInfo(
    title: '상호 위로 매칭 프로필 가이드',
    route: MatchingProfileGuideScreen.routeName,
    icon: Icons.menu_book_outlined,
    description: '프로필 작성 전 확인해야 할 준비사항과 안전 가이드를 안내합니다.',
    builder: (_) => const MatchingProfileGuideScreen(),
  ),
  AppPageInfo(
    title: '상호 위로 프로필 작성',
    route: MatchingProfileEditorScreen.routeName,
    icon: Icons.person_add_alt_1_outlined,
    description: '상실 경험과 위로 방식 등을 입력해 매칭에 참여하는 프로필 작성 화면입니다.',
    builder: (_) => const MatchingProfileEditorScreen(),
  ),
  AppPageInfo(
    title: '감사 혜택',
    route: GratitudeBenefitsScreen.routeName,
    icon: Icons.card_giftcard,
    description: '감사 혜택과 참여 현황을 확인하고 신청할 수 있는 화면.',
    builder: (_) => const GratitudeBenefitsScreen(),
  ),
  AppPageInfo(
    title: '마이페이지',
    route: MyPageScreen.routeName,
    icon: Icons.person,
    description: '프로필, 추모금, 프리미엄 구독, 아이템 구매 등을 관리.',
    builder: (_) => const MyPageScreen(),
  ),
  AppPageInfo(
    title: '정보 수정',
    route: ProfileEditScreen.routeName,
    icon: Icons.edit,
    description: '닉네임, 연락처, 프로필 공개 범위를 수정하는 화면.',
    builder: (_) => const ProfileEditScreen(),
  ),
  AppPageInfo(
    title: '공개 추모관 검색',
    route: '/public-search',
    icon: Icons.search,
    description: '공개된 추모관을 검색하고 필터링하여 탐색하는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '공개 추모관 검색',
      description: '공개된 추모관을 탐색하고 상세 보기로 이동하는 검색 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '책장 디자인',
    route: '/memory-shelf',
    icon: Icons.menu_book,
    description: '추억을 책장처럼 탐색하며 과거와 미래를 시각화하는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '책장 디자인',
      description: '추억을 책장 컨셉으로 탐색하는 상징적 시각화 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '유언장 작성 가이드',
    route: WillGuideScreen.routeName,
    icon: Icons.menu_book_outlined,
    description: '유언장 작성 단계, 준비물, 주의 사항을 안내하는 가이드 화면입니다.',
    builder: (_) => const WillGuideScreen(),
  ),
  AppPageInfo(
    title: 'AI 기억 답장',
    route: AiMemoryReplyScreen.routeName,
    icon: Icons.smart_toy_outlined,
    description: 'AI가 기억을 답장하는 화면입니다.',
    builder: (_) => const AiMemoryReplyScreen(),
  ),
  AppPageInfo(
    title: '프리미엄 구독 관리',
    route: PremiumSubscriptionScreen.routeName,
    icon: Icons.workspace_premium,
    description: '프리미엄 멤버십 혜택, 결제 정보, 자동 갱신을 관리하는 화면.',
    builder: (_) => const PremiumSubscriptionScreen(),
  ),
  AppPageInfo(
    title: '추모금 내역',
    route: DonationHistoryScreen.routeName,
    icon: Icons.volunteer_activism,
    description: '추모관으로 전달된 추모금/헌화 내역을 확인하고 감사장을 보내는 화면.',
    builder: (_) => const DonationHistoryScreen(),
  ),
  AppPageInfo(
    title: '설정',
    route: SettingsScreen.routeName,
    icon: Icons.settings,
    description: '알림, 계정, 데이터 관련 설정을 한눈에 안내하는 화면.',
    builder: (_) => const SettingsScreen(),
  ),
];

final Map<String, WidgetBuilder> appRouteBuilders = {
  for (final info in appPageInfos) info.route: info.builder,
};

