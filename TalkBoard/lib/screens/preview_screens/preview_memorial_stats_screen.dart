import 'package:flutter/material.dart';

class PreviewMemorialStatsScreen extends StatelessWidget {
  const PreviewMemorialStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '추모관 통계',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 추모관 정보
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warmBeige,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: warmBrown.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: warmBrown.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: warmBrown,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      '[고인 이름] 추모관',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: warmBrown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 기간 선택
            Row(
              children: [
                _buildPeriodChip('전체', true),
                const SizedBox(width: 8),
                _buildPeriodChip('최근 1개월', false),
                const SizedBox(width: 8),
                _buildPeriodChip('최근 3개월', false),
                const SizedBox(width: 8),
                _buildPeriodChip('최근 6개월', false),
              ],
            ),
            const SizedBox(height: 24),
            // 방문 수
            _buildStatCard(
              '방문 수',
              '총 방문: 1,234명',
              '그래프 영역',
              warmBeige,
            ),
            const SizedBox(height: 16),
            // 댓글 수
            _buildStatCard(
              '댓글 수',
              '총 댓글: 89개',
              '그래프 영역',
              warmBeige,
            ),
            const SizedBox(height: 16),
            // 추모금 통계
            _buildStatCard(
              '추모금 통계',
              '총 수령액: ₩250,000\n총 전달 횟수: 12회',
              '그래프 영역',
              warmBeige,
            ),
            const SizedBox(height: 16),
            // 공감 수
            _buildStatCard(
              '공감 수',
              '총 공감: 156개\n좋아요: 98개\n댓글: 58개',
              '',
              warmBeige,
            ),
            const SizedBox(height: 16),
            // 공유 통계
            _buildStatCard(
              '공유 통계',
              '총 공유: 45회\n공유를 통해 방문: 23명',
              '',
              warmBeige,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(String label, bool isSelected) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {},
      selectedColor: warmBrown,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : warmBrown,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      ),
      backgroundColor: warmBeige,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: warmBrown.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String content,
    String graphPlaceholder,
    Color backgroundColor,
  ) {
    const Color warmBrown = Color(0xFF8B7355);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: warmBrown.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.1),
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: warmBrown,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5C5C5C),
            ),
          ),
          if (graphPlaceholder.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: warmBrown.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  graphPlaceholder,
                  style: TextStyle(
                    fontSize: 12,
                    color: warmBrown.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

