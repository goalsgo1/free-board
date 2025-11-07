import 'package:flutter/material.dart';

class PreviewPrayerScreen extends StatelessWidget {
  const PreviewPrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color gentlePink = Color(0xFFFFE5E5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('기도 요청'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPrayerCard(
              '제목',
              '내용...',
              '위로의 마음',
              '2시간 전',
              15,
              true,
            ),
            const SizedBox(height: 16),
            _buildPrayerCard(
              '제목',
              '내용...',
              '따뜻한 마음',
              '1일 전',
              8,
              false,
            ),
            const SizedBox(height: 16),
            // 댓글 입력창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글 입력...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: warmBrown, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: warmBrown, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: warmBrown, width: 3),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
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
                  child: IconButton(
                    icon: const Icon(Icons.send, size: 22),
                    color: Colors.white,
                    onPressed: () {},
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

  Widget _buildPrayerCard(
    String title,
    String content,
    String author,
    String time,
    int count,
    bool isCompleted,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color gentlePink = Color(0xFFFFE5E5);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
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
      child: Container(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 14, color: Color(0xFF5C5C5C)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  child: Text(
                    '작성자: $author',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    '작성 시간: $time',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.favorite, color: gentlePink, size: 20),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$count명이 함께 기도하고 있습니다',
                    style: const TextStyle(fontSize: 14, color: Color(0xFF5C5C5C)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gentlePink, gentlePink.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: warmBrown, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: gentlePink.withOpacity(0.4),
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
                  foregroundColor: warmBrown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  '함께 기도하기',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            if (isCompleted) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (_) {}),
                  const Text('기도 완료'),
                ],
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              '💬 댓글 (3)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8B7355),
              ),
            ),
            const SizedBox(height: 8),
            _buildCommentCard('작성자', '방금 전', '함께 기도하겠습니다...'),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(String author, String time, String content) {
    const Color warmBrown = Color(0xFF8B7355);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF5F1E8),
            const Color(0xFFF0EBE0),
            const Color(0xFFF5F1E8),
          ],
        ),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: warmBrown, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: warmBrown.withOpacity(0.15),
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
              Flexible(
                child: Text(
                  author,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8B7355),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
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

