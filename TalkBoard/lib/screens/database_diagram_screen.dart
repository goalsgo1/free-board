import 'package:flutter/material.dart';
import 'dart:math' as math;

class DatabaseDiagramScreen extends StatelessWidget {
  const DatabaseDiagramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 다이어그램'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ERD (Entity-Relationship Diagram)',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // 다이어그램 영역
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomPaint(
                size: const Size(double.infinity, 2000),
                painter: DatabaseDiagramPainter(),
                child: const SizedBox(
                  width: double.infinity,
                  height: 2000,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 범례
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '범례',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildLegendItem('PK', 'Primary Key (기본키)', Colors.blue),
            _buildLegendItem('FK', 'Foreign Key (외래키)', Colors.green),
            _buildLegendItem('1:N', 'One-to-Many (일대다)', Colors.orange),
            _buildLegendItem('N:M', 'Many-to-Many (다대다)', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String symbol, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
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
          const SizedBox(width: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class DatabaseDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final fieldTextStyle = const TextStyle(
      fontSize: 10,
      color: Colors.black87,
    );

    // 테이블 위치 정의
    final tables = [
      _TableInfo('users', 100, 100, Colors.blue, [
        'userId (PK)',
        'email',
        'displayName',
        'isPremium',
        'pushToken',
        'notificationSettings',
      ]),
      _TableInfo('memorials', 400, 100, Colors.green, [
        'memorialId (PK)',
        'creatorId (FK)',
        'memorialType',
        'deceasedName',
        'isAIGenerated',
        'photos',
        'letter',
        'anniversary',
        'eternalTime',
        'isPublic',
        'visitCount',
      ]),
      _TableInfo('comments', 700, 100, Colors.orange, [
        'commentId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'userName',
        'content',
        'isAIGenerated',
      ]),
      _TableInfo('prayers', 100, 400, Colors.purple, [
        'prayerId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'title',
        'content',
        'prayerCount',
        'isAIGenerated',
      ]),
      _TableInfo('prayerParticipants', 400, 400, Colors.purpleAccent, [
        'prayerId (FK)',
        'userId (FK)',
        'participatedAt',
      ]),
      _TableInfo('donations', 700, 400, Colors.red, [
        'donationId (PK)',
        'memorialId (FK)',
        'donorId (FK)',
        'amount',
        'fee',
        'netAmount',
        'paymentStatus',
        'recipientId (FK)',
      ]),
      _TableInfo('emotions', 100, 700, Colors.pink, [
        'emotionId (PK)',
        'userId (FK)',
        'title',
        'content',
        'likeCount',
        'category',
        'isAIGenerated',
      ]),
      _TableInfo('emotionLikes', 400, 700, Colors.pinkAccent, [
        'emotionId (FK)',
        'userId (FK)',
        'likedAt',
      ]),
      _TableInfo('emotionComments', 700, 700, Colors.pinkAccent, [
        'commentId (PK)',
        'emotionId (FK)',
        'userId (FK)',
        'content',
      ]),
      _TableInfo('visits', 100, 1000, Colors.teal, [
        'visitId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'visitedAt',
      ]),
      _TableInfo('shares', 400, 1000, Colors.cyan, [
        'shareId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'shareType',
      ]),
      _TableInfo('memorialStats', 700, 1000, Colors.indigo, [
        'statId (PK)',
        'memorialId (FK)',
        'date',
        'visitCount',
        'donationCount',
      ]),
      _TableInfo('backups', 100, 1300, Colors.brown, [
        'backupId (PK)',
        'memorialId (FK)',
        'userId (FK)',
        'backupType',
        'fileUrl',
      ]),
      _TableInfo('notifications', 400, 1300, Colors.amber, [
        'notificationId (PK)',
        'userId (FK)',
        'memorialId (FK)',
        'type',
        'title',
        'isRead',
      ]),
    ];

    // 관계선 정의
    final relationships = [
      _Relationship('users', 'memorials', '1:N', Colors.blue),
      _Relationship('users', 'comments', '1:N', Colors.blue),
      _Relationship('users', 'prayers', '1:N', Colors.blue),
      _Relationship('users', 'donations', '1:N', Colors.blue),
      _Relationship('users', 'emotions', '1:N', Colors.blue),
      _Relationship('memorials', 'comments', '1:N', Colors.green),
      _Relationship('memorials', 'prayers', '1:N', Colors.green),
      _Relationship('memorials', 'donations', '1:N', Colors.green),
      _Relationship('memorials', 'visits', '1:N', Colors.green),
      _Relationship('memorials', 'shares', '1:N', Colors.green),
      _Relationship('memorials', 'backups', '1:N', Colors.green),
      _Relationship('memorials', 'memorialStats', '1:N', Colors.green),
      _Relationship('memorials', 'notifications', '1:N', Colors.green),
      _Relationship('emotions', 'emotionLikes', '1:N', Colors.pink),
      _Relationship('emotions', 'emotionComments', '1:N', Colors.pink),
      _Relationship('prayers', 'prayerParticipants', '1:N', Colors.purple),
      _Relationship('users', 'prayerParticipants', 'N:M', Colors.purple),
    ];

    // 관계선 그리기
    for (final rel in relationships) {
      final fromTable = tables.firstWhere((t) => t.name == rel.from);
      final toTable = tables.firstWhere((t) => t.name == rel.to);

      final fromX = fromTable.x + 150; // 테이블 오른쪽 중앙
      final fromY = fromTable.y + 30;
      final toX = toTable.x; // 테이블 왼쪽 중앙
      final toY = toTable.y + 30;

      // 관계선 그리기
      paint.color = rel.color;
      paint.strokeWidth = 2;
      canvas.drawLine(
        Offset(fromX, fromY),
        Offset(toX, toY),
        paint,
      );

      // 화살표 그리기
      _drawArrow(canvas, Offset(fromX, fromY), Offset(toX, toY), rel.color);

      // 관계 레이블 그리기
      final midX = (fromX + toX) / 2;
      final midY = (fromY + toY) / 2;
      final textSpan = TextSpan(
        text: rel.type,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: rel.color,
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

    // 테이블 그리기
    for (final table in tables) {
      _drawTable(canvas, table, paint, textStyle, fieldTextStyle);
    }
  }

  void _drawTable(
    Canvas canvas,
    _TableInfo table,
    Paint paint,
    TextStyle titleStyle,
    TextStyle fieldStyle,
  ) {
    const tableWidth = 200.0;
    const headerHeight = 30.0;
    const fieldHeight = 20.0;
    final tableHeight = headerHeight + (table.fields.length * fieldHeight);

    // 테이블 배경
    paint.style = PaintingStyle.fill;
    paint.color = table.color.withOpacity(0.1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(table.x, table.y, tableWidth, tableHeight),
        const Radius.circular(4),
      ),
      paint,
    );

    // 테이블 테두리
    paint.style = PaintingStyle.stroke;
    paint.color = table.color;
    paint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(table.x, table.y, tableWidth, tableHeight),
        const Radius.circular(4),
      ),
      paint,
    );

    // 헤더 구분선
    paint.color = table.color;
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(table.x, table.y + headerHeight),
      Offset(table.x + tableWidth, table.y + headerHeight),
      paint,
    );

    // 테이블 이름
    final titleSpan = TextSpan(
      text: table.name,
      style: titleStyle.copyWith(color: table.color),
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
      fieldPainter.layout(maxWidth: tableWidth - 8);
      fieldPainter.paint(
        canvas,
        Offset(table.x + 4, fieldY + (fieldHeight - fieldPainter.height) / 2),
      );

      // PK/FK 표시
      if (fieldText.contains('(PK)')) {
        paint.style = PaintingStyle.fill;
        paint.color = Colors.blue;
        canvas.drawCircle(
          Offset(table.x + 8, fieldY + fieldHeight / 2),
          4,
          paint,
        );
      } else if (fieldText.contains('(FK)')) {
        paint.style = PaintingStyle.fill;
        paint.color = Colors.green;
        canvas.drawCircle(
          Offset(table.x + 8, fieldY + fieldHeight / 2),
          4,
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
    const arrowLength = 10.0;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

