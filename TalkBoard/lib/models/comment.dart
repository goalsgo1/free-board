import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String postId; // 댓글이 속한 게시글 ID
  final String? parentCommentId; // 대댓글인 경우 부모 댓글 ID (null이면 일반 댓글)
  final String content; // 댓글 내용
  final String author; // 작성자 이름
  final String userId; // 작성자 UID
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DateTime> updatedAtHistory; // 수정 시간 히스토리
  final bool isDeleted; // 삭제 여부 (소프트 삭제)

  Comment({
    required this.id,
    required this.postId,
    this.parentCommentId,
    required this.content,
    required this.author,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    List<DateTime>? updatedAtHistory,
    this.isDeleted = false,
  }) : updatedAtHistory = updatedAtHistory ?? [];

  // 일반 댓글인지 확인
  bool get isRootComment => parentCommentId == null || parentCommentId!.isEmpty;
  
  // 대댓글인지 확인
  bool get isReply => !isRootComment;

  // Firestore 문서를 Comment 객체로 변환
  factory Comment.fromFirestore(Map<String, dynamic> data, String id) {
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

    return Comment(
      id: id,
      postId: data['postId'] ?? '',
      parentCommentId: data['parentCommentId'] as String?,
      content: data['content'] ?? '',
      author: data['author'] ?? '익명',
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAtHistory: history,
      isDeleted: data['isDeleted'] ?? false,
    );
  }

  // Comment 객체를 Firestore 문서로 변환
  Map<String, dynamic> toFirestore() {
    final map = <String, dynamic>{
      'postId': postId,
      'content': content,
      'author': author,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'updatedAtHistory':
          updatedAtHistory.map((date) => Timestamp.fromDate(date)).toList(),
      'isDeleted': isDeleted,
    };
    
    // parentCommentId가 있으면 추가
    if (parentCommentId != null && parentCommentId!.isNotEmpty) {
      map['parentCommentId'] = parentCommentId!;
    }
    
    return map;
  }

  // 수정되었는지 확인
  bool get isModified => createdAt != updatedAt;
}

