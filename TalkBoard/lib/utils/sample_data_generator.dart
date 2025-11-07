import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SampleDataGenerator {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 샘플 데이터 제목 목록 (삭제 시 식별용)
  static const List<String> _samplePostTitles = [
    '기억의 정원에 오신 것을 환영합니다!',
    'Flutter와 Firebase로 만든 추모관 앱',
    '댓글 기능 사용 방법',
    '게시글 작성 팁',
    '안드로이드와 iOS 모두 지원',
  ];

  /// 샘플 데이터 삭제
  Future<void> deleteSampleData() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final batch = _firestore.batch();
    final postsCollection = _firestore.collection('posts');
    final commentsCollection = _firestore.collection('comments');

    // 1. 샘플 게시글 찾기 및 삭제
    final allPosts = await postsCollection
        .where('userId', isEqualTo: user.uid)
        .get();

    final samplePostIds = <String>[];

    for (var doc in allPosts.docs) {
      final data = doc.data();
      final title = data['title'] as String? ?? '';
      
      // 샘플 데이터 제목 목록에 포함된 경우
      if (_samplePostTitles.contains(title)) {
        samplePostIds.add(doc.id);
        batch.delete(doc.reference);
      }
    }

    // 2. 샘플 게시글의 댓글도 삭제
    if (samplePostIds.isNotEmpty) {
      final allComments = await commentsCollection
          .where('postId', whereIn: samplePostIds.length > 10 
              ? samplePostIds.take(10).toList()  // Firestore whereIn 제한 (10개)
              : samplePostIds)
          .get();

      // 더 많은 댓글이 있을 수 있으므로 추가 처리
      if (samplePostIds.length > 10) {
        for (var i = 1; i * 10 < samplePostIds.length; i++) {
          final batchIds = samplePostIds.skip(i * 10).take(10).toList();
          final additionalComments = await commentsCollection
              .where('postId', whereIn: batchIds)
              .get();
          for (var doc in additionalComments.docs) {
            batch.delete(doc.reference);
          }
        }
      }

      for (var doc in allComments.docs) {
        batch.delete(doc.reference);
      }
    }

    await batch.commit();
    print('✅ 샘플 데이터 ${samplePostIds.length}개 게시글과 관련 댓글이 삭제되었습니다.');
  }

  /// 샘플 게시글 데이터 생성
  Future<void> generateSamplePosts() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final batch = _firestore.batch();
    final postsCollection = _firestore.collection('posts');

    // 샘플 게시글 목록
    final samplePosts = [
      {
        'title': '기억의 정원에 오신 것을 환영합니다!',
        'content': '''안녕하세요! 기억의 정원은 Firebase 기반의 디지털 추모관 애플리케이션입니다.

주요 기능:
• 게시글 작성, 수정, 삭제
• 댓글 및 대댓글 기능
• 실시간 조회수 업데이트
• 수정 히스토리 관리

자유롭게 게시글을 작성하고 소통해보세요!''',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'views': 125,
      },
      {
        'title': 'Flutter와 Firebase로 만든 게시판 앱',
        'content': '''이 앱은 Flutter 프레임워크와 Firebase를 사용하여 만들었습니다.

기술 스택:
- Flutter 3.8.1+
- Firebase Firestore
- Firebase Authentication
- Provider 패턴

실시간 동기화가 가능하고, 안전한 인증 시스템을 갖추고 있습니다.''',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'views': 89,
      },
      {
        'title': '댓글 기능 사용 방법',
        'content': '''게시글 하단의 댓글 작성란에 댓글을 입력할 수 있습니다.

• 댓글 작성: 게시글 하단 입력란에 댓글 입력
• 대댓글 작성: 댓글 옆 "답글" 버튼 클릭
• 댓글 수정: 내가 작성한 댓글은 수정 가능
• 댓글 삭제: 내가 작성한 댓글은 삭제 가능

질문이나 의견을 자유롭게 남겨주세요!''',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'views': 156,
      },
      {
        'title': '게시글 작성 팁',
        'content': '''게시글을 작성할 때 다음 사항을 참고하세요:

1. 제목은 간결하고 명확하게 작성
2. 내용은 충분히 설명하고 예시 포함
3. 관련 이미지나 링크가 있다면 포함
4. 다른 사용자와의 소통을 고려한 내용 작성

좋은 게시글이 많을수록 커뮤니티가 활성화됩니다!''',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'views': 203,
      },
      {
        'title': '안드로이드와 iOS 모두 지원',
        'content': '''기억의 정원은 크로스 플랫폼 앱입니다.

• Android에서 사용 가능
• iOS에서 사용 가능
• 웹에서도 사용 가능

어디서나 접속하여 게시글을 작성하고 읽을 수 있습니다!''',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'views': 67,
      },
    ];

    final now = DateTime.now();
    
    for (var i = 0; i < samplePosts.length; i++) {
      final postData = samplePosts[i];
      final postRef = postsCollection.doc();
      
      // 게시글 생성 시간을 조금씩 다르게 설정 (최근 3일간)
      final createdAt = now.subtract(Duration(days: 3 - i));
      final updatedAt = createdAt;

      batch.set(postRef, {
        'title': postData['title'],
        'content': postData['content'],
        'author': postData['author'],
        'userId': postData['userId'],
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'updatedAtHistory': [],
        'views': postData['views'],
        'isDeleted': false,
      });
    }

    await batch.commit();
    print('✅ 샘플 게시글 ${samplePosts.length}개가 생성되었습니다.');
  }

  /// 특정 게시글에 샘플 댓글 데이터 생성
  Future<void> generateSampleComments(String postId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final batch = _firestore.batch();
    final commentsCollection = _firestore.collection('comments');

    // 샘플 댓글 목록
    final sampleComments = [
      {
        'content': '좋은 정보 감사합니다!',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'isRootComment': true,
      },
      {
        'content': '정말 유용한 내용이네요. 많은 도움이 되었습니다.',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'isRootComment': true,
      },
      {
        'content': '추가로 궁금한 점이 있습니다.',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'isRootComment': true,
      },
    ];

    final now = DateTime.now();
    String? parentCommentId;

    for (var i = 0; i < sampleComments.length; i++) {
      final commentData = sampleComments[i];
      final commentRef = commentsCollection.doc();
      
      // 첫 번째 댓글에 대댓글 추가
      if (i == 0) {
        parentCommentId = commentRef.id;
      }

      // 댓글 생성 시간을 조금씩 다르게 설정
      final createdAt = now.subtract(Duration(minutes: (sampleComments.length - i) * 10));
      final updatedAt = createdAt;

      final commentMap = {
        'postId': postId,
        'content': commentData['content'],
        'author': commentData['author'],
        'userId': commentData['userId'],
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
        'updatedAtHistory': [],
        'isDeleted': false,
      };

      // 첫 번째 댓글이 아니면 두 번째 댓글에 대댓글 추가
      if (i == 1 && parentCommentId != null) {
        commentMap['parentCommentId'] = parentCommentId;
      }

      batch.set(commentRef, commentMap);
    }

    // 첫 번째 댓글에 대댓글 추가
    if (parentCommentId != null) {
      final replyRef = commentsCollection.doc();
      final createdAt = now.subtract(const Duration(minutes: 5));
      
      batch.set(replyRef, {
        'postId': postId,
        'parentCommentId': parentCommentId,
        'content': '저도 궁금했습니다! 답변 감사합니다.',
        'author': user.displayName ?? '사용자',
        'userId': user.uid,
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(createdAt),
        'updatedAtHistory': [],
        'isDeleted': false,
      });
    }

    await batch.commit();
    print('✅ 샘플 댓글이 생성되었습니다.');
  }

  /// 모든 샘플 데이터 생성 (게시글 + 댓글)
  Future<void> generateAllSampleData() async {
    try {
      // 기존 샘플 데이터가 있으면 먼저 삭제
      await deleteSampleData();
      
      // 1. 샘플 게시글 생성
      await generateSamplePosts();
      
      // 2. 첫 번째 게시글에 댓글 추가
      // 인덱스 없이 작동하도록 클라이언트 측 필터링 사용
      final allPosts = await _firestore.collection('posts')
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      // 클라이언트 측에서 필터링
      final userPosts = allPosts.docs
          .where((doc) {
            final data = doc.data();
            return data['userId'] == _auth.currentUser!.uid && 
                   (data['isDeleted'] ?? false) == false;
          })
          .toList();

      if (userPosts.isNotEmpty) {
        // 샘플 게시글 중 첫 번째 찾기
        var samplePost = userPosts.first;
        
        // 샘플 게시글 제목과 일치하는 게시글 찾기
        for (var doc in userPosts) {
          final data = doc.data();
          final title = data['title'] as String? ?? '';
          if (_samplePostTitles.contains(title)) {
            samplePost = doc;
            break;
          }
        }
        
        final firstPostId = samplePost.id;
        await generateSampleComments(firstPostId);
      }

      print('✅ 모든 샘플 데이터 생성이 완료되었습니다!');
    } catch (e) {
      print('❌ 샘플 데이터 생성 실패: $e');
      rethrow;
    }
  }
}

