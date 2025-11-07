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
            
            // 필터 및 칩
            _buildSection(
              context,
              title: '5. 필터 및 칩 (Filter & Chips)',
              content: '정렬, 필터링, 카테고리 선택을 위한 칩 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('최신순'),
                      selected: true,
                      onSelected: (_) {},
                      selectedColor: warmBrown.withOpacity(0.2),
                      checkmarkColor: warmBrown,
                      labelStyle: TextStyle(
                        color: warmBrown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FilterChip(
                      label: const Text('공감순'),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: warmBrown.withOpacity(0.7),
                      ),
                    ),
                    FilterChip(
                      label: const Text('이름순'),
                      selected: false,
                      onSelected: (_) {},
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: warmBrown.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: const Text('가족에게'),
                      backgroundColor: gentlePink.withOpacity(0.3),
                      labelStyle: TextStyle(color: warmBrown),
                    ),
                    Chip(
                      label: const Text('친구에게'),
                      backgroundColor: softGreen.withOpacity(0.3),
                      labelStyle: TextStyle(color: warmBrown),
                    ),
                    Chip(
                      label: const Text('재산'),
                      backgroundColor: warmBeige,
                      labelStyle: TextStyle(color: warmBrown),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 탭 및 네비게이션
            _buildSection(
              context,
              title: '6. 탭 및 네비게이션 (Tabs & Navigation)',
              content: '탭 메뉴, 하단 네비게이션 바 등 화면 전환 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: warmBrown,
                        unselectedLabelColor: const Color(0xFF5C5C5C),
                        indicatorColor: warmBrown,
                        tabs: const [
                          Tab(text: '진행 중'),
                          Tab(text: '예정'),
                          Tab(text: '종료'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: warmBeige,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            '탭 컨텐츠 영역',
                            style: TextStyle(
                              color: Color(0xFF8B7355),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, '홈', true, warmBrown),
                      _buildNavItem(Icons.list, '목록', false, warmBrown),
                      _buildNavItem(Icons.search, '검색', false, warmBrown),
                      _buildNavItem(Icons.person, '마이페이지', false, warmBrown),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 토글 및 스위치
            _buildSection(
              context,
              title: '7. 토글 및 스위치 (Toggles & Switches)',
              content: '설정, 공개/비공개 전환 등 상태 변경을 위한 토글 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          '공개/비공개',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (_) {},
                        activeColor: warmBrown,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '기념일 알림',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8B7355),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '생일/기일 알림 수신',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: true,
                        onChanged: (_) {},
                        activeColor: warmBrown,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 배지 및 상태 표시
            _buildSection(
              context,
              title: '8. 배지 및 상태 표시 (Badges & Status)',
              content: '알림 카운트, 공개/비공개 상태, 진행률 등을 표시하는 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: warmBrown,
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      child: const Text(
                        '공개',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey, width: 1.5),
                      ),
                      child: const Text(
                        '비공개',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '프리미엄',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B7355),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.65,
                        backgroundColor: warmGray,
                        valueColor: AlwaysStoppedAnimation<Color>(warmBrown),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '65% 완료',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5C5C5C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 검색 바
            _buildSection(
              context,
              title: '9. 검색 바 (Search Bar)',
              content: '추모관 검색, 내용 검색을 위한 검색 입력 컴포넌트',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: warmBrown.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '추모관 이름으로 검색...',
                      prefixIcon: Icon(Icons.search, color: warmBrown),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list, color: warmBrown),
                        onPressed: () {},
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 구분선
            _buildSection(
              context,
              title: '10. 구분선 (Dividers)',
              content: '내용 구분, 섹션 분리를 위한 구분선 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            '항목 1',
                            style: TextStyle(color: Color(0xFF8B7355)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        color: warmBrown.withOpacity(0.3),
                        thickness: 1.5,
                        height: 24,
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            '항목 2',
                            style: TextStyle(color: Color(0xFF8B7355)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              warmBrown.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            '항목 3',
                            style: TextStyle(color: Color(0xFF8B7355)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 이미지 및 미디어
            _buildSection(
              context,
              title: '11. 이미지 및 미디어 (Images & Media)',
              content: '사진 갤러리, 이미지 미리보기, 동영상 썸네일 등 미디어 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: warmBeige,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: warmBrown.withOpacity(0.3)),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Color(0xFF8B7355),
                            size: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: warmBeige,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: warmBrown.withOpacity(0.3)),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Color(0xFF8B7355),
                            size: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: warmBeige,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: warmBrown.withOpacity(0.3)),
                          ),
                          child: Stack(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Color(0xFF8B7355),
                                  size: 40,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '+2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: warmBeige,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: warmBrown.withOpacity(0.3)),
                        ),
                        child: const Icon(
                          Icons.play_circle_outline,
                          color: Color(0xFF8B7355),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '동영상 제목',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8B7355),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '00:00 / 05:30',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 배너 및 알림
            _buildSection(
              context,
              title: '12. 배너 및 알림 (Banners & Alerts)',
              content: '중요 메시지, 안내사항, 공지사항을 표시하는 배너 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFF8E1),
                        const Color(0xFFFFF3C4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: warmBrown),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          '중요한 안내사항입니다',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        gentlePink,
                        gentlePink.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cake, color: warmBrown),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '오늘 기념일인 추모관',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8B7355),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '고인 이름님의 생일입니다',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Floating Action Button
            _buildSection(
              context,
              title: '13. Floating Action Button (FAB)',
              content: '주요 액션을 위한 플로팅 액션 버튼',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          warmBrown,
                          warmBrown.withOpacity(0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: warmBrown.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          gentlePink,
                          gentlePink.withOpacity(0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: warmBrown.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Color(0xFF8B7355),
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 통계 및 차트
            _buildSection(
              context,
              title: '14. 통계 및 차트 (Statistics & Charts)',
              content: '방문 수, 추모금, 댓글 수 등 통계 정보를 표시하는 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        warmBeige,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('방문 수', '1,234', Icons.visibility, warmBrown),
                          Container(
                            width: 1,
                            height: 40,
                            color: warmBrown.withOpacity(0.3),
                          ),
                          _buildStatItem('댓글', '56', Icons.comment, warmBrown),
                          Container(
                            width: 1,
                            height: 40,
                            color: warmBrown.withOpacity(0.3),
                          ),
                          _buildStatItem('공감', '89', Icons.favorite, warmBrown),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '일별 방문 통계',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBarChartItem(0.8, warmBrown),
                          _buildBarChartItem(0.6, warmBrown),
                          _buildBarChartItem(0.9, warmBrown),
                          _buildBarChartItem(0.4, warmBrown),
                          _buildBarChartItem(0.7, warmBrown),
                          _buildBarChartItem(0.5, warmBrown),
                          _buildBarChartItem(0.6, warmBrown),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 드롭다운 및 셀렉터
            _buildSection(
              context,
              title: '15-1. 드롭다운 및 셀렉터 (Dropdowns & Selectors)',
              content: '은행 선택, 카테고리 선택 등 선택 입력을 위한 드롭다운 컴포넌트',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 2),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: 'kb',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.account_balance, color: warmBrown),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'kb', child: Text('KB국민은행')),
                      DropdownMenuItem(value: 'shinhan', child: Text('신한은행')),
                      DropdownMenuItem(value: 'woori', child: Text('우리은행')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: warmBrown.withOpacity(0.3), width: 2),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: 'family',
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: '카테고리',
                      labelStyle: TextStyle(color: warmBrown),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'family', child: Text('가족에게')),
                      DropdownMenuItem(value: 'friend', child: Text('친구에게')),
                      DropdownMenuItem(value: 'estate', child: Text('재산')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 이미지 업로드 버튼
            _buildSection(
              context,
              title: '15-2. 업로드 버튼 (Upload Buttons)',
              content: '사진, 동영상, 음성 파일 업로드를 위한 버튼 컴포넌트',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [warmBrown.withOpacity(0.1), warmBrown.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_photo_alternate, color: warmBrown, size: 22),
                    label: Text(
                      '사진 업로드',
                      style: TextStyle(
                        color: warmBrown,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [warmBrown.withOpacity(0.1), warmBrown.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.video_library, color: warmBrown, size: 22),
                    label: Text(
                      '동영상 업로드',
                      style: TextStyle(
                        color: warmBrown,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gentlePink.withOpacity(0.3), gentlePink.withOpacity(0.1)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: warmBrown, width: 2),
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.mic, color: warmBrown, size: 22),
                    label: Text(
                      '음성 녹음',
                      style: TextStyle(
                        color: warmBrown,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 액션 버튼 그룹
            _buildSection(
              context,
              title: '15-3. 액션 버튼 그룹 (Action Button Groups)',
              content: '추모관 상세 화면의 공유, 통계, 백업 등 여러 액션 버튼들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildActionButton('공유', Icons.share, warmBrown),
                    _buildActionButton('통계', Icons.analytics, warmBrown),
                    _buildActionButton('백업', Icons.backup, warmBrown),
                    _buildActionButton('설정', Icons.settings, warmBrown),
                    _buildActionButton('삭제', Icons.delete, Colors.red),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconActionButton(Icons.favorite_border, '공감', Colors.red, warmBrown),
                      _buildIconActionButton(Icons.comment, '댓글', warmBrown, warmBrown),
                      _buildIconActionButton(Icons.local_florist, '기도', Colors.pink, warmBrown),
                      _buildIconActionButton(Icons.share, '공유', warmBrown, warmBrown),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 빈 상태 및 로딩
            _buildSection(
              context,
              title: '15-4. 빈 상태 및 로딩 (Empty States & Loading)',
              content: '데이터가 없을 때, 로딩 중일 때 표시하는 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: warmBrown.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '아직 작성된 추모관이 없습니다',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8B7355),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '첫 추모관을 만들어보세요',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(warmBrown),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '로딩 중...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5C5C5C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 리스트 아이템
            _buildSection(
              context,
              title: '15. 리스트 아이템 (List Items)',
              content: '설정, 내역, 메뉴 등을 표시하는 리스트 아이템 컴포넌트들',
              warmBeige: warmBeige,
              warmBrown: warmBrown,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: warmBrown.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings, color: warmBrown),
                        title: const Text(
                          '설정',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                      ),
                      Divider(height: 1, color: warmBrown.withOpacity(0.2)),
                      ListTile(
                        leading: Icon(Icons.notifications, color: warmBrown),
                        title: const Text(
                          '알림 설정',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
                      ),
                      Divider(height: 1, color: warmBrown.withOpacity(0.2)),
                      ListTile(
                        leading: Icon(Icons.history, color: warmBrown),
                        title: const Text(
                          '추모금 내역',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: warmBrown),
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
              title: '16. 레이아웃 (Layouts)',
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
              title: '17. 유틸리티 (Utilities)',
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
              title: '18. 상수 (Constants)',
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

  Widget _buildNavItem(IconData icon, String label, bool isSelected, Color warmBrown) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? warmBrown : warmBrown.withOpacity(0.5),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? warmBrown : warmBrown.withOpacity(0.5),
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color warmBrown) {
    return Column(
      children: [
        Icon(icon, color: warmBrown, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: warmBrown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: warmBrown.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChartItem(double height, Color warmBrown) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 60 * height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                warmBrown,
                warmBrown.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${(height * 10).toInt()}',
          style: TextStyle(
            fontSize: 10,
            color: warmBrown.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconActionButton(IconData icon, String label, Color iconColor, Color warmBrown) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: iconColor.withOpacity(0.3), width: 1.5),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: warmBrown,
          ),
        ),
      ],
    );
  }
}

