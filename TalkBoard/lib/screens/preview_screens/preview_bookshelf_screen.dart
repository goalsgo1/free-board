import 'package:flutter/material.dart';

class PreviewBookshelfScreen extends StatelessWidget {
  const PreviewBookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color bookShelfColor = Color(0xFFE8DCC6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('추억의 책장'),
        backgroundColor: warmBrown,
        foregroundColor: Colors.white,
      ),
      backgroundColor: softCream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 책장
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    bookShelfColor,
                    bookShelfColor.withOpacity(0.9),
                    const Color(0xFFD4C4A8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: warmBrown, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 선반
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6B5B3D),
                          warmBrown,
                          const Color(0xFF6B5B3D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 책들
                  Row(
                    children: [
                      Expanded(child: _buildBook('2023', '봄', warmBeige)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildBook('2022', '여름', const Color(0xFFE8F5E9))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildBook('2021', '가을', warmBeige)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildBook('2020', '겨울', const Color(0xFFFFE5E5))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 선반
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6B5B3D),
                          warmBrown,
                          const Color(0xFF6B5B3D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 책들
                  Row(
                    children: [
                      Expanded(child: _buildBook('2019', '봄', warmBeige)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildBook('2018', '여름', const Color(0xFFE8F5E9))),
                      const SizedBox(width: 8),
                      Expanded(child: _buildBook('2017', '가을', warmBeige)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 선반
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF6B5B3D),
                          warmBrown,
                          const Color(0xFF6B5B3D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 시간 축
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back, size: 16, color: warmBrown),
                              const SizedBox(width: 4),
                              const Text(
                                '과거',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '추억을 되돌아보는 시간',
                            style: TextStyle(fontSize: 11, color: Color(0xFF5C5C5C)),
                          ),
                        ],
                      ),
                      Container(
                        width: 60,
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              warmBrown.withOpacity(0.3),
                              warmBrown,
                              warmBrown.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              const Text(
                                '미래',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16, color: warmBrown),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '영원한 시간이 흐르는 곳',
                            style: TextStyle(fontSize: 11, color: Color(0xFF5C5C5C)),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 영원한 시간
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: warmBrown.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, color: warmBrown, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        '영원한 시간',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: warmBeige,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '새로운 삶의 시간: 2년 3개월 15일 8시간 23분',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B7355),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '영원한 시간이 흐르고 있습니다',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5C5C5C),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBook(String year, String season, Color color) {
    const Color warmBrown = Color(0xFF8B7355);
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withOpacity(0.8),
              color.withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: warmBrown, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: warmBrown.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 책 등 부분 (입체감)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      warmBrown.withOpacity(0.6),
                      warmBrown.withOpacity(0.8),
                      warmBrown.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            // 책 제목
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year,
                    style: TextStyle(
                      color: warmBrown,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    season,
                    style: TextStyle(
                      color: warmBrown.withOpacity(0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

