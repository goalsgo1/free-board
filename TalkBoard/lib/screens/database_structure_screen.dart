import 'package:flutter/material.dart';
import 'database_diagram_screen.dart';

class DatabaseStructureScreen extends StatelessWidget {
  const DatabaseStructureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터베이스 구조'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree),
            tooltip: '다이어그램 보기',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DatabaseDiagramScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Firestore 컬렉션 구조',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildTableCard(
              context,
              'users (사용자)',
              [
                'userId: string (PK)',
                'email: string',
                'displayName: string',
                'createdAt: timestamp',
                'updatedAt: timestamp',
                'isPremium: boolean',
                'premiumExpiresAt: timestamp',
                'pushToken: string',
                'lastActiveAt: timestamp',
                'lastNotificationSentAt: timestamp',
                'dailyNotificationCount: number',
                'notificationSettings: object',
              ],
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'memorials (추모관)',
              [
                'memorialId: string (PK)',
                'creatorId: string (FK → users)',
                'memorialType: human | pet',
                'deceasedName: string',
                'lifeSummary: string',
                'isAIGenerated: boolean',
                'aiGeneratedAt: timestamp',
                'photos: array',
                'video: object',
                'letter: object',
                'anniversary: object',
                'eternalTime: object',
                'notificationSettings: object',
                'isPublic: boolean',
                'visitCount: number',
                'shareCount: number',
                'commentCount: number',
                'donationCount: number',
                'totalDonationAmount: number',
                'createdAt: timestamp',
                'updatedAt: timestamp',
                'deletedAt: timestamp',
              ],
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'comments (댓글)',
              [
                'commentId: string (PK)',
                'memorialId: string (FK → memorials)',
                'userId: string (FK → users)',
                'userName: string',
                'content: string',
                'isAIGenerated: boolean',
                'aiGeneratedAt: timestamp',
                'createdAt: timestamp',
                'updatedAt: timestamp',
                'deletedAt: timestamp',
              ],
              Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'prayers (기도 요청)',
              [
                'prayerId: string (PK)',
                'memorialId: string (FK → memorials)',
                'userId: string (FK → users)',
                'userName: string',
                'title: string',
                'content: string',
                'prayerCount: number',
                'participants: array',
                'isAIGenerated: boolean',
                'aiGeneratedAt: timestamp',
                'createdAt: timestamp',
                'updatedAt: timestamp',
              ],
              Colors.purple,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'prayerParticipants (기도 참여자)',
              [
                'prayerId: string (FK → prayers)',
                'userId: string (FK → users)',
                'participatedAt: timestamp',
              ],
              Colors.purpleAccent,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'donations (추모금)',
              [
                'donationId: string (PK)',
                'memorialId: string (FK → memorials)',
                'donorId: string (FK → users)',
                'donorName: string',
                'amount: number',
                'fee: number',
                'maintenanceFee: number',
                'netAmount: number',
                'paymentMethod: string',
                'paymentStatus: pending | completed | failed',
                'recipientId: string (FK → users)',
                'withdrawnAt: timestamp',
                'createdAt: timestamp',
                'completedAt: timestamp',
              ],
              Colors.red,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'emotions (감정 공유 게시판)',
              [
                'emotionId: string (PK)',
                'userId: string (FK → users)',
                'userName: string',
                'title: string',
                'content: string',
                'likeCount: number',
                'commentCount: number',
                'category: grief | memory | comfort',
                'isAIGenerated: boolean',
                'aiGeneratedAt: timestamp',
                'createdAt: timestamp',
                'updatedAt: timestamp',
                'deletedAt: timestamp',
              ],
              Colors.pink,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'emotionLikes (감정 글 좋아요)',
              [
                'emotionId: string (FK → emotions)',
                'userId: string (FK → users)',
                'likedAt: timestamp',
              ],
              Colors.pinkAccent,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'emotionComments (감정 글 댓글)',
              [
                'commentId: string (PK)',
                'emotionId: string (FK → emotions)',
                'userId: string (FK → users)',
                'userName: string',
                'content: string',
                'createdAt: timestamp',
                'updatedAt: timestamp',
                'deletedAt: timestamp',
              ],
              Colors.pinkAccent,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'visits (방문 기록)',
              [
                'visitId: string (PK)',
                'memorialId: string (FK → memorials)',
                'userId: string (FK → users)',
                'visitedAt: timestamp',
                'date: date',
              ],
              Colors.teal,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'shares (공유 기록)',
              [
                'shareId: string (PK)',
                'memorialId: string (FK → memorials)',
                'userId: string (FK → users)',
                'shareType: link | qr | sns',
                'sharedAt: timestamp',
              ],
              Colors.cyan,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'memorialStats (추모관 통계)',
              [
                'statId: string (PK)',
                'memorialId: string (FK → memorials)',
                'date: date',
                'visitCount: number',
                'commentCount: number',
                'donationCount: number',
                'totalDonationAmount: number',
              ],
              Colors.indigo,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'backups (백업/내보내기)',
              [
                'backupId: string (PK)',
                'memorialId: string (FK → memorials)',
                'userId: string (FK → users)',
                'backupType: pdf | photos | videos | letters | full',
                'fileUrl: string',
                'fileSize: number',
                'createdAt: timestamp',
              ],
              Colors.brown,
            ),
            const SizedBox(height: 16),
            _buildTableCard(
              context,
              'notifications (알림 내역)',
              [
                'notificationId: string (PK)',
                'userId: string (FK → users)',
                'type: string',
                'title: string',
                'body: string',
                'data: object',
                'memorialId: string (FK → memorials)',
                'isRead: boolean',
                'sentAt: timestamp',
                'readAt: timestamp',
              ],
              Colors.amber,
            ),
            const SizedBox(height: 24),
            const Text(
              '관계도',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRelationshipCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCard(
    BuildContext context,
    String tableName,
    List<String> fields,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  color: color,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tableName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...fields.map((field) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      const Text('• ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          field,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationshipCard(BuildContext context) {
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
              '주요 관계',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRelationshipItem('users', '1:N', 'memorials'),
            _buildRelationshipItem('users', '1:N', 'comments'),
            _buildRelationshipItem('users', '1:N', 'prayers'),
            _buildRelationshipItem('users', '1:N', 'donations'),
            _buildRelationshipItem('users', '1:N', 'emotions'),
            _buildRelationshipItem('memorials', '1:N', 'comments'),
            _buildRelationshipItem('memorials', '1:N', 'prayers'),
            _buildRelationshipItem('memorials', '1:N', 'donations'),
            _buildRelationshipItem('memorials', '1:N', 'visits'),
            _buildRelationshipItem('memorials', '1:N', 'shares'),
            _buildRelationshipItem('memorials', '1:N', 'backups'),
            _buildRelationshipItem('emotions', '1:N', 'emotionLikes'),
            _buildRelationshipItem('emotions', '1:N', 'emotionComments'),
            _buildRelationshipItem('prayers', 'N:M', 'users (prayerParticipants)'),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationshipItem(String from, String relation, String to) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              from,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            relation,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              to,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

