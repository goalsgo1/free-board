import 'package:flutter/material.dart';

class PreviewMypageScreen extends StatelessWidget {
  const PreviewMypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
      ),
      backgroundColor: softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필
            Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
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
                      border: Border.all(color: warmBrown, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: warmBrown.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.person, size: 45, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '사용자 이름',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8B7355),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'user@example.com',
                    style: TextStyle(fontSize: 14, color: Color(0xFF5C5C5C)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // 내 활동
            _buildSection(
              '📊 내 활동',
              [
                _buildInfoRow('추모관', '3개'),
                _buildInfoRow('작성한 댓글', '12개'),
                _buildInfoRow('전달한 추모금', '₩50,000'),
              ],
            ),
            const SizedBox(height: 24),
            // 추모금 관리
            _buildSection(
              '💰 추모금 관리',
              [
                _buildInfoRow('수령 가능한 추모금', '₩25,000'),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [warmBrown, warmBrown.withOpacity(0.85)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: warmBrown.withOpacity(0.4),
                        blurRadius: 8,
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
                      '출금 요청',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('추모금 내역 보기'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 프리미엄
            _buildSection(
              '⭐ 프리미엄',
              [
                const Text('현재: 무료'),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [warmBrown, warmBrown.withOpacity(0.85)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: warmBrown.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      '프리미엄 구독하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('• 무제한 사진 업로드'),
                const Text('• 동영상 직접 업로드'),
                const Text('• 음성 편지 무제한'),
                const Text('• 광고 제거'),
                const Text('• 커스텀 배경'),
              ],
            ),
            const SizedBox(height: 24),
            // 디지털 헌화 아이템
            _buildSection(
              '🛍️ 디지털 헌화 아이템',
              [
                Row(
                  children: [
                    _buildItemIcon('꽃'),
                    const SizedBox(width: 12),
                    _buildItemIcon('배경'),
                    const SizedBox(width: 12),
                    _buildItemIcon('음악'),
                    const SizedBox(width: 12),
                    _buildItemIcon('애니메이션'),
                  ],
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text('아이템 상점 보기'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 설정
            _buildSection(
              '⚙️ 설정',
              [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 1),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.notifications, color: warmBrown),
                    title: const Text(
                      '알림 설정',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 1),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: warmBrown),
                    title: const Text(
                      '개인정보 수정',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 1),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.card_giftcard, color: warmBrown),
                    title: Row(
                      children: [
                        const Flexible(
                          child: Text(
                            '감사 혜택',
                            style: TextStyle(fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.card_giftcard, size: 16, color: Colors.orange),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 1),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.restore, color: warmBrown),
                    title: const Text(
                      '삭제된 추모관 복원',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.red.withOpacity(0.3), width: 1.5),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      '로그아웃',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFAFAFA),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8B7355),
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B7355),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemIcon(String label) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [warmBeige, warmBeige.withOpacity(0.8), warmBeige],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: warmBrown, width: 2),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: warmBrown,
          ),
        ),
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

