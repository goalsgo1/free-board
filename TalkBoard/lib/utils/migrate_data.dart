// 데이터 마이그레이션 유틸리티
// 기존 게시글과 댓글에 isDeleted 필드를 추가하는 스크립트
// 한 번만 실행하면 됩니다

import 'package:cloud_firestore/cloud_firestore.dart';

class DataMigration {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 기존 게시글에 isDeleted 필드 추가
  Future<void> migratePosts() async {
    try {
      print('게시글 마이그레이션 시작...');
      
      final postsSnapshot = await _firestore.collection('posts').get();
      final batch = _firestore.batch();
      int count = 0;
      
      for (final doc in postsSnapshot.docs) {
        final data = doc.data();
        
        // isDeleted 필드가 없으면 false로 추가
        if (!data.containsKey('isDeleted')) {
          batch.update(doc.reference, {
            'isDeleted': false,
          });
          count++;
        }
      }
      
      if (count > 0) {
        await batch.commit();
        print('게시글 마이그레이션 완료: $count개 게시글 업데이트됨');
      } else {
        print('업데이트할 게시글이 없습니다.');
      }
    } catch (e) {
      print('게시글 마이그레이션 오류: $e');
    }
  }

  // 기존 댓글에 isDeleted 필드 추가
  Future<void> migrateComments() async {
    try {
      print('댓글 마이그레이션 시작...');
      
      final commentsSnapshot = await _firestore.collection('comments').get();
      final batch = _firestore.batch();
      int count = 0;
      
      for (final doc in commentsSnapshot.docs) {
        final data = doc.data();
        
        // isDeleted 필드가 없으면 false로 추가
        if (!data.containsKey('isDeleted')) {
          batch.update(doc.reference, {
            'isDeleted': false,
          });
          count++;
        }
      }
      
      if (count > 0) {
        await batch.commit();
        print('댓글 마이그레이션 완료: $count개 댓글 업데이트됨');
      } else {
        print('업데이트할 댓글이 없습니다.');
      }
    } catch (e) {
      print('댓글 마이그레이션 오류: $e');
    }
  }

  // 전체 마이그레이션 실행
  Future<void> migrateAll() async {
    await migratePosts();
    await migrateComments();
    print('모든 마이그레이션이 완료되었습니다.');
  }
}

