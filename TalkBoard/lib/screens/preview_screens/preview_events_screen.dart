import 'package:flutter/material.dart';

class PreviewEventsScreen extends StatefulWidget {
  const PreviewEventsScreen({super.key});

  @override
  State<PreviewEventsScreen> createState() => _PreviewEventsScreenState();
}

class _PreviewEventsScreenState extends State<PreviewEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Scaffold(
      backgroundColor: softCream,
      appBar: AppBar(
        title: const Text(
          '감사 혜택',
          style: TextStyle(
            color: warmBrown,
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        backgroundColor: warmBeige,
        elevation: 0,
        iconTheme: const IconThemeData(color: warmBrown),
        bottom: TabBar(
          controller: _tabController,
          labelColor: warmBrown,
          unselectedLabelColor: const Color(0xFF5C5C5C),
          indicatorColor: warmBrown,
          tabs: const [
            Tab(text: '진행 중'),
            Tab(text: '예정'),
            Tab(text: '종료'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveEventsTab(),
          _buildScheduledEventsTab(),
          _buildEndedEventsTab(),
        ],
      ),
    );
  }

  Widget _buildActiveEventsTab() {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💝 진행 중인 감사 혜택',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 16),
          _buildEventCard(
            '🎁 초기 가입자 감사 혜택',
            '프리미엄 3개월 무료!',
            '~2024.03.31',
            '847명 / 1000명 참여',
            84.7,
            Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildEventCard(
            '⭐ 공감 많이 받은 사용자 감사',
            '공감 100개 이상 시 프리미엄 1개월 무료!',
            '~2024.03.31',
            '조건 충족 시 자동 지급',
            null,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildEventCard(
            '🎊 첫 추모관 생성 감사',
            '첫 추모관 생성 시 프리미엄 1개월 무료!',
            '상시 진행',
            '조건 충족 시 자동 지급',
            null,
            Colors.green,
          ),
          const SizedBox(height: 24),
          const Text(
            '📦 내 혜택',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 16),
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
                  color: Colors.black.withOpacity(0.08),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '프리미엄 무료 이용권: 3개월',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '사용 가능한 쿠폰: 2개',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: warmBrown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledEventsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '⏰ 예정된 감사 혜택',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 16),
          _buildEventCard(
            '🌸 봄 시즌 감사 혜택',
            '봄을 맞아 특별 감사 혜택!',
            '2024.04.01 시작 예정',
            '알림 설정 가능',
            null,
            Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildEndedEventsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📜 종료된 감사 혜택',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2C2C2C),
            ),
          ),
          const SizedBox(height: 16),
          _buildEventCard(
            '🎄 겨울 시즌 감사 혜택',
            '겨울 한정 감사 혜택',
            '2024.02.29 종료',
            '종료됨',
            null,
            Colors.grey,
            isEnded: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    String title,
    String description,
    String date,
    String status,
    double? progress,
    Color bannerColor, {
    bool isEnded = false,
  }) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: bannerColor.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.card_giftcard,
                size: 48,
                color: bannerColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isEnded ? const Color(0xFF9E9E9E) : const Color(0xFF2C2C2C),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isEnded ? const Color(0xFF9E9E9E) : const Color(0xFF5C5C5C),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: isEnded ? const Color(0xFF9E9E9E) : warmBrown,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: 12,
                          color: isEnded ? const Color(0xFF9E9E9E) : const Color(0xFF5C5C5C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (progress != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              status,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5C5C5C),
                              ),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress / 100,
                                backgroundColor: warmBeige,
                                valueColor: AlwaysStoppedAnimation<Color>(warmBrown),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 8),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: isEnded ? const Color(0xFF9E9E9E) : warmBrown,
                    ),
                  ),
                ],
                if (!isEnded) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: warmBrown, width: 1),
                      ),
                      child: const Text(
                        '자세히 보기',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: warmBrown,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

