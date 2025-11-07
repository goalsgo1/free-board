import 'package:flutter/material.dart';

class PreviewEmotionBoardScreen extends StatelessWidget {
  const PreviewEmotionBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('감정 공유'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('공감', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('최신', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('추천', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: softCream,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPostCard('제목', '내용 요약...', '위로의 마음', '3시간 전', 12, 5),
          const SizedBox(height: 12),
          _buildPostCard('제목', '내용 요약...', '따뜻한 마음', '1일 전', 8, 3),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [warmBrown, warmBrown.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: warmBrown.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.edit, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildPostCard(
    String title,
    String content,
    String author,
    String time,
    int likes,
    int comments,
  ) {
    const Color warmBrown = Color(0xFF8B7355);

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
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 20),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$likes',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.chat_bubble_outline, color: warmBrown, size: 20),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$comments',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
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

