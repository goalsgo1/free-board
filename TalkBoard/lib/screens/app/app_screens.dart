import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:free_board/providers/auth_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final destinations = appPageInfos
        .where((info) => info.route != HomeScreen.routeName)
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('기억의 정원 홈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '필요한 주요 화면으로 이동하세요.\n현재는 네비게이션에 집중한 플레이스홀더입니다.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: destinations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final info = destinations[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(info.icon, color: Colors.blue.shade700),
                      title: Text(info.title),
                      subtitle: Text(
                        info.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pushNamed(context, info.route);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
    builder: (_) => const PlaceholderScreen(
      title: '홈 내비게이터',
      description: '앱의 주요 기능과 이동 경로를 안내하는 내비게이터 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '추모관 목록',
    route: '/memorial-list',
    icon: Icons.view_list,
    description: '내가 만든 추모관을 조회하고 검색/필터링할 수 있는 목록 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '추모관 목록',
      description: '사용자가 소유한 추모관 리스트와 검색/필터 기능을 제공합니다.',
    ),
  ),
  AppPageInfo(
    title: '추모관 상세',
    route: '/memorial-detail',
    icon: Icons.auto_awesome_mosaic,
    description: '고인 정보, 사진/영상, 편지, 댓글 등을 종합적으로 보여주는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '추모관 상세',
      description: '개별 추모관의 모든 정보와 상호작용 기능을 담을 상세 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '추모관 생성/수정',
    route: '/memorial-edit',
    icon: Icons.edit,
    description: '사진, 편지, 공개 설정 등을 입력해 추모관을 만들고 수정하는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '추모관 생성/수정',
      description: '추모관을 새로 만들거나 기존 정보를 수정하는 입력 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '기도 요청',
    route: '/prayer-request',
    icon: Icons.bolt,
    description: '기도글 등록과 함께 참여/댓글을 통해 서로 위로하는 공간.',
    builder: (_) => const PlaceholderScreen(
      title: '기도 요청',
      description: '기도글 작성과 응원 참여 흐름을 제공하는 커뮤니티 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '감정 공유 게시판',
    route: '/emotion-board',
    icon: Icons.forum,
    description: '감정 나눔 글과 댓글, 공감 기능을 제공하는 커뮤니티 게시판.',
    builder: (_) => const PlaceholderScreen(
      title: '감정 공유 게시판',
      description: '감정 나눔 글 작성과 피드백 기능을 제공하는 게시판입니다.',
    ),
  ),
  AppPageInfo(
    title: '후회 없는 편지',
    route: '/regret-letter',
    icon: Icons.mail_outline,
    description: '전하지 못한 말을 편지로 남기고 공감/댓글로 위로받는 공간.',
    builder: (_) => const PlaceholderScreen(
      title: '후회 없는 편지',
      description: '고인에게 전하지 못한 말을 공유하는 편지 콘텐츠 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '유언장',
    route: '/will',
    icon: Icons.gavel,
    description: '미리 유언을 작성하고 템플릿을 참고할 수 있는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '유언장',
      description: '유언 작성과 템플릿 제공, 공개 설정을 지원하는 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '상호 위로 매칭',
    route: '/matching',
    icon: Icons.handshake,
    description: '상실 경험을 가진 사람들끼리 프로필 매칭과 채팅을 지원.',
    builder: (_) => const PlaceholderScreen(
      title: '상호 위로 매칭',
      description: '프로필 등록과 매칭, 채팅 흐름을 담는 매칭 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '감사 혜택',
    route: '/gratitude-benefits',
    icon: Icons.card_giftcard,
    description: '감사 혜택과 참여 현황을 확인하고 신청할 수 있는 화면.',
    builder: (_) => const PlaceholderScreen(
      title: '감사 혜택',
      description: '진행 중인 혜택과 참여 내역을 보여주는 혜택 화면입니다.',
    ),
  ),
  AppPageInfo(
    title: '마이페이지',
    route: '/mypage',
    icon: Icons.person,
    description: '프로필, 추모금, 프리미엄 구독, 아이템 구매 등을 관리.',
    builder: (_) => const PlaceholderScreen(
      title: '마이페이지',
      description: '개인 정보와 결제/구독/추모금 관리를 담당하는 마이페이지입니다.',
    ),
  ),
  AppPageInfo(
    title: '설정',
    route: '/settings',
    icon: Icons.settings,
    description: '계정, 알림, 프라이버시, 데이터 관리 등 전체 설정을 통합.',
    builder: (_) => const PlaceholderScreen(
      title: '설정',
      description: '앱 계정과 알림, 데이터 설정을 관리하는 통합 설정 화면입니다.',
    ),
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
];

final Map<String, WidgetBuilder> appRouteBuilders = {
  for (final info in appPageInfos) info.route: info.builder,
};

