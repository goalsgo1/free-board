import 'package:flutter/material.dart';

import 'package:free_board/widgets/accessibility_button.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_palette.dart';
import 'package:free_board/screens/preview_screens/preview_memorial_letter_write_screen.dart';
import 'package:free_board/screens/preview_screens/preview_memorial_share_screen.dart';
import 'package:free_board/screens/preview_screens/preview_memorial_stats_screen.dart';
import 'package:free_board/screens/preview_screens/preview_memorial_backup_screen.dart';
import 'package:free_board/screens/preview_screens/preview_will_screen.dart';
import 'package:free_board/screens/preview_screens/preview_matching_screen.dart';
import 'package:free_board/screens/preview_screens/preview_events_screen.dart';

import 'preview_home_navigator_screen.dart';

class HomeNavigatorCategory {
  const HomeNavigatorCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.targetBuilder,
    required this.flowSteps,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final Widget Function() targetBuilder;
  final List<String> flowSteps;
}

final List<HomeNavigatorCategory> homeNavigatorCategories = [
  HomeNavigatorCategory(
    title: '추모관 관리',
    description: '추모관 생성·관리부터 통계까지 확인합니다.',
    icon: Icons.auto_awesome_mosaic_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: PreviewHomeNavigatorScreen.new,
    flowSteps: [
      '홈 → 기억의 정원 가이드',
      '📁 추모관 관리 카드 선택',
      '원하는 기능 카드에서 "바로 가기" 또는 경로 안내 확인',
    ],
  ),
  HomeNavigatorCategory(
    title: '공감 및 위로',
    description: '감정 공유, 후회 없는 편지, 기도 요청 등 위로 기능을 모았습니다.',
    icon: Icons.favorite_outline,
    accentColor: Color(0xFFFF6B81),
    targetBuilder: PreviewHomeNavigatorScreen.new,
    flowSteps: [
      '홈 → 기억의 정원 가이드',
      '💬 공감 및 위로 카드 선택',
      '필요한 기능을 골라 "바로 가기" 실행',
    ],
  ),
  HomeNavigatorCategory(
    title: 'AI 기억 답장',
    description: '고인의 말투로 답장을 생성하는 AI 기억 답장 기능입니다.',
    icon: Icons.smart_toy_outlined,
    accentColor: Color(0xFF7E57C2),
    targetBuilder: PreviewHomeNavigatorScreen.new,
    flowSteps: [
      '홈 → 기억의 정원 가이드',
      '🤖 AI 기능 카드 선택',
      'AI 기억 답장 카드에서 "바로 가기" 누르기',
    ],
  ),
  HomeNavigatorCategory(
    title: '특별 기능',
    description: '유언장과 상호 위로 매칭 등 특별 기능을 안내합니다.',
    icon: Icons.volunteer_activism_outlined,
    accentColor: Color(0xFF5C6BC0),
    targetBuilder: PreviewHomeNavigatorScreen.new,
    flowSteps: [
      '홈 → 기억의 정원 가이드',
      '📜 특별 기능 카드 선택',
      '유언장/상호위로 매칭 기능으로 이동',
    ],
  ),
  HomeNavigatorCategory(
    title: '12. 개인 정보 수정',
    description: '프로필 사진, 이름, 비밀번호 변경',
    icon: Icons.person_outline,
    accentColor: Color(0xFF546E7A),
    targetBuilder: () => const PreviewHomeNavigatorScreen(),
    flowSteps: [
      '홈 → 기억의 정원 가이드',
      '⚙️ 설정 및 관리 카드 선택',
      '설정 항목 중 필요한 기능으로 이동',
    ],
  ),
  HomeNavigatorCategory(
    title: '13. 추모 편지 남기기',
    description: '따뜻한 마음을 담아 편지를 작성합니다.',
    icon: Icons.edit_note_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewMemorialLetterWriteScreen(),
    flowSteps: [
      '홈 → 추모 편지 남기기',
      '편지 작성 화면으로 이동',
    ],
  ),
  HomeNavigatorCategory(
    title: '14. 추모관 공유',
    description: '링크, QR 코드, SNS 공유',
    icon: Icons.share_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewMemorialShareScreen(),
    flowSteps: [
      '추모관 상세 → 공유 버튼',
      '공유 옵션 선택 후 링크 전송',
    ],
  ),
  HomeNavigatorCategory(
    title: '15. 추모관 통계',
    description: '방문 수, 댓글 수, 추모금 통계',
    icon: Icons.pie_chart_outline,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewMemorialStatsScreen(),
    flowSteps: [
      '추모관 상세 → 통계 버튼',
      '통계 차트 확인',
    ],
  ),
  HomeNavigatorCategory(
    title: '16. 추모관 백업/내보내기',
    description: 'PDF, 사진/영상, 편지, 전체 데이터 백업',
    icon: Icons.archive_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewMemorialBackupScreen(),
    flowSteps: [
      '추모관 상세 → 백업 버튼',
      '원하는 형식으로 백업 실행',
    ],
  ),
  HomeNavigatorCategory(
    title: '17. 유언장',
    description: '유언 작성, 공개/비공개 설정, 템플릿 제공',
    icon: Icons.article_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewWillScreen(),
    flowSteps: [
      '마이페이지 → 유언장',
      '유언 작성 및 공유 설정',
    ],
  ),
  HomeNavigatorCategory(
    title: '18. 상호 위로 매칭',
    description: '프로필 등록, 매칭 신청, 채팅, 신고',
    icon: Icons.handshake_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewMatchingScreen(),
    flowSteps: [
      '마이페이지 → 상호 위로 매칭',
      '프로필 등록 후 매칭 신청',
    ],
  ),
  HomeNavigatorCategory(
    title: '19. 감사 혜택',
    description: '감사 혜택 목록, 참여, 내 혜택 조회',
    icon: Icons.card_giftcard_outlined,
    accentColor: Color(0xFF8B7355),
    targetBuilder: () => const PreviewEventsScreen(),
    flowSteps: [
      '홈 → 감사 혜택 배너 또는 마이페이지',
      '혜택 참여 및 확인',
    ],
  ),
];

class PreviewHomeScreen extends StatelessWidget {
  const PreviewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color gentlePink = Color(0xFFFFE5E5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('기억의 정원'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 앱의 목적과 마인드
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    warmBeige,
                    warmBeige.withOpacity(0.9),
                    const Color(0xFFF0EBE0),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warmBrown, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: warmBrown.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: Colors.red[300], size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        '기억의 정원',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8B7355),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: warmBrown.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '슬픔은 나눌 때 치유됩니다',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B7355),
                            height: 1.5,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '함께 공감하고 위로하며,\n소중한 기억을 간직하세요.\n\n슬픔을 혼자 간직하기보다,\n함께 나누며 위로받으세요.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.8,
                            color: warmBrown.withOpacity(0.9),
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                warmBrown.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people, color: warmBrown, size: 18),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '함께하는 추모, 함께하는 위로',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: warmBrown.withOpacity(0.8),
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 1,
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
            ),
            const SizedBox(height: 24),
            // 기념일 알림
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gentlePink, gentlePink.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warmBrown, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: warmBrown.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cake, color: warmBrown),
                      const SizedBox(width: 8),
                      const Text(
                        '오늘 기념일인 추모관',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: warmBrown.withOpacity(0.3), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '[고인 이름]님의 [기념일]',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8B7355),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2024년 3월 15일',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5C5C5C),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [warmBrown, warmBrown.withOpacity(0.8)],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: warmBrown.withOpacity(0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              '추모하러 가기 →',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 오늘의 추모
            const Text(
              '📖 오늘의 추모',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B7355),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildMemorialCard('이름1', '편지 요약...', warmBeige),
                  const SizedBox(width: 12),
                  _buildMemorialCard('이름2', '편지 요약...', warmBeige),
                  const SizedBox(width: 12),
                  _buildMemorialCard('이름3', '편지 요약...', warmBeige),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 가슴을 울리는 추모글
            Row(
              children: [
                Icon(Icons.favorite, color: warmBrown, size: 24),
                const SizedBox(width: 8),
                const Text(
                  '가슴을 울리는 추모글',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B7355),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 감동적인 추모글 카드들
            _buildEmotionalMemorialCard(
              '김 할머니',
              '할머니, 보고 싶어요. 항상 제 곁에 계신 것 같아요. 할머니의 따뜻한 손길과 미소가 아직도 제 마음속에 살아있습니다. 평생 잊지 않겠습니다.',
              '따뜻한 마음',
              '3일 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '이 아버지',
              '아버지의 따뜻한 손길이 아직도 느껴집니다. 아버지가 가르쳐주신 모든 것들이 제 인생의 등불이 되었습니다. 고맙습니다, 아버지.',
              '사랑하는 아들',
              '1주일 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '박 어머니',
              '엄마, 보고 싶어요. 엄마의 요리 냄새, 엄마의 목소리, 엄마의 따뜻한 품이 그리워집니다. 하늘에서 우리를 지켜보고 계시죠.',
              '사랑하는 딸',
              '2주일 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '최 할아버지',
              '할아버지의 지혜로운 말씀들이 아직도 제 귓가에 생생합니다. 할아버지가 보여주신 삶의 자세를 평생 따라가겠습니다.',
              '사랑하는 손자',
              '3주일 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '정 어머니',
              '엄마, 당신의 미소가 하늘에서 우리를 지켜보고 계시죠. 엄마가 남겨주신 사랑이 제 인생의 가장 큰 힘이 되었습니다.',
              '사랑하는 아들',
              '1개월 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '강 아버지',
              '아버지, 보고 싶습니다. 아버지의 강인한 정신과 따뜻한 마음이 제게 전해져 오고 있습니다. 평생 아버지의 가르침을 잊지 않겠습니다.',
              '사랑하는 딸',
              '1개월 전',
            ),
            const SizedBox(height: 16),
            _buildEmotionalMemorialCard(
              '윤 할머니',
              '할머니의 손으로 만든 음식 냄새가 아직도 코끝에 맴돕니다. 할머니의 사랑이 제 마음속에 영원히 살아있을 것입니다.',
              '사랑하는 손녀',
              '2개월 전',
            ),
            const SizedBox(height: 32),
            // 앱 기능 안내
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    warmBeige,
                    warmBeige.withOpacity(0.9),
                    const Color(0xFFF0EBE0),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warmBrown, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: warmBrown.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: warmBrown, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        '앱에서 사용할 수 있는 기능',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B7355),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureItem(
                    Icons.book,
                    '추모관 생성/관리',
                    '고인을 위한 추모관을 만들고 관리할 수 있습니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.photo_library,
                    '콘텐츠 관리',
                    '사진, 영상, 편지(텍스트/음성)를 업로드하고 관리합니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.favorite,
                    '추모 활동',
                    '댓글 작성, 기도 요청, 감정 공유로 함께 추모합니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.account_balance_wallet,
                    '추모금 시스템',
                    '추모금을 전달하고 수령할 수 있습니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.access_time,
                    '영원한 시간',
                    '고인이 돌아가신 날부터 새로운 삶의 시간을 시각화합니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.share,
                    '공유 및 통계',
                    '추모관을 공유하고 활동 통계를 확인할 수 있습니다',
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(
                    Icons.backup,
                    '백업/내보내기',
                    '추모관 데이터를 PDF, 사진/영상, 텍스트로 백업합니다',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildHomeNavigatorSection(context),
            const SizedBox(height: 24),
            // 애완동물 추모관 안내 섹션
            _buildPetMemorialSection(),
            const SizedBox(height: 24),
            // 감사 혜택 배너
            _buildEventBanner(),
            const SizedBox(height: 24),
            // 최근 등록된 추모관
            const Text(
              '📚 최근 등록된 추모관',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B7355),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSimpleCard('이름1', warmBeige),
                  const SizedBox(width: 12),
                  _buildSimpleCard('이름2', warmBeige),
                  const SizedBox(width: 12),
                  _buildSimpleCard('이름3', warmBeige),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHomeNavigatorSection(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            warmBeige,
            warmBeige.withOpacity(0.92),
            const Color(0xFFEADFD1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: warmBrown, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.28),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: warmBrown.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: warmBrown.withOpacity(0.25), width: 1.5),
                ),
                child: const Icon(Icons.explore, color: Color(0xFF8B7355)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '기억의 정원 가이드',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B7355),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '홈 화면에서 "기억의 정원 가이드" 버튼을 누르면 필요한 기능으로 바로 이동하거나 경로 안내를 확인할 수 있습니다.',
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFF5C5C5C),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in homeNavigatorCategories.take(6))
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: category.accentColor.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: category.accentColor.withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5C4033),
                    ),
                  ),
                ),
            ],
          ),
          if (homeNavigatorCategories.length > 6) ...[
            const SizedBox(height: 12),
            const Text(
              '자세한 구성은 가이드 화면 전체 프리뷰에서 확인할 수 있습니다.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: Color(0xFF6D6D6D),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PreviewHomeNavigatorScreen(),
                  ),
                );
              },
              icon: Icon(Icons.slideshow, color: warmBrown),
              label: const Text('기억의 정원 가이드 전체 보기'),
              style: OutlinedButton.styleFrom(
                foregroundColor: warmBrown,
                side: BorderSide(color: warmBrown.withOpacity(0.6), width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigatorQuickCard(
    BuildContext context,
    HomeNavigatorCategory category,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            category.accentColor.withOpacity(0.16),
            category.accentColor.withOpacity(0.07),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: category.accentColor.withOpacity(0.45),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: category.accentColor.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: category.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category.icon,
                  color: category.accentColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: category.accentColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            category.description,
            style: const TextStyle(
              fontSize: 13,
              height: 1.6,
              color: Color(0xFF4E4E4E),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => _handleNavigatorAction(context, category),
            style: ElevatedButton.styleFrom(
              backgroundColor: category.accentColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('바로 가기'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => _showNavigatorFlowDialog(context, category),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF8B7355),
              side: const BorderSide(color: Color(0xFF8B7355), width: 1.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text('경로 보기'),
          ),
        ],
      ),
    );
  }

  void _handleNavigatorAction(
    BuildContext context,
    HomeNavigatorCategory category,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => category.targetBuilder()),
    );
  }

  void _showNavigatorFlowDialog(
    BuildContext context,
    HomeNavigatorCategory category,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${category.title} 경로 안내'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final step in category.flowSteps)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          step,
                          style: const TextStyle(height: 1.6),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  Widget _buildPetMemorialSection() {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE8F5E9),
            const Color(0xFFF1F8E9),
            warmBeige.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF81C784).withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF81C784).withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF81C784).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF81C784).withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.pets,
                  size: 32,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  '🐾 애완동물과의 추억도 함께',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C2C2C),
                    letterSpacing: 0.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: warmBrown.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '"사랑하는 반려동물도\n여기서 기억할 수 있습니다"',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C2C2C),
                    height: 1.6,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildPetIcon('🐕', '강아지'),
                    const SizedBox(width: 12),
                    _buildPetIcon('🐈', '고양이'),
                    const SizedBox(width: 12),
                    _buildPetIcon('🐹', '햄스터'),
                    const SizedBox(width: 12),
                    _buildPetIcon('🐰', '토끼'),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '강아지, 고양이, 새, 햄스터, 토끼...\n함께했던 모든 순간을 소중히 간직하세요',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5C5C5C),
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                        color: Color(0xFF4CAF50),
                        width: 2,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: 20,
                          color: Color(0xFF4CAF50),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '애완동물 추모관 만들기',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetIcon(String emoji, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9).withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF81C784).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF5C5C5C),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventBanner() {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withOpacity(0.2),
            Colors.pink.withOpacity(0.15),
            Colors.orange.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.purple.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.card_giftcard,
                    size: 32,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🎁 초기 가입자 감사 혜택',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C2C2C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '프리미엄 3개월 무료!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Color(0xFF5C5C5C),
                          ),
                          const SizedBox(width: 4),
                          const Flexible(
                            child: Text(
                              '~2024.03.31',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: warmBrown,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemorialCard(String name, String summary, Color color) {
    const Color warmBrown = Color(0xFF8B7355);
    return Container(
      width: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.9)],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              border: Border(
                bottom: BorderSide(color: warmBrown.withOpacity(0.3), width: 2),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: warmBrown.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '사진',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8B7355),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      summary,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF5C5C5C),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      '자세히 보기',
                      style: TextStyle(fontSize: 11),
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

  Widget _buildSimpleCard(String name, Color color) {
    const Color warmBrown = Color(0xFF8B7355);
    return Container(
      width: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.9)],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[400]!,
                  Colors.grey[300]!,
                  Colors.grey[400]!,
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: warmBrown, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.image, size: 35, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8B7355),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionalMemorialCard(
    String name,
    String letter,
    String author,
    String time,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color gentlePink = Color(0xFFFFE5E5);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            gentlePink.withOpacity(0.3),
            warmBeige.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: warmBrown, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        warmBeige,
                        warmBeige.withOpacity(0.8),
                        warmBeige,
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: warmBrown, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person, size: 28, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF8B7355),
                          letterSpacing: 0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.edit, size: 12, color: warmBrown.withOpacity(0.7)),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              author,
                              style: TextStyle(
                                fontSize: 12,
                                color: warmBrown.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time, size: 12, color: warmBrown.withOpacity(0.7)),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 12,
                                color: warmBrown.withOpacity(0.7),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red[300],
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 구분선
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    warmBrown.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 편지 내용
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: warmBrown.withOpacity(0.2), width: 1),
              ),
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF5C5C5C),
                  letterSpacing: 0.2,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            // 하단 버튼
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [warmBrown, warmBrown.withOpacity(0.85)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: warmBrown.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        '전체 보기',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown, width: 1.5),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.share, color: warmBrown, size: 20),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: warmBrown.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: warmBrown.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: warmBrown.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: warmBrown,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B7355),
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF5C5C5C),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    const Color warmBrown = Color(0xFF8B7355);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: warmBrown,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '추모관'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '기도'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: '감정'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
      ],
    );
  }
}

