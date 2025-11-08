import 'package:flutter/material.dart';

class PreviewMatchingScreen extends StatelessWidget {
  const PreviewMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '상호 위로 매칭',
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
                '유사한 상실 경험을 가진 분들과\n서로의 빈자리를 채워주며\n위로를 나눠보세요',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF5C5C5C),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // 안전 안내
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.amber.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '안전 안내: 개인정보 보호 및 익명성 보장, 부적절한 행위 신고 기능',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF5C5C5C),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 탭
            Row(
              children: [
                Expanded(
                  child: _buildTab('구인 목록', true),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTab('구직 목록', false),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTab('내 매칭', false),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 프로필 카드들
            _buildProfileCard(
              '딸을 잃은 엄마',
              '30-40대',
              '딸을 찾습니다',
              '딸의 빈자리가 너무 크네요. 엄마를 잃으신 딸과 서로 위로하며 지내고 싶습니다.',
              true,
            ),
            const SizedBox(height: 12),
            _buildProfileCard(
              '엄마를 잃은 딸',
              '20-30대',
              '엄마 같은 분을 찾습니다',
              '엄마의 사랑을 그리워하며, 엄마를 잃으신 어머니와 의미 있는 관계를 나누고 싶습니다.',
              true,
            ),
            const SizedBox(height: 12),
            _buildProfileCard(
              '아들을 잃은 아빠',
              '40-50대',
              '아들을 찾습니다',
              '아들의 빈자리를 채워줄 수 있는 관계를 찾고 있습니다.',
              false,
            ),
            const SizedBox(height: 24),

            // 프로필 등록 버튼
            Container(
              width: double.infinity,
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    color: warmBrown,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '프로필 등록하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
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

  Widget _buildTab(String label, bool isSelected) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? warmBrown : Colors.white,
        borderRadius: BorderRadius.circular(12),
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
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProfileCard(
    String name,
    String ageRange,
    String seeking,
    String introduction,
    bool isVerified,
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
              // 프로필 사진
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: warmBeige,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: warmBrown.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 30,
                  color: warmBrown,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C2C2C),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.verified,
                              size: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ageRange,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5C5C5C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: warmBrown.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: warmBrown.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  size: 16,
                  color: warmBrown,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    seeking,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: warmBrown,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            introduction,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF5C5C5C),
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: warmBrown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: const Text(
                '매칭 신청하기',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


