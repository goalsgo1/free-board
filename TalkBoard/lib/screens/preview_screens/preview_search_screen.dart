import 'package:flutter/material.dart';

class PreviewSearchScreen extends StatelessWidget {
  const PreviewSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('추모관 검색'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
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
                hintText: '🔍 고인 이름 또는 생성자 검색...',
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
                fillColor: const Color(0xFFF5F1E8),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          // 필터
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterChip('최신순', true),
                const SizedBox(width: 8),
                _buildFilterChip('공감순', false),
                const SizedBox(width: 8),
                _buildFilterChip('이름순', false),
              ],
            ),
          ),
          // 검색 결과
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSearchResultCard('고인 이름', '위로의 마음', '2024.01.15', 37),
                const SizedBox(height: 12),
                _buildSearchResultCard('고인 이름', '따뜻한 마음', '2024.01.10', 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    const Color warmBrown = Color(0xFF8B7355);
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [warmBrown, warmBrown.withOpacity(0.8)],
              )
            : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? warmBrown : warmBrown.withOpacity(0.5),
          width: isSelected ? 2 : 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: warmBrown.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : warmBrown,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (_) {},
        selectedColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        checkmarkColor: Colors.white,
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildSearchResultCard(
    String name,
    String creator,
    String date,
    int visits,
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
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '생성자: $creator',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                  ),
                  Text(
                    '생성일: $date',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF5C5C5C)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '방문 수: $visits명',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
          ],
        ),
      ),
    );
  }
}

