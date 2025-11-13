import 'package:flutter/material.dart';

class PreviewWillScreen extends StatelessWidget {
  const PreviewWillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '유언장',
          style: TextStyle(
            color: warmBrown,
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        backgroundColor: warmBeige,
        elevation: 0,
        iconTheme: const IconThemeData(color: warmBrown),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 설명 텍스트
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                '미리 유언을 작성하고,\n다른 사람들의 유언을 참고하여\n후회 없는 인생을 준비하세요',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5C5C5C),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // 필터
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('전체', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('가족에게', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('친구에게', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('재산', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('마지막 인사', false),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildFilterChip('최신순', true),
                const SizedBox(width: 8),
                _buildFilterChip('공감순', false),
              ],
            ),
            const SizedBox(height: 24),

            // 템플릿 카드
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [warmBeige, Colors.white],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: warmBrown.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: warmBrown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: warmBrown,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '템플릿으로 시작하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: warmBrown,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '카테고리별 유언 템플릿 제공',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5C5C5C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: warmBrown,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 유언 카드들
            _buildWillCard(
              '가족에게',
              '가족들에게: 항상 사랑해. 내가 없는 날에도 서로 아껴주고 행복하게 살아줘.',
              '익명',
              '3일 전',
              89,
              12,
            ),
            const SizedBox(height: 12),
            _buildWillCard(
              '재산 및 유산',
              '재산 관련: 내 재산은 모두 자녀들에게 균등하게 나누어 주세요. 아내에게는...',
              '위로의 마음',
              '5일 전',
              45,
              8,
            ),
            const SizedBox(height: 12),
            _buildWillCard(
              '마지막 인사',
              '모든 사람들에게: 인생은 아름다웠습니다. 감사했습니다. 여러분 모두 행복하세요.',
              '따뜻한 마음',
              '1주일 전',
              123,
              25,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Colors.black, width: 1.4),
        ),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? warmBrown : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? warmBrown : warmBrown.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: warmBrown.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isSelected ? Colors.white : warmBrown,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildWillCard(
    String category,
    String content,
    String author,
    String time,
    int likeCount,
    int commentCount,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: warmBrown.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: warmBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: warmBrown.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.article,
                      size: 12,
                      color: warmBrown,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 10,
                          color: warmBrown,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF2C2C2C),
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Flexible(
                child: Text(
                  author,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF5C5C5C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Text(
                ' | ',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF5C5C5C),
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF5C5C5C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 16,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$likeCount',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 16,
                    color: Color(0xFF5C5C5C),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$commentCount',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '전체 보기',
                  style: TextStyle(
                    fontSize: 12,
                    color: warmBrown,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


