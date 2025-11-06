import 'package:flutter/material.dart';

class ComponentsGuideScreen extends StatelessWidget {
  const ComponentsGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 추모관 앱 색상 팔레트
    const Color warmBeige = Color(0xFFF5F1E8);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBrown = Color(0xFF8B7355);
    const Color gentlePink = Color(0xFFFFE5E5);
    const Color softGreen = Color(0xFFE8F5E9);
    const Color warmGray = Color(0xFFE0E0E0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '공통 컴포넌트 가이드',
          style: TextStyle(fontWeight: FontWeight.w300),
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
            // 개요
            _buildSection(
              context,
              title: '🕊️ 개요',
              content: '기억의 정원 앱 전반에서 재사용할 수 있는 공통 컴포넌트, 레이아웃, 유틸리티를 정의합니다.\n모든 컴포넌트는 따뜻하고 위로하는 분위기를 담고 있습니다.',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
            ),
            const SizedBox(height: 24),
            
            // 버튼
            _buildSection(
              context,
              title: '1. 버튼 (Buttons)',
              content: '추모관 생성, 기도 참여, 추모금 전달 등 주요 액션을 위한 버튼들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                _buildButtonExample(
                  context,
                  'PrimaryButton',
                  '추모관 만들기',
                  warmBrown,
                  () {},
                ),
                const SizedBox(height: 12),
                _buildButtonExample(
                  context,
                  'SecondaryButton',
                  '취소',
                  Colors.transparent,
                  () {},
                  isOutlined: true,
                  borderColor: warmBrown,
                  textColor: warmBrown,
                ),
                const SizedBox(height: 12),
                _buildButtonExample(
                  context,
                  'PrayerButton',
                  '함께 기도하기',
                  gentlePink,
                  () {},
                  textColor: warmBrown,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                      color: const Color(0xFFFF6B6B),
                      iconSize: 28,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '좋아요',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8B7355)),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.local_florist),
                      onPressed: () {},
                      color: warmBrown,
                      iconSize: 28,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '기도',
                      style: TextStyle(fontSize: 14, color: Color(0xFF8B7355)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 입력 폼
            _buildSection(
              context,
              title: '2. 입력 폼 (Input Forms)',
              content: '고인 이름, 편지 작성, 기념일 선택, 사진 업로드 등 추모관 생성에 필요한 입력 필드들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: '고인 이름',
                    hintText: '고인의 이름을 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person_outline, color: warmBrown),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: '편지',
                    hintText: '고인에게 전하고 싶은 마음을 적어주세요...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  maxLines: 4,
                  enabled: false,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: '기념일',
                    hintText: '생일 또는 기일을 선택하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: warmBrown, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.calendar_today_outlined, color: warmBrown),
                  ),
                  enabled: false,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 카드
            _buildSection(
              context,
              title: '3. 카드 (Cards)',
              content: '추모관, 댓글, 기도 요청, 감정 공유를 위한 카드 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [warmBeige, softCream],
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: warmBrown.withOpacity(0.2),
                        child: Icon(Icons.local_florist, color: warmBrown),
                      ),
                      title: const Text(
                        '추모관 카드',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                      subtitle: const Text(
                        '고인을 기억하는 따뜻한 공간',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: gentlePink,
                              child: const Icon(Icons.person, size: 18, color: Color(0xFF8B7355)),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '위로의 마음',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF8B7355),
                                    ),
                                  ),
                                  Text(
                                    '방금 전',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '고인을 기억하며 따뜻한 위로를 전합니다...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5C5C5C),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 책장 디자인
            _buildSection(
              context,
              title: '4. 책장 디자인 (Bookshelf Design)',
              content: '과거와 미래를 볼 수 있는 책장 분위기의 추억 탐색 인터페이스',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                // 책장 예시
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DCC6), // 책장 색상
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 책장 선반
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: warmBrown.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 책들 (추억 버튼)
                      Row(
                        children: [
                          Expanded(
                            child: _buildMemoryBook(
                              '2023년\n봄',
                              warmBrown,
                              gentlePink,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildMemoryBook(
                              '2022년\n여름',
                              warmBrown,
                              softGreen,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildMemoryBook(
                              '2021년\n가을',
                              warmBrown,
                              warmBeige,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 책장 선반
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: warmBrown.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 시간 축 표시
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
                                      color: Color(0xFF8B7355),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '추억을 되돌아보는 시간',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF5C5C5C),
                                ),
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
                                      color: Color(0xFF8B7355),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.arrow_forward, size: 16, color: warmBrown),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '영원한 시간이 흐르는 곳',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF5C5C5C),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // 영원한 시간 시계
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
            const SizedBox(height: 24),
            
            // 레이아웃
            _buildSection(
              context,
              title: '5. 레이아웃 (Layouts)',
              content: '추모관 생성 단계, 로딩 상태, 빈 상태 등을 위한 레이아웃 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: warmBeige,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: warmBrown, size: 24),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '추모관 생성 단계 안내',
                          style: TextStyle(
                            color: Color(0xFF8B7355),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStep(1, true, warmBrown),
                          Container(
                            width: 40,
                            height: 2,
                            color: warmBrown.withOpacity(0.3),
                          ),
                          _buildStep(2, true, warmBrown),
                          Container(
                            width: 40,
                            height: 2,
                            color: warmBrown.withOpacity(0.3),
                          ),
                          _buildStep(3, false, warmBrown),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '추모관 생성 단계',
                        style: TextStyle(
                          color: Color(0xFF8B7355),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 유틸리티
            _buildSection(
              context,
              title: '6. 유틸리티 (Utilities)',
              content: '추모관 데이터 처리, 이미지 업로드, 날짜 포맷팅 등에 사용되는 유틸리티 함수들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                _buildUtilityItem('Validators', '고인 이름, 편지 내용 유효성 검사', warmBrown),
                _buildUtilityItem('Formatters', '기념일, 날짜 포맷팅', warmBrown),
                _buildUtilityItem('ImageUtils', '추모 사진 리사이징 및 압축', warmBrown),
                _buildUtilityItem('StorageUtils', '사진, 영상, 음성 파일 저장', warmBrown),
                _buildUtilityItem('NavigationUtils', '화면 이동 및 알림 표시', warmBrown),
                _buildUtilityItem('PermissionUtils', '카메라, 저장소 권한 처리', warmBrown),
              ],
            ),
            const SizedBox(height: 24),
            
            // 상수
            _buildSection(
              context,
              title: '7. 상수 (Constants)',
              content: '따뜻한 톤의 색상, 부드러운 크기, 감성적인 텍스트 스타일 등',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildColorBox(warmBrown, 'Primary', Colors.white),
                    _buildColorBox(gentlePink, 'Prayer', warmBrown),
                    _buildColorBox(softGreen, 'Comfort', warmBrown),
                    _buildColorBox(warmBeige, 'Background', warmBrown),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: warmBeige,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildConstantItem('AppColors', '따뜻한 베이지, 크림, 브라운 톤', warmBrown),
                      const SizedBox(height: 8),
                      _buildConstantItem('AppSizes', '부드러운 둥근 모서리, 여유로운 여백', warmBrown),
                      const SizedBox(height: 8),
                      _buildConstantItem('AppTextStyles', '읽기 쉬운 명조체, 감성적인 서체', warmBrown),
                      const SizedBox(height: 8),
                      _buildConstantItem('AppLimits', '사진 최대 5장, 프리미엄 무제한', warmBrown),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 문서 링크
            _buildSection(
              context,
              title: '📚 상세 문서',
              content: '더 자세한 내용은 다음 문서를 참고하세요:',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.description, color: warmBrown),
                    title: const Text(
                      'docs/planning/COMPONENTS.md',
                      style: TextStyle(
                        color: Color(0xFF8B7355),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: const Text(
                      '공통 컴포넌트 상세 가이드',
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                    onTap: () {
                      // 문서 링크 (향후 구현)
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget>? children,
    Color? warmBeige,
    Color? warmBrown,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w300,
            color: warmBrown ?? const Color(0xFF8B7355),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF5C5C5C),
            height: 1.6,
          ),
        ),
        if (children != null) ...[
          const SizedBox(height: 20),
          ...children,
        ],
      ],
    );
  }

  Widget _buildButtonExample(
    BuildContext context,
    String label,
    String text,
    Color backgroundColor,
    VoidCallback onPressed, {
    bool isOutlined = false,
    Color? borderColor,
    Color? textColor,
  }) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? const Color(0xFF8B7355),
          side: BorderSide(color: borderColor ?? const Color(0xFF8B7355), width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Text(text),
    );
  }

  Widget _buildUtilityItem(String name, String description, Color warmBrown) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.code, size: 18, color: warmBrown),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF5C5C5C),
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8B7355),
                    ),
                  ),
                  TextSpan(text: ' - $description'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConstantItem(String name, String description, Color warmBrown) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 6, color: warmBrown),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8B7355),
                  ),
                ),
                TextSpan(text: ': $description'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorBox(Color color, String label, Color textColor) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: textColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, bool isCompleted, Color warmBrown) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? warmBrown : const Color(0xFFE0E0E0),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: warmBrown.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isCompleted ? Colors.white : const Color(0xFF9E9E9E),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryBook(String title, Color warmBrown, Color bookColor) {
    return GestureDetector(
      onTap: () {
        // 추억 상세 보기
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: bookColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: warmBrown.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: warmBrown,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

