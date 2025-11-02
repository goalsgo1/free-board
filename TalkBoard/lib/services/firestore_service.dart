import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/comment.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'posts';

  // 게시글 목록 가져오기 (최신순, 삭제되지 않은 것만)
  Stream<List<Post>> getPosts() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromFirestore(doc.data(), doc.id))
            .where((post) => !post.isDeleted) // 클라이언트 측에서 필터링 (기존 데이터 호환)
            .toList());
  }

  // 삭제된 게시글 목록 가져오기 (삭제 시간 최신순)
  // userId가 제공되면 해당 사용자가 작성한 게시글만 반환
  Stream<List<Post>> getDeletedPosts({String? userId}) {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true) // deletedAt이 없을 수 있으므로 createdAt 사용
        .snapshots()
        .map((snapshot) {
          final allPosts = snapshot.docs
              .map((doc) => Post.fromFirestore(doc.data(), doc.id))
              .where((post) => post.isDeleted) // 삭제된 게시글만
              .where((post) => userId == null || post.userId == userId) // userId가 제공되면 필터링
              .toList();
          
          // deletedAt 기준으로 정렬 (있는 경우)
          allPosts.sort((a, b) {
            // Firestore에서 직접 deletedAt 가져와서 비교
            // 일단 createdAt으로 정렬 (나중에 개선 가능)
            return b.createdAt.compareTo(a.createdAt);
          });
          
          return allPosts;
        });
  }

  // 특정 게시글 가져오기 (한 번만, 삭제되지 않은 것만)
  Future<Post?> getPost(String postId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(postId).get();
      if (doc.exists && doc.data() != null) {
        final post = Post.fromFirestore(doc.data()!, doc.id);
        // 삭제된 게시글은 null 반환
        if (post.isDeleted) return null;
        return post;
      }
      return null;
    } catch (e) {
      print('Error getting post: $e');
      return null;
    }
  }

  // 특정 게시글 가져오기 (실시간 업데이트, 삭제되지 않은 것만)
  Stream<Post?> getPostStream(String postId) {
    return _firestore
        .collection(_collection)
        .doc(postId)
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        final post = Post.fromFirestore(doc.data()!, doc.id);
        // 삭제된 게시글은 null 반환
        if (post.isDeleted) return null;
        return post;
      }
      return null;
    });
  }

  // 게시글 작성
  Future<String?> createPost(Post post) async {
    try {
      // isDeleted는 기본값 false로 생성
      final postData = post.toFirestore();
      postData['isDeleted'] = false;
      final docRef = await _firestore.collection(_collection).add(postData);
      return docRef.id;
    } catch (e) {
      print('Error creating post: $e');
      return null;
    }
  }

  // 게시글 수정
  Future<bool> updatePost(String postId, String title, String content) async {
    try {
      // 현재 게시글 가져오기
      final doc = await _firestore.collection(_collection).doc(postId).get();
      if (!doc.exists || doc.data() == null) {
        return false;
      }

      final currentData = doc.data()!;
      final now = DateTime.now();
      
      // 기존 수정 히스토리 가져오기
      List<DateTime> history = [];
      if (currentData['updatedAtHistory'] != null) {
        final historyData = currentData['updatedAtHistory'] as List<dynamic>;
        history = historyData
            .map((timestamp) => (timestamp as Timestamp).toDate())
            .toList();
      }
      
      // 새로운 수정 시간 추가
      history.add(now);

      await _firestore.collection(_collection).doc(postId).update({
        'title': title,
        'content': content,
        'updatedAt': Timestamp.fromDate(now),
        'updatedAtHistory': history.map((date) => Timestamp.fromDate(date)).toList(),
      });
      return true;
    } catch (e) {
      print('Error updating post: $e');
      return false;
    }
  }

  // 게시글 삭제 (소프트 삭제 - isDeleted = true로 변경)
  Future<bool> deletePost(String postId) async {
    try {
      final now = Timestamp.fromDate(DateTime.now());
      
      // 게시글을 소프트 삭제 (isDeleted = true)
      await _firestore.collection(_collection).doc(postId).update({
        'isDeleted': true,
        'deletedAt': now,
      });
      
      // 해당 게시글의 모든 댓글도 소프트 삭제 (isDeleted가 false인 것만)
      final commentsSnapshot = await _firestore
          .collection(_commentCollection)
          .where('postId', isEqualTo: postId)
          .get();
      
      // 클라이언트 측에서 필터링 (기존 데이터 호환)
      final activeComments = commentsSnapshot.docs.where((doc) {
        final data = doc.data();
        return data['isDeleted'] != true;
      }).toList();
      
      if (activeComments.isNotEmpty) {
        final batch = _firestore.batch();
        for (final doc in activeComments) {
          batch.update(doc.reference, {
            'isDeleted': true,
            'deletedAt': now,
          });
        }
        await batch.commit();
      }
      
      return true;
    } catch (e) {
      print('Error deleting post: $e');
      return false;
    }
  }

  // 게시글 복원 (isDeleted = false로 변경, 댓글도 함께 복원)
  // 게시글 삭제 시점에 함께 삭제된 댓글들만 복원
  // (게시글 삭제 전에 이미 삭제된 댓글은 복원하지 않음)
  Future<bool> restorePost(String postId) async {
    try {
      // 게시글 정보 가져오기 (deletedAt 확인용)
      final postDoc = await _firestore.collection(_collection).doc(postId).get();
      if (!postDoc.exists || postDoc.data() == null) {
        return false;
      }
      
      final postData = postDoc.data()!;
      final postDeletedAt = postData['deletedAt'] as Timestamp?;
      
      // 게시글을 복원 (isDeleted = false)
      await _firestore.collection(_collection).doc(postId).update({
        'isDeleted': false,
        'deletedAt': FieldValue.delete(), // deletedAt 필드 제거
      });
      
      // 해당 게시글의 삭제된 댓글들 찾기
      // 게시글 삭제 시점과 같은 시간(또는 매우 가까운 시간)에 삭제된 댓글들만 복원
      final commentsSnapshot = await _firestore
          .collection(_commentCollection)
          .where('postId', isEqualTo: postId)
          .where('isDeleted', isEqualTo: true)
          .get();
      
      if (commentsSnapshot.docs.isNotEmpty && postDeletedAt != null) {
        final batch = _firestore.batch();
        final postDeletedDateTime = postDeletedAt.toDate();
        
        for (final doc in commentsSnapshot.docs) {
          final commentData = doc.data();
          final commentDeletedAt = commentData['deletedAt'] as Timestamp?;
          
          // 게시글 삭제 시점과 함께 삭제된 댓글만 복원
          // (게시글 삭제 시간 이후에 삭제된 댓글이 아니고, 게시글 삭제 시간과 같은 시간 또는 매우 가까운 시간에 삭제된 댓글만)
          if (commentDeletedAt != null) {
            final commentDeletedDateTime = commentDeletedAt.toDate();
            final timeDifference = commentDeletedDateTime.difference(postDeletedDateTime).inSeconds.abs();
            
            // 게시글 삭제 시간 이전에 삭제된 댓글은 복원하지 않음
            // (게시글 삭제 전에 이미 삭제된 댓글은 복원하지 않음)
            if (commentDeletedDateTime.isBefore(postDeletedDateTime)) {
              // 게시글 삭제 전에 이미 삭제된 댓글은 복원하지 않음
              continue;
            }
            
            // 게시글 삭제 시간과 같은 시간 또는 그 이후에 삭제된 댓글만 복원
            // 게시글 삭제 후 5초 이내에 삭제된 댓글만 복원 (게시글 삭제와 함께 삭제된 댓글)
            if (timeDifference <= 5) {
              // 게시글 삭제와 함께 삭제된 댓글 복원
              batch.update(doc.reference, {
                'isDeleted': false,
                'deletedAt': FieldValue.delete(), // deletedAt 필드 제거
              });
            }
            // 게시글 삭제 후 5초 이후에 삭제된 댓글은 복원하지 않음
          }
        }
        await batch.commit();
      }
      
      return true;
    } catch (e) {
      print('Error restoring post: $e');
      return false;
    }
  }

  // 조회수 증가
  Future<void> incrementViews(String postId) async {
    try {
      await _firestore.collection(_collection).doc(postId).update({
        'views': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error incrementing views: $e');
    }
  }

  // 댓글 관련 메서드
  final String _commentCollection = 'comments';

  // 특정 게시글의 댓글 목록 가져오기 (실시간, 최신순, 삭제되지 않은 것만)
  // 일반 댓글만 가져오고, 대댓글은 별도로 가져와서 연결
  Stream<List<Comment>> getComments(String postId) {
    return _firestore
        .collection(_commentCollection)
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: false) // 오래된 댓글부터
        .snapshots()
        .map((snapshot) {
          final allComments = snapshot.docs
              .map((doc) => Comment.fromFirestore(doc.data(), doc.id))
              .where((c) => !c.isDeleted) // 클라이언트 측에서 필터링 (기존 데이터 호환)
              .toList();
          
          // 일반 댓글과 대댓글을 분리
          final rootComments = allComments.where((c) => c.isRootComment).toList();
          final replies = allComments.where((c) => c.isReply).toList();
          
          // 대댓글을 부모 댓글에 연결
          for (final reply in replies) {
            final parentIndex = rootComments.indexWhere(
              (c) => c.id == reply.parentCommentId,
            );
            if (parentIndex != -1) {
              // 부모 댓글 다음에 대댓글 삽입 (간단한 트리 구조)
              // 실제로는 댓글과 대댓글을 함께 정렬하여 반환
            }
          }
          
          // 모든 댓글을 시간순으로 정렬 (일반 댓글 먼저, 그 다음 대댓글)
          final sortedComments = <Comment>[];
          for (final root in rootComments) {
            sortedComments.add(root);
            // 이 댓글의 대댓글들을 찾아서 추가
            final commentReplies = replies
                .where((r) => r.parentCommentId == root.id)
                .toList()
              ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
            sortedComments.addAll(commentReplies);
          }
          
          return sortedComments;
        });
  }

  // 댓글 작성
  Future<String?> createComment(Comment comment) async {
    try {
      // isDeleted는 기본값 false로 생성
      final commentData = comment.toFirestore();
      commentData['isDeleted'] = false;
      final docRef = await _firestore
          .collection(_commentCollection)
          .add(commentData);
      return docRef.id;
    } catch (e) {
      print('Error creating comment: $e');
      return null;
    }
  }

  // 댓글 삭제 (소프트 삭제 - isDeleted = true로 변경)
  // 대댓글도 함께 삭제 (부모 댓글이 삭제되면 대댓글도 삭제)
  Future<bool> deleteComment(String commentId) async {
    try {
      final now = Timestamp.fromDate(DateTime.now());
      
      // 댓글을 소프트 삭제 (isDeleted = true)
      await _firestore.collection(_commentCollection).doc(commentId).update({
        'isDeleted': true,
        'deletedAt': now,
      });
      
      // 이 댓글의 모든 대댓글도 소프트 삭제 (isDeleted가 false인 것만)
      final repliesSnapshot = await _firestore
          .collection(_commentCollection)
          .where('parentCommentId', isEqualTo: commentId)
          .get();
      
      // 클라이언트 측에서 필터링 (기존 데이터 호환)
      final activeReplies = repliesSnapshot.docs.where((doc) {
        final data = doc.data();
        return data['isDeleted'] != true;
      }).toList();
      
      if (activeReplies.isNotEmpty) {
        final batch = _firestore.batch();
        for (final doc in activeReplies) {
          batch.update(doc.reference, {
            'isDeleted': true,
            'deletedAt': now,
          });
        }
        await batch.commit();
      }
      
      return true;
    } catch (e) {
      print('Error deleting comment: $e');
      return false;
    }
  }

  // 댓글 복원 (isDeleted = false로 변경, 대댓글도 함께 복원)
  // 댓글 삭제 시점 이후에 삭제된 대댓글들만 복원
  Future<bool> restoreComment(String commentId) async {
    try {
      // 댓글 정보 가져오기 (deletedAt 확인용)
      final commentDoc = await _firestore.collection(_commentCollection).doc(commentId).get();
      if (!commentDoc.exists || commentDoc.data() == null) {
        return false;
      }
      
      final commentData = commentDoc.data()!;
      final commentDeletedAt = commentData['deletedAt'] as Timestamp?;
      
      // 댓글을 복원 (isDeleted = false)
      await _firestore.collection(_commentCollection).doc(commentId).update({
        'isDeleted': false,
        'deletedAt': FieldValue.delete(), // deletedAt 필드 제거
      });
      
      // 이 댓글의 삭제된 대댓글들 찾기
      // 댓글 삭제 시점 이후에 삭제된 대댓글들만 복원
      final repliesSnapshot = await _firestore
          .collection(_commentCollection)
          .where('parentCommentId', isEqualTo: commentId)
          .where('isDeleted', isEqualTo: true)
          .get();
      
      if (repliesSnapshot.docs.isNotEmpty && commentDeletedAt != null) {
        final batch = _firestore.batch();
        final commentDeletedDateTime = commentDeletedAt.toDate();
        
        for (final doc in repliesSnapshot.docs) {
          final replyData = doc.data();
          final replyDeletedAt = replyData['deletedAt'] as Timestamp?;
          
          // 댓글 삭제 시점 이후에 삭제된 대댓글만 복원
          // (댓글 삭제와 함께 삭제된 대댓글들만 복원)
          if (replyDeletedAt != null) {
            final replyDeletedDateTime = replyDeletedAt.toDate();
            // 댓글 삭제 시간과 대댓글 삭제 시간이 같거나 대댓글이 그 이후에 삭제된 경우
            // (댓글 삭제와 함께 삭제된 대댓글들)
            if (replyDeletedDateTime.isAfter(commentDeletedDateTime) || 
                replyDeletedDateTime.isAtSameMomentAs(commentDeletedDateTime) ||
                (replyDeletedDateTime.difference(commentDeletedDateTime).inSeconds.abs() <= 5)) { // 5초 오차 허용
              // 대댓글 복원
              batch.update(doc.reference, {
                'isDeleted': false,
                'deletedAt': FieldValue.delete(), // deletedAt 필드 제거
              });
            }
          }
        }
        await batch.commit();
      }
      
      return true;
    } catch (e) {
      print('Error restoring comment: $e');
      return false;
    }
  }

  // 댓글 수정
  Future<bool> updateComment(String commentId, String content) async {
    try {
      // 현재 댓글 가져오기
      final doc = await _firestore
          .collection(_commentCollection)
          .doc(commentId)
          .get();
      if (!doc.exists || doc.data() == null) {
        return false;
      }

      final currentData = doc.data()!;
      final now = DateTime.now();

      // 기존 수정 히스토리 가져오기
      List<DateTime> history = [];
      if (currentData['updatedAtHistory'] != null) {
        final historyData = currentData['updatedAtHistory'] as List<dynamic>;
        history = historyData
            .map((timestamp) => (timestamp as Timestamp).toDate())
            .toList();
      }

      // 새로운 수정 시간 추가
      history.add(now);

      await _firestore.collection(_commentCollection).doc(commentId).update({
        'content': content,
        'updatedAt': Timestamp.fromDate(now),
        'updatedAtHistory':
            history.map((date) => Timestamp.fromDate(date)).toList(),
      });
      return true;
    } catch (e) {
      print('Error updating comment: $e');
      return false;
    }
  }
}

