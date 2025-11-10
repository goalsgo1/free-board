import 'package:flutter/material.dart';

import 'package:free_board/screens/preview_screens/preview_home_screen.dart';
import 'package:free_board/screens/preview_screens/preview_memorial_letter_write_screen.dart';

class PreviewHomeNavigatorScreen extends StatelessWidget {
  const PreviewHomeNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color gentlePink = Color(0xFFFFE5E5);
    const Color softGreen = Color(0xFFE8F5E9);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '기억의 정원 가이드',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 안내 문구
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    warmBeige,
                    warmBeige.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warmBrown, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: warmBrown.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.explore, color: warmBrown, size: 28),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '기억의 정원에서 제공하는 모든 기능을 한눈에 확인하세요',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8B7355),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '각 기능을 탭하면 해당 화면으로 바로 이동하거나, 경로 안내를 확인할 수 있습니다.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5C5C5C),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 추모관 관련 기능
            _buildCategorySection(
              '📁 추모관 관리',
              '고인을 기억하고 추모하는 공간',
              warmBrown,
              [
                _buildFeatureCard(
                  '추모관 만들기',
                  '고인을 위한 디지털 추모관 생성',
                  '홈 → 하단 네비게이션 [추모관 목록] → [+] 버튼',
                  '추모관 생성 화면으로 바로 이동',
                  Icons.add_circle_outline,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '내 추모관 보기',
                  '만든 추모관 목록 확인 및 관리',
                  '홈 → 하단 네비게이션 [추모관 목록]',
                  '추모관 목록 화면으로 바로 이동',
                  Icons.folder_outlined,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모관 상세 보기',
                  '사진, 영상, 편지, 댓글 확인',
                  '추모관 목록 → 추모관 카드 선택',
                  '추모관 상세 화면으로 바로 이동',
                  Icons.info_outline,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '영원한 시간',
                  '고인의 새로운 삶의 시간 확인',
                  '추모관 상세 → 영원한 시간 섹션',
                  '추모관 상세 화면으로 바로 이동',
                  Icons.access_time,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '책장 보기',
                  '과거와 미래를 볼 수 있는 추억 탐색',
                  '추모관 상세 → 책장 버튼',
                  '책장 화면으로 바로 이동',
                  Icons.menu_book,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모금 전달',
                  '고인을 위한 추모금 전달 (사람 추모관만)',
                  '추모관 상세 → 추모금 전달 버튼',
                  '추모금 전달 모달 열기',
                  Icons.attach_money,
                  warmBrown,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 공감 및 위로 기능
            _buildCategorySection(
              '💬 공감 및 위로',
              '함께 나누는 감정과 위로의 공간',
              gentlePink,
              [
                _buildFeatureCard(
                  '감정 공유 게시판',
                  '슬픔, 기억, 위로의 감정을 나눔',
                  '홈 → 하단 네비게이션 [감정 공유]',
                  '감정 공유 게시판으로 바로 이동',
                  Icons.chat_bubble_outline,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '감정 글 작성',
                  '감정 나눔 글을 작성하고 태그를 지정합니다.',
                  '감정 공유 게시판 → 감정 글 작성 버튼',
                  '감정 글 작성 화면으로 바로 이동',
                  Icons.edit_note_outlined,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '후회 없는 편지',
                  '고인에 대한 후회를 나중에 다른 사람이 참고',
                  '홈 → 후회 없는 편지 섹션 또는 하단 네비게이션',
                  '후회 없는 편지 화면으로 바로 이동',
                  Icons.mail_outline,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '후회 없는 편지 작성',
                  '전하지 못한 마음을 편지로 작성하고 공개 범위를 설정합니다.',
                  '후회 없는 편지 → 편지 쓰기 버튼',
                  '후회 없는 편지 작성 화면으로 바로 이동',
                  Icons.create_outlined,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '기도 목록',
                  '등록된 기도 제목을 확인하고 함께 기도로 참여합니다.',
                  '홈 → 하단 네비게이션 [기도 요청]',
                  '기도 목록 화면으로 바로 이동',
                  Icons.favorite_outline,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '기도 요청 작성',
                  '기도 제목을 등록하고 응답을 기록합니다.',
                  '기도 목록 → 기도 요청 작성 버튼',
                  '기도 요청 작성 화면으로 바로 이동',
                  Icons.edit_note_outlined,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '댓글 작성',
                  '추모관에 위로 메시지 작성',
                  '추모관 상세 → 댓글 입력창',
                  '추모관 상세 화면으로 바로 이동',
                  Icons.comment_outlined,
                  Colors.pink[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // AI 및 특별 기능
            _buildCategorySection(
              '🤖 AI 기능',
              '인공지능으로 더 깊은 추모 경험',
              Colors.purple[300]!,
              [
                _buildFeatureCard(
                  'AI 기억 답장',
                  '고인과의 대화를 기반으로 AI 답장 생성',
                  '추모관 상세 → AI 기억 답장 탭',
                  'AI 기억 답장 화면으로 바로 이동',
                  Icons.smart_toy_outlined,
                  Colors.purple[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 유언장 및 매칭
            _buildCategorySection(
              '📜 특별 기능',
              '미래를 위한 준비와 위로',
              Colors.indigo[300]!,
              [
                _buildFeatureCard(
                  '유언장',
                  '미리 유언을 작성하고 다른 사람들의 유언 참고',
                  '마이페이지 → 유언장 버튼',
                  '유언장 화면으로 바로 이동',
                  Icons.article_outlined,
                  Colors.indigo[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '상호 위로 매칭',
                  '상실 경험을 가진 분들과 서로 위로',
                  '마이페이지 → 상호 위로 매칭 버튼',
                  '매칭 화면으로 바로 이동',
                  Icons.favorite_border,
                  Colors.indigo[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 검색 및 공유
            _buildCategorySection(
              '🔍 검색 및 공유',
              '추모관을 찾고 나눔',
              Colors.blue[300]!,
              [
                _buildFeatureCard(
                  '공개 추모관 검색',
                  '공개된 추모관 검색 및 조회',
                  '홈 → 하단 네비게이션 [검색]',
                  '검색 화면으로 바로 이동',
                  Icons.search,
                  Colors.blue[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모관 공유',
                  '링크, QR 코드, SNS 공유',
                  '추모관 상세 → 공유 버튼',
                  '공유 모달 열기',
                  Icons.share_outlined,
                  Colors.blue[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모관 통계',
                  '방문 수, 댓글 수, 추모금 통계',
                  '추모관 상세 → 통계 버튼',
                  '통계 화면으로 바로 이동',
                  Icons.bar_chart,
                  Colors.blue[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 감사 혜택
            _buildCategorySection(
              '🎁 감사 혜택',
              '감사와 혜택을 나눕니다',
              Colors.orange[300]!,
              [
                _buildFeatureCard(
                  '감사 혜택 보기',
                  '진행 중인 감사 혜택 확인 및 참여',
                  '홈 → 감사 혜택 배너 또는 마이페이지',
                  '감사 혜택 화면으로 바로 이동',
                  Icons.card_giftcard,
                  Colors.orange[700]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 설정 및 관리
            _buildCategorySection(
              '⚙️ 설정 및 관리',
              '계정, 알림, 데이터 관리',
              Colors.grey[600]!,
              [
                _buildFeatureCard(
                  '프로필 설정',
                  '프로필 사진, 이름, 비밀번호 변경',
                  '마이페이지 → 프로필 수정',
                  '프로필 수정 화면으로 바로 이동',
                  Icons.person_outline,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '알림 설정',
                  '기념일, 댓글, 기도 알림 설정',
                  '마이페이지 → 설정 → 알림 설정',
                  '알림 설정 화면으로 바로 이동',
                  Icons.notifications_outlined,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모금 관리',
                  '추모금 출금, 내역 확인',
                  '마이페이지 → 추모금 관리',
                  '추모금 내역 화면으로 바로 이동',
                  Icons.account_balance_wallet,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '프리미엄 구독',
                  '프리미엄 기능 이용',
                  '마이페이지 → 프리미엄 구독',
                  '프리미엄 구독 화면으로 바로 이동',
                  Icons.star_outline,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '추모관 백업',
                  'PDF, 사진/영상, 편지, 전체 데이터 백업',
                  '추모관 상세 → 백업 버튼',
                  '백업 화면으로 바로 이동',
                  Icons.backup,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
                _buildFeatureCard(
                  '전체 설정',
                  '계정, 알림, 프라이버시, 데이터 관리',
                  '마이페이지 → 설정',
                  '설정 화면으로 바로 이동',
                  Icons.settings_outlined,
                  Colors.grey[800]!,
                  onTap: () {},
                  onShowPath: () {},
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    String title,
    String description,
    Color accentColor,
    List<Widget> children,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accentColor.withOpacity(0.2),
                accentColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: accentColor.withOpacity(0.4), width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: warmBrown,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: warmBrown.withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildFeatureCard(
    String title,
    String description,
    String path,
    String actionText,
    IconData icon,
    Color iconColor, {
    required VoidCallback onTap,
    required VoidCallback onShowPath,
  }) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            warmBeige.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: iconColor.withOpacity(0.3), width: 1.5),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
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
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF5C5C5C),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: warmBeige,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: warmBrown.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.route, size: 14, color: warmBrown.withOpacity(0.7)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                path,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: warmBrown.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: warmBeige.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward, size: 16, color: warmBrown),
                          const SizedBox(width: 6),
                          Text(
                            actionText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: warmBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: warmBrown.withOpacity(0.2),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onShowPath,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 16, color: warmBrown.withOpacity(0.7)),
                          const SizedBox(width: 6),
                          Text(
                            '경로 안내',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: warmBrown.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
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
}
