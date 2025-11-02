import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final String userId; // 작성자 UID
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DateTime> updatedAtHistory; // 수정 시간 히스토리
  final int views;
  final bool isDeleted; // 삭제 여부 (소프트 삭제)

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    List<DateTime>? updatedAtHistory,
    this.views = 0,
    this.isDeleted = false,
  }) : updatedAtHistory = updatedAtHistory ?? [];

  // Firestore 문서를 Post 객체로 변환
  factory Post.fromFirestore(Map<String, dynamic> data, String id) {
    // 수정 시간 히스토리 파싱
    List<DateTime> history = [];
    if (data['updatedAtHistory'] != null) {
      final historyData = data['updatedAtHistory'] as List<dynamic>?;
      if (historyData != null) {
        history = historyData
            .map((timestamp) => (timestamp as Timestamp).toDate())
            .toList();
      }
    }

    return Post(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? '익명',
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAtHistory: history,
      views: data['views'] ?? 0,
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  // Post 객체를 Firestore 문서로 변환
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'author': author,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'updatedAtHistory': updatedAtHistory.map((date) => Timestamp.fromDate(date)).toList(),
      'views': views,
      'isDeleted': isDeleted,
    };
  }

  // 수정되었는지 확인 (생성 시간과 마지막 수정 시간이 다르면 수정됨)
  bool get isModified => createdAt != updatedAt;
}

