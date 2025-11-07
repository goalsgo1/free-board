import 'package:flutter/material.dart';
import 'dart:math' as math;

class DatabaseDiagramScreen extends StatefulWidget {
  const DatabaseDiagramScreen({super.key});

  @override
  State<DatabaseDiagramScreen> createState() => _DatabaseDiagramScreenState();
}

class _DatabaseDiagramScreenState extends State<DatabaseDiagramScreen> {
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  Offset _panStart = Offset.zero;
  bool _isPanning = false;
  String? _selectedCategory;

  // 카테고리별 테이블 그룹화
  final Map<String, List<String>> _categories = {
    '전체': [],
    '사용자 및 인증': ['users', 'subscriptions', 'notifications'],
    '추모관 핵심': ['memorials', 'comments', 'prayers', 'prayerParticipants', 'visits', 'shares', 'backups', 'memorialStats'],
    '추모금 및 결제': ['donations', 'items', 'userItems'],
    '감정 공유': ['emotions', 'emotionLikes', 'emotionComments'],
    '후회 없는 편지': ['regretLetters', 'regretLetterLikes', 'regretLetterComments'],
    'AI 기능': ['aiMemories', 'aiReplies'],
    '유언장': ['wills', 'willLikes', 'willComments'],
    '상호 위로 매칭': ['matchingProfiles', 'matchingRequests', 'matchings', 'matchingChats', 'matchingReports'],
    '감사 혜택': ['gratitudeBenefits', 'benefitParticipants', 'userRewards'],
  };

  @override
  void initState() {
    super.initState();
    _selectedCategory = '전체';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 다이어그램'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: '축소',
            onPressed: () {
              setState(() {
                _scale = math.max(0.5, _scale - 0.1);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: '확대',
            onPressed: () {
              setState(() {
                _scale = math.min(2.0, _scale + 0.1);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '리셋',
            onPressed: () {
              setState(() {
                _scale = 1.0;
                _offset = Offset.zero;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 카테고리 필터
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.keys.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      selectedColor: Colors.blue[100],
                      checkmarkColor: Colors.blue,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // 다이어그램 영역
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 다이어그램 크기를 화면에 맞게 조정
                final diagramWidth = math.max(constraints.maxWidth * 1.5, 2800.0);
                final diagramHeight = math.max(constraints.maxHeight * 1.5, 2000.0);
                
                return InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 4.0,
                  boundaryMargin: const EdgeInsets.all(double.infinity),
                  child: Container(
                    width: diagramWidth,
                    height: diagramHeight,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: CustomPaint(
                      size: Size(diagramWidth, diagramHeight),
                      painter: DatabaseDiagramPainter(
                        selectedCategory: _selectedCategory,
                        categoryTables: _categories[_selectedCategory] ?? [],
                        diagramWidth: diagramWidth,
                        diagramHeight: diagramHeight,
                      ),
                      child: SizedBox(
                        width: diagramWidth,
                        height: diagramHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 범례
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: _buildLegend(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildLegendItem('PK', 'Primary Key (기본키)', Colors.blue),
        _buildLegendItem('FK', 'Foreign Key (외래키)', Colors.green),
        _buildLegendItem('1:N', 'One-to-Many (일대다)', Colors.orange),
        _buildLegendItem('N:M', 'Many-to-Many (다대다)', Colors.purple),
        _buildColorLegend('사용자', Colors.blue),
        _buildColorLegend('추모관', Colors.green),
        _buildColorLegend('감정', Colors.pink),
        _buildColorLegend('후회 편지', Colors.deepPurple),
        _buildColorLegend('AI', Colors.indigo),
        _buildColorLegend('유언장', Colors.blueGrey),
        _buildColorLegend('매칭', Colors.teal),
        _buildColorLegend('혜택', Colors.amber),
      ],
    );
  }

  Widget _buildLegendItem(String symbol, String description, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildColorLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class DatabaseDiagramPainter extends CustomPainter {
  final String? selectedCategory;
  final List<String> categoryTables;
  final double diagramWidth;
  final double diagramHeight;

  DatabaseDiagramPainter({
    this.selectedCategory,
    this.categoryTables = const [],
    this.diagramWidth = 2800.0,
    this.diagramHeight = 2000.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final fieldTextStyle = TextStyle(
      fontSize: 11,
      color: Colors.black87,
    );

    // 계층적 레이아웃: users를 중심으로 배치
    // 그룹 1: 사용자 및 인증 (좌측 상단)
    // 그룹 2: 추모관 핵심 (중앙)
    // 그룹 3: 추모금 및 결제 (우측 상단)
    // 그룹 4: 감정 공유 (좌측 중앙)
    // 그룹 5: 후회 없는 편지 (중앙 하단)
    // 그룹 6: AI 기능 (우측 중앙)
    // 그룹 7: 유언장 (좌측 하단)
    // 그룹 8: 상호 위로 매칭 (우측 하단)
    // 그룹 9: 감사 혜택 (하단 중앙)

    final tables = _buildTables(size);

    // 필터링 적용
    final filteredTables = selectedCategory == '전체'
        ? tables
        : tables.where((t) => categoryTables.contains(t.name)).toList();

    // 관계선 정의
    final relationships = _buildRelationships(filteredTables);

    // 배경 그리드
    _drawGrid(canvas, size, paint);

    // 그룹 배경 (기능별로 구분)
    _drawGroupBackgrounds(canvas, filteredTables, paint);

    // 관계선 그리기 (테이블보다 먼저 그려서 테이블 뒤에 있게)
    for (final rel in relationships) {
      final fromTable = filteredTables.firstWhere(
        (t) => t.name == rel.from,
        orElse: () => _TableInfo('', 0, 0, Colors.grey, []),
      );
      final toTable = filteredTables.firstWhere(
        (t) => t.name == rel.to,
        orElse: () => _TableInfo('', 0, 0, Colors.grey, []),
      );

      if (fromTable.name.isEmpty || toTable.name.isEmpty) continue;
      _drawRelationship(canvas, fromTable, toTable, rel, paint);
    }

    // 테이블 그리기
    for (final table in filteredTables) {
      _drawTable(canvas, table, paint, textStyle, fieldTextStyle);
    }

    // 그룹 레이블
    _drawGroupLabels(canvas, filteredTables, paint, textStyle);
  }

  List<_TableInfo> _buildTables(Size size) {
    const tableWidth = 220.0;
    const tableSpacing = 50.0;
    
    // 화면 크기에 비례하여 배치 (중앙 정렬)
    final centerX = diagramWidth / 2;
    final centerY = diagramHeight / 2;
    
    // 그룹 1: 사용자 및 인증 (좌측 상단)
    final group1Y = 100.0;
    final group1X = math.max(100.0, centerX - 800.0);

    // 그룹 2: 추모관 핵심 (중앙 상단)
    final group2Y = 100.0;
    final group2X = centerX - 300.0;

    // 그룹 3: 추모금 및 결제 (우측 상단)
    final group3Y = 100.0;
    final group3X = math.min(diagramWidth - 500.0, centerX + 500.0);

    // 그룹 4: 감정 공유 (좌측 중앙)
    final group4Y = centerY - 200.0;
    final group4X = math.max(100.0, centerX - 800.0);

    // 그룹 5: 후회 없는 편지 (중앙)
    final group5Y = centerY - 200.0;
    final group5X = centerX - 300.0;

    // 그룹 6: AI 기능 (우측 중앙)
    final group6Y = centerY - 200.0;
    final group6X = math.min(diagramWidth - 500.0, centerX + 500.0);

    // 그룹 7: 유언장 (좌측 하단)
    final group7Y = math.min(diagramHeight - 400.0, centerY + 300.0);
    final group7X = math.max(100.0, centerX - 800.0);

    // 그룹 8: 상호 위로 매칭 (중앙 하단)
    final group8Y = math.min(diagramHeight - 400.0, centerY + 300.0);
    final group8X = centerX - 300.0;

    // 그룹 9: 감사 혜택 (우측 하단)
    final group9Y = math.min(diagramHeight - 400.0, centerY + 300.0);
    final group9X = math.min(diagramWidth - 500.0, centerX + 500.0);

    return [
      // 그룹 1: 사용자 및 인증
      _TableInfo('users', group1X, group1Y, Colors.blue, [
        'userId (PK)',
        'email',
        'displayName',
        'isPremium',
        'pushToken',
        'notificationSettings',
      ]),
      _TableInfo('subscriptions', group1X, group1Y + 280, Colors.deepOrange, [
        'subscriptionId (PK)',
        'userId (FK)',
        'plan',
        'status',
        'endDate',
      ]),
      _TableInfo('notifications', group1X, group1Y + 560, Colors.amber, [
        'notificationId (PK)',
        'userId (FK)',
        'memorialId (FK)',
        'type',
        'title',
        'isRead',
      ]),

      // 그룹 2: 추모관 핵심
      _TableInfo('memorials', group2X, group2Y, Colors.green, [
        'memorialId (PK)',
        'creatorId (FK)',
        'memorialType',
        'deceasedName',
        'photos',
        'letter',
        'anniversary',
        'eternalTime',
        'isPublic',
        'visitCount',
      ]),
      _TableInfo('comments', group2X + tableWidth + tableSpacing, group2Y, Colors.orange, [
        'commentId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'userName',
        'content',
        'isAIGenerated',
      ]),
      _TableInfo('prayers', group2X, group2Y + 280, Colors.purple, [
        'prayerId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'title',
        'content',
        'prayerCount',
      ]),
      _TableInfo('prayerParticipants', group2X + tableWidth + tableSpacing, group2Y + 280, Colors.purpleAccent, [
        'prayerId (FK)',
        'userId (FK)',
        'participatedAt',
      ]),
      _TableInfo('visits', group2X, group2Y + 560, Colors.teal, [
        'visitId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'visitedAt',
      ]),
      _TableInfo('shares', group2X + tableWidth + tableSpacing, group2Y + 560, Colors.cyan, [
        'shareId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'shareType',
      ]),
      _TableInfo('backups', group2X, group2Y + 840, Colors.brown, [
        'backupId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'backupType',
        'fileUrl',
      ]),
      _TableInfo('memorialStats', group2X + tableWidth + tableSpacing, group2Y + 840, Colors.indigo, [
        'statId (PK)',
        'memorialId (FK)',
        'date',
        'visitCount',
        'donationCount',
      ]),

      // 그룹 3: 추모금 및 결제
      _TableInfo('donations', group3X, group3Y, Colors.red, [
        'donationId (PK)',
        'memorialId (FK)',
        'donorId (FK)',
        'amount',
        'fee',
        'netAmount',
        'paymentStatus',
        'recipientId (FK)',
      ]),
      _TableInfo('items', group3X, group3Y + 250, Colors.lightGreen, [
        'itemId (PK)',
        'name',
        'type',
        'price',
        'isActive',
      ]),
      _TableInfo('userItems', group3X, group3Y + 500, Colors.lightGreenAccent, [
        'userId (FK)',
        'itemId (FK)',
        'memorialId (FK)',
        'purchasedAt',
      ]),

      // 그룹 4: 감정 공유
      _TableInfo('emotions', group4X, group4Y, Colors.pink, [
        'emotionId (PK)',
        'userId (FK)',
        'title',
        'content',
        'likeCount',
        'category',
        'isAIGenerated',
      ]),
      _TableInfo('emotionLikes', group4X, group4Y + 250, Colors.pinkAccent, [
        'emotionId (FK)',
        'userId (FK)',
        'likedAt',
      ]),
      _TableInfo('emotionComments', group4X, group4Y + 450, Colors.pinkAccent, [
        'commentId (PK)',
        'emotionId (FK)',
        'userId (FK)',
        'content',
      ]),

      // 그룹 5: 후회 없는 편지
      _TableInfo('regretLetters', group5X, group5Y, Colors.deepPurple, [
        'letterId (PK)',
        'userId (FK)',
        'userName',
        'category',
        'visibility',
        'linkedMemorialId (FK)',
        'likeCount',
      ]),
      _TableInfo('regretLetterLikes', group5X + tableWidth + tableSpacing, group5Y, Colors.deepPurpleAccent, [
        'letterId (FK)',
        'userId (FK)',
        'likedAt',
      ]),
      _TableInfo('regretLetterComments', group5X + tableWidth + tableSpacing, group5Y + 200, Colors.deepPurpleAccent, [
        'commentId (PK)',
        'letterId (FK)',
        'userId (FK)',
        'content',
      ]),

      // 그룹 6: AI 기능
      _TableInfo('aiMemories', group6X, group6Y, Colors.indigo, [
        'memoryId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'conversations',
        'analysisResult',
        'analyzedAt',
      ]),
      _TableInfo('aiReplies', group6X, group6Y + 250, Colors.indigoAccent, [
        'replyId (PK)',
        'memorialId (FK)',
        'memoryId (FK)',
        'userId (FK)',
        'userMessage',
        'aiReply',
        'audioUrl',
      ]),

      // 그룹 7: 유언장
      _TableInfo('wills', group7X, group7Y, Colors.blueGrey, [
        'willId (PK)',
        'userId (FK)',
        'userName',
        'category',
        'visibility',
        'likeCount',
        'isTemplate',
      ]),
      _TableInfo('willLikes', group7X, group7Y + 250, Colors.blueGrey, [
        'willId (FK)',
        'userId (FK)',
        'likedAt',
      ]),
      _TableInfo('willComments', group7X, group7Y + 450, Colors.blueGrey, [
        'commentId (PK)',
        'willId (FK)',
        'userId (FK)',
        'content',
      ]),

      // 그룹 8: 상호 위로 매칭
      _TableInfo('matchingProfiles', group8X, group8Y, Colors.teal, [
        'profileId (PK)',
        'userId (FK)',
        'type',
        'lostRelationship',
        'seekingRelationship',
        'status',
        'isVerified',
      ]),
      _TableInfo('matchingRequests', group8X + tableWidth + tableSpacing, group8Y, Colors.tealAccent, [
        'requestId (PK)',
        'senderProfileId (FK)',
        'receiverProfileId (FK)',
        'status',
        'message',
      ]),
      _TableInfo('matchings', group8X, group8Y + 280, Colors.tealAccent, [
        'matchingId (PK)',
        'profileId1 (FK)',
        'profileId2 (FK)',
        'requestId (FK)',
        'status',
      ]),
      _TableInfo('matchingChats', group8X + tableWidth + tableSpacing, group8Y + 280, Colors.tealAccent, [
        'chatId (PK)',
        'matchingId (FK)',
        'senderId (FK)',
        'message',
        'isRead',
      ]),
      _TableInfo('matchingReports', group8X, group8Y + 560, Colors.redAccent, [
        'reportId (PK)',
        'reporterId (FK)',
        'reportedProfileId (FK)',
        'status',
      ]),

      // 그룹 9: 감사 혜택
      _TableInfo('gratitudeBenefits', group9X, group9Y, Colors.amber, [
        'benefitId (PK)',
        'title',
        'type',
        'isActive',
        'startDate',
        'endDate',
        'conditions',
        'rewards',
      ]),
      _TableInfo('benefitParticipants', group9X, group9Y + 280, Colors.amberAccent, [
        'participantId (PK)',
        'benefitId (FK)',
        'userId (FK)',
        'rewardReceived',
      ]),
      _TableInfo('userRewards', group9X, group9Y + 520, Colors.orange, [
        'rewardId (PK)',
        'userId (FK)',
        'type',
        'source',
        'premiumMonths',
        'endDate',
        'isUsed',
      ]),
    ];
  }

  List<_Relationship> _buildRelationships(List<_TableInfo> tables) {
    final tableNames = tables.map((t) => t.name).toSet();
    final allRelationships = [
      _Relationship('users', 'memorials', '1:N', Colors.blue),
      _Relationship('users', 'comments', '1:N', Colors.blue),
      _Relationship('users', 'prayers', '1:N', Colors.blue),
      _Relationship('users', 'donations', '1:N', Colors.blue),
      _Relationship('users', 'emotions', '1:N', Colors.blue),
      _Relationship('users', 'regretLetters', '1:N', Colors.blue),
      _Relationship('users', 'wills', '1:N', Colors.blue),
      _Relationship('users', 'matchingProfiles', '1:N', Colors.blue),
      _Relationship('users', 'subscriptions', '1:N', Colors.blue),
      _Relationship('users', 'userItems', '1:N', Colors.blue),
      _Relationship('users', 'userRewards', '1:N', Colors.blue),
      _Relationship('users', 'notifications', '1:N', Colors.blue),
      _Relationship('memorials', 'comments', '1:N', Colors.green),
      _Relationship('memorials', 'prayers', '1:N', Colors.green),
      _Relationship('memorials', 'donations', '1:N', Colors.green),
      _Relationship('memorials', 'visits', '1:N', Colors.green),
      _Relationship('memorials', 'shares', '1:N', Colors.green),
      _Relationship('memorials', 'backups', '1:N', Colors.green),
      _Relationship('memorials', 'memorialStats', '1:N', Colors.green),
      _Relationship('memorials', 'aiMemories', '1:N', Colors.green),
      _Relationship('memorials', 'aiReplies', '1:N', Colors.green),
      _Relationship('memorials', 'regretLetters', '1:N', Colors.green),
      _Relationship('emotions', 'emotionLikes', '1:N', Colors.pink),
      _Relationship('emotions', 'emotionComments', '1:N', Colors.pink),
      _Relationship('prayers', 'prayerParticipants', '1:N', Colors.purple),
      _Relationship('users', 'prayerParticipants', 'N:M', Colors.purple),
      _Relationship('regretLetters', 'regretLetterLikes', '1:N', Colors.deepPurple),
      _Relationship('regretLetters', 'regretLetterComments', '1:N', Colors.deepPurple),
      _Relationship('aiMemories', 'aiReplies', '1:N', Colors.indigo),
      _Relationship('wills', 'willLikes', '1:N', Colors.blueGrey),
      _Relationship('wills', 'willComments', '1:N', Colors.blueGrey),
      _Relationship('matchingProfiles', 'matchingRequests', '1:N', Colors.teal),
      _Relationship('matchingProfiles', 'matchings', 'N:M', Colors.teal),
      _Relationship('matchingRequests', 'matchings', '1:N', Colors.teal),
      _Relationship('matchings', 'matchingChats', '1:N', Colors.teal),
      _Relationship('gratitudeBenefits', 'benefitParticipants', '1:N', Colors.amber),
      _Relationship('users', 'benefitParticipants', 'N:M', Colors.amber),
      _Relationship('items', 'userItems', '1:N', Colors.lightGreen),
      _Relationship('memorials', 'userItems', '1:N', Colors.green),
    ];

    // 필터링된 테이블에 해당하는 관계만 반환
    return allRelationships.where((rel) {
      return tableNames.contains(rel.from) && tableNames.contains(rel.to);
    }).toList();
  }

  void _drawGrid(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.grey[200]!;
    paint.strokeWidth = 1;
    const gridSize = 50.0;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  void _drawGroupBackgrounds(Canvas canvas, List<_TableInfo> tables, Paint paint) {
    // 그룹별 배경 영역 그리기 (선택적)
    if (selectedCategory != '전체') return;

    final centerX = diagramWidth / 2;
    final centerY = diagramHeight / 2;

    final groups = [
      {'name': '사용자 및 인증', 'x': math.max(50.0, centerX - 850.0), 'y': 50.0, 'width': 400.0, 'height': 700.0, 'color': Colors.blue.withOpacity(0.05)},
      {'name': '추모관 핵심', 'x': centerX - 350.0, 'y': 50.0, 'width': 600.0, 'height': 1000.0, 'color': Colors.green.withOpacity(0.05)},
      {'name': '추모금 및 결제', 'x': math.min(diagramWidth - 450.0, centerX + 450.0), 'y': 50.0, 'width': 400.0, 'height': 600.0, 'color': Colors.red.withOpacity(0.05)},
      {'name': '감정 공유', 'x': math.max(50.0, centerX - 850.0), 'y': centerY - 250.0, 'width': 400.0, 'height': 500.0, 'color': Colors.pink.withOpacity(0.05)},
      {'name': '후회 없는 편지', 'x': centerX - 350.0, 'y': centerY - 250.0, 'width': 600.0, 'height': 300.0, 'color': Colors.deepPurple.withOpacity(0.05)},
      {'name': 'AI 기능', 'x': math.min(diagramWidth - 450.0, centerX + 450.0), 'y': centerY - 250.0, 'width': 400.0, 'height': 400.0, 'color': Colors.indigo.withOpacity(0.05)},
      {'name': '유언장', 'x': math.max(50.0, centerX - 850.0), 'y': math.min(diagramHeight - 450.0, centerY + 250.0), 'width': 400.0, 'height': 400.0, 'color': Colors.blueGrey.withOpacity(0.05)},
      {'name': '상호 위로 매칭', 'x': centerX - 350.0, 'y': math.min(diagramHeight - 450.0, centerY + 250.0), 'width': 600.0, 'height': 600.0, 'color': Colors.teal.withOpacity(0.05)},
      {'name': '감사 혜택', 'x': math.min(diagramWidth - 450.0, centerX + 450.0), 'y': math.min(diagramHeight - 450.0, centerY + 250.0), 'width': 400.0, 'height': 600.0, 'color': Colors.amber.withOpacity(0.05)},
    ];

    for (final group in groups) {
      paint.style = PaintingStyle.fill;
      paint.color = group['color'] as Color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (group['x'] as num).toDouble(),
            (group['y'] as num).toDouble(),
            (group['width'] as num).toDouble(),
            (group['height'] as num).toDouble(),
          ),
          const Radius.circular(8),
        ),
        paint,
      );
    }
  }

  void _drawGroupLabels(Canvas canvas, List<_TableInfo> tables, Paint paint, TextStyle textStyle) {
    if (selectedCategory != '전체') return;

    final centerX = diagramWidth / 2;
    final centerY = diagramHeight / 2;

    final groups = [
      {'name': '사용자 및 인증', 'x': math.max(70.0, centerX - 830.0), 'y': 70.0},
      {'name': '추모관 핵심', 'x': centerX - 330.0, 'y': 70.0},
      {'name': '추모금 및 결제', 'x': math.min(diagramWidth - 430.0, centerX + 470.0), 'y': 70.0},
      {'name': '감정 공유', 'x': math.max(70.0, centerX - 830.0), 'y': centerY - 230.0},
      {'name': '후회 없는 편지', 'x': centerX - 330.0, 'y': centerY - 230.0},
      {'name': 'AI 기능', 'x': math.min(diagramWidth - 430.0, centerX + 470.0), 'y': centerY - 230.0},
      {'name': '유언장', 'x': math.max(70.0, centerX - 830.0), 'y': math.min(diagramHeight - 430.0, centerY + 270.0)},
      {'name': '상호 위로 매칭', 'x': centerX - 330.0, 'y': math.min(diagramHeight - 430.0, centerY + 270.0)},
      {'name': '감사 혜택', 'x': math.min(diagramWidth - 430.0, centerX + 470.0), 'y': math.min(diagramHeight - 430.0, centerY + 270.0)},
    ];

    for (final group in groups) {
      final textSpan = TextSpan(
        text: group['name'] as String,
        style: textStyle.copyWith(
          fontSize: 16,
          color: Colors.grey[700],
          fontWeight: FontWeight.w600,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (group['x'] as num).toDouble(),
          (group['y'] as num).toDouble(),
        ),
      );
    }
  }

  void _drawRelationship(
    Canvas canvas,
    _TableInfo fromTable,
    _TableInfo toTable,
    _Relationship rel,
    Paint paint,
  ) {
    final fromX = fromTable.x + 220 / 2; // 테이블 중앙
    final fromY = fromTable.y + 30;
    final toX = toTable.x + 220 / 2;
    final toY = toTable.y + 30;

    // 같은 그룹 내 관계는 더 진한 색상
    paint.color = rel.color.withOpacity(0.6);
    paint.strokeWidth = 2;

    // 직선으로 연결
    canvas.drawLine(
      Offset(fromX, fromY),
      Offset(toX, toY),
      paint,
    );

    // 화살표 그리기
    _drawArrow(canvas, Offset(fromX, fromY), Offset(toX, toY), rel.color.withOpacity(0.8));

    // 관계 레이블 (선택적, 너무 많으면 생략)
    final distance = math.sqrt(math.pow(toX - fromX, 2) + math.pow(toY - fromY, 2));
    if (distance > 300 && distance < 800) {
      final midX = (fromX + toX) / 2;
      final midY = (fromY + toY) / 2;
      final textSpan = TextSpan(
        text: rel.type,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: rel.color.withOpacity(0.8),
          backgroundColor: Colors.white,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(midX - textPainter.width / 2, midY - textPainter.height / 2),
      );
    }
  }

  void _drawTable(
    Canvas canvas,
    _TableInfo table,
    Paint paint,
    TextStyle titleStyle,
    TextStyle fieldStyle,
  ) {
    const tableWidth = 220.0;
    const headerHeight = 35.0;
    const fieldHeight = 22.0;
    final tableHeight = headerHeight + (table.fields.length * fieldHeight);

    // 테이블 배경
    paint.style = PaintingStyle.fill;
    paint.color = table.color.withOpacity(0.15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(table.x, table.y, tableWidth, tableHeight),
        const Radius.circular(6),
      ),
      paint,
    );

    // 테이블 테두리
    paint.style = PaintingStyle.stroke;
    paint.color = table.color;
    paint.strokeWidth = 2.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(table.x, table.y, tableWidth, tableHeight),
        const Radius.circular(6),
      ),
      paint,
    );

    // 헤더 구분선
    paint.color = table.color;
    paint.strokeWidth = 2.5;
    canvas.drawLine(
      Offset(table.x, table.y + headerHeight),
      Offset(table.x + tableWidth, table.y + headerHeight),
      paint,
    );

    // 테이블 이름
    final titleSpan = TextSpan(
      text: table.name,
      style: titleStyle.copyWith(
        color: table.color,
        fontSize: 13,
      ),
    );
    final titlePainter = TextPainter(
      text: titleSpan,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titlePainter.paint(
      canvas,
      Offset(
        table.x + (tableWidth - titlePainter.width) / 2,
        table.y + (headerHeight - titlePainter.height) / 2,
      ),
    );

    // 필드 그리기
    for (int i = 0; i < table.fields.length; i++) {
      final fieldY = table.y + headerHeight + (i * fieldHeight);

      // 필드 구분선
      paint.color = Colors.grey[300]!;
      paint.strokeWidth = 1;
      canvas.drawLine(
        Offset(table.x, fieldY),
        Offset(table.x + tableWidth, fieldY),
        paint,
      );

      // 필드 텍스트
      final fieldText = table.fields[i];
      final fieldSpan = TextSpan(
        text: fieldText,
        style: fieldStyle,
      );
      final fieldPainter = TextPainter(
        text: fieldSpan,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '...',
      );
      fieldPainter.layout(maxWidth: tableWidth - 16);
      fieldPainter.paint(
        canvas,
        Offset(table.x + 8, fieldY + (fieldHeight - fieldPainter.height) / 2),
      );

      // PK/FK 표시
      if (fieldText.contains('(PK)')) {
        paint.style = PaintingStyle.fill;
        paint.color = Colors.blue;
        canvas.drawCircle(
          Offset(table.x + 12, fieldY + fieldHeight / 2),
          5,
          paint,
        );
      } else if (fieldText.contains('(FK)')) {
        paint.style = PaintingStyle.fill;
        paint.color = Colors.green;
        canvas.drawCircle(
          Offset(table.x + 12, fieldY + fieldHeight / 2),
          5,
          paint,
        );
      }
    }
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const arrowLength = 12.0;
    const arrowAngle = math.pi / 6;

    final path = Path();
    path.moveTo(to.dx, to.dy);
    path.lineTo(
      to.dx - arrowLength * math.cos(angle - arrowAngle),
      to.dy - arrowLength * math.sin(angle - arrowAngle),
    );
    path.lineTo(
      to.dx - arrowLength * math.cos(angle + arrowAngle),
      to.dy - arrowLength * math.sin(angle + arrowAngle),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is DatabaseDiagramPainter) {
      return oldDelegate.selectedCategory != selectedCategory ||
          oldDelegate.categoryTables != categoryTables;
    }
    return true;
  }
}

class _TableInfo {
  final String name;
  final double x;
  final double y;
  final Color color;
  final List<String> fields;

  _TableInfo(this.name, this.x, this.y, this.color, this.fields);
}

class _Relationship {
  final String from;
  final String to;
  final String type;
  final Color color;

  _Relationship(this.from, this.to, this.type, this.color);
}
