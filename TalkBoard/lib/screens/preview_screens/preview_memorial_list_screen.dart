import 'package:flutter/material.dart';

class PreviewMemorialListScreen extends StatelessWidget {
  const PreviewMemorialListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 추모관'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      backgroundColor: softCream,
      body: Column(
        children: [
          // 검색창
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: '🔍 고인 이름 검색...',
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
                fillColor: warmBeige,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          // 추모관 리스트
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMemorialCard(
                  '고인 이름',
                  '1950.01.01',
                  '2023.03.15',
                  '편지 요약...',
                  true,
                ),
                const SizedBox(height: 12),
                _buildMemorialCard(
                  '고인 이름',
                  '1945.05.20',
                  '2022.12.25',
                  '편지 요약...',
                  false,
                ),
              ],
            ),
          ),
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
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMemorialCard(
    String name,
    String birthday,
    String memorialDay,
    String summary,
    bool isPublic,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

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
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // 사진
            Container(
              width: 100,
              height: 100,
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
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: warmBrown, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(Icons.image, size: 45, color: Colors.grey[600]),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: warmBrown.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.photo_camera,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8B7355),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '생일: $birthday',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '기일: $memorialDay',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    summary,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isPublic
                                ? [Colors.green[400]!, Colors.green[600]!]
                                : [Colors.grey[400]!, Colors.grey[600]!],
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isPublic ? Colors.green[800]! : Colors.grey[800]!,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          isPublic ? '공개' : '비공개',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: warmBrown,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: warmBrown.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.delete, size: 18),
                          color: Colors.white,
                          onPressed: () {},
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

