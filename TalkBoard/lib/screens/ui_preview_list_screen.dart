import 'package:flutter/material.dart';
import 'preview_screens/preview_home_screen.dart';
import 'preview_screens/preview_memorial_list_screen.dart';
import 'preview_screens/preview_memorial_detail_screen.dart';
import 'preview_screens/preview_memorial_create_screen.dart';
import 'preview_screens/preview_prayer_screen.dart';
import 'preview_screens/preview_emotion_board_screen.dart';
import 'preview_screens/preview_mypage_screen.dart';
import 'preview_screens/preview_search_screen.dart';
import 'preview_screens/preview_bookshelf_screen.dart';
import 'preview_screens/preview_donation_history_screen.dart';
import 'preview_screens/preview_notification_settings_screen.dart';
import 'preview_screens/preview_profile_edit_screen.dart';
import 'preview_screens/preview_memorial_share_screen.dart';
import 'preview_screens/preview_memorial_stats_screen.dart';
import 'preview_screens/preview_memorial_backup_screen.dart';
import 'preview_screens/preview_will_screen.dart';
import 'preview_screens/preview_matching_screen.dart';
import 'preview_screens/preview_events_screen.dart';
import 'preview_screens/preview_modals_screen.dart';

class UIPreviewListScreen extends StatelessWidget {
  const UIPreviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);

    return Container(
      color: softCream,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '화면 프리뷰',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Color(0xFF8B7355),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '각 화면의 UI를 미리 확인할 수 있습니다.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5C5C5C),
            ),
          ),
          const SizedBox(height: 24),
          _buildPreviewCard(
            context,
            '1. 홈 화면',
            '추천 추모글, 기념일 알림, 최근 추모관',
            Icons.home,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewHomeScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '2. 추모관 목록',
            '내가 만든 추모관 리스트, 검색, 필터',
            Icons.book,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialListScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '3. 추모관 상세',
            '고인 정보, 영원한 시간, 사진/영상/편지',
            Icons.info,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialDetailScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '4. 추모관 생성/수정',
            '단계별 추모관 생성 및 수정',
            Icons.add_circle,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialCreateScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '5. 기도 요청',
            '기도글 등록, 함께 기도 참여',
            Icons.favorite,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewPrayerScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '6. 감정 공유 게시판',
            '감정 나눔 글 작성, 좋아요, 댓글',
            Icons.chat_bubble,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewEmotionBoardScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '7. 마이페이지',
            '프로필, 추모금 관리, 프리미엄 구독',
            Icons.person,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMypageScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '8. 공개 추모관 검색',
            '공개된 추모관 검색 및 조회',
            Icons.search,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewSearchScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '9. 책장 디자인',
            '과거와 미래를 볼 수 있는 추억 탐색',
            Icons.menu_book,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewBookshelfScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '10. 추모금 내역',
            '추모금 수령/전달 내역 조회',
            Icons.account_balance_wallet,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewDonationHistoryScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '11. 알림 설정',
            '기념일, 댓글, 기도 알림 설정',
            Icons.notifications,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewNotificationSettingsScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '12. 개인정보 수정',
            '프로필 사진, 이름, 비밀번호 변경',
            Icons.edit,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewProfileEditScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '13. 추모관 공유',
            '링크, QR 코드, SNS 공유',
            Icons.share,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialShareScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '14. 추모관 통계',
            '방문 수, 댓글 수, 추모금 통계',
            Icons.bar_chart,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialStatsScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '15. 추모관 백업/내보내기',
            'PDF, 사진/영상, 편지, 전체 데이터 백업',
            Icons.backup,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMemorialBackupScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '16. 유언장',
            '유언 작성, 공개/비공개 설정, 템플릿 제공',
            Icons.article,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewWillScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '17. 상호 위로 매칭',
            '프로필 등록, 매칭 신청, 채팅, 신고',
            Icons.favorite_border,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewMatchingScreen(),
              ),
            ),
          ),
          _buildPreviewCard(
            context,
            '18. 감사 혜택',
            '감사 혜택 목록, 참여, 내 혜택 조회',
            Icons.card_giftcard,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewEventsScreen(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          _buildPreviewCard(
            context,
            '19. 팝업/모달 프리뷰',
            '모든 팝업 및 모달 UI 미리보기',
            Icons.window,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreviewModalsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [warmBeige, Colors.white],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: warmBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: warmBrown,
                  size: 28,
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
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5C5C5C),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: warmBrown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

