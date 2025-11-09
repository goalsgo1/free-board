import 'package:flutter/foundation.dart';
import 'package:free_board/models/comment.dart';
import 'package:free_board/services/firestore_service.dart';

class CommentProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  final Map<String, List<Comment>> _commentsByPostId = {}; // postId -> comments
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Comment> getComments(String postId) {
    return _commentsByPostId[postId] ?? [];
  }

  // 특정 게시글의 댓글 목록 초기화 (실시간)
  void initComments(String postId) {
    _firestoreService.getComments(postId).listen(
      (comments) {
        _commentsByPostId[postId] = comments;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // 댓글 생성
  Future<bool> createComment({
    required String postId,
    required String content,
    required String author,
    required String userId,
    String? parentCommentId,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final comment = Comment(
        id: '', // Firestore에서 자동 생성
        postId: postId,
        parentCommentId: parentCommentId,
        content: content,
        author: author,
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final commentId = await _firestoreService.createComment(comment);
      _isLoading = false;
      notifyListeners();
      return commentId != null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 댓글 수정
  Future<bool> updateComment({
    required String commentId,
    required String content,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.updateComment(commentId, content);
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 댓글 삭제 (소프트 삭제)
  Future<bool> deleteComment(String commentId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.deleteComment(commentId);
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 댓글 복원
  Future<bool> restoreComment(String commentId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.restoreComment(commentId);
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 오류 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // 특정 게시글의 댓글 캐시 제거
  void clearComments(String postId) {
    _commentsByPostId.remove(postId);
    notifyListeners();
  }
}

