import 'package:flutter/foundation.dart';
import '../models/post.dart';
import '../services/firestore_service.dart';

class PostProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Post> _posts = [];
  List<Post> _deletedPosts = [];
  Post? _currentPost;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Post> get posts => _posts;
  List<Post> get deletedPosts => _deletedPosts;
  Post? get currentPost => _currentPost;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  PostProvider() {
    _initPosts();
    // 삭제된 게시글은 initDeletedPosts()를 별도로 호출해야 함 (userId 필요)
  }

  // 게시글 목록 초기화 (실시간)
  void _initPosts() {
    _firestoreService.getPosts().listen(
      (posts) {
        _posts = posts;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // 삭제된 게시글 목록 초기화 (실시간)
  // userId를 받아서 해당 사용자가 작성한 게시글만 가져옴
  void initDeletedPosts(String userId) {
    _firestoreService.getDeletedPosts(userId: userId).listen(
      (posts) {
        _deletedPosts = posts;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // 특정 게시글 가져오기
  Future<void> loadPost(String postId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final post = await _firestoreService.getPost(postId);
      _currentPost = post;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // 게시글 생성
  Future<bool> createPost({
    required String title,
    required String content,
    required String author,
    required String userId,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final post = Post(
        id: '', // Firestore에서 자동 생성
        title: title,
        content: content,
        author: author,
        userId: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final postId = await _firestoreService.createPost(post);
      _isLoading = false;
      notifyListeners();
      return postId != null;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 게시글 수정
  Future<bool> updatePost({
    required String postId,
    required String title,
    required String content,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.updatePost(
        postId,
        title,
        content,
      );

      // 현재 게시글도 업데이트
      if (success && _currentPost?.id == postId) {
        await loadPost(postId);
      }

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

  // 게시글 삭제 (소프트 삭제)
  Future<bool> deletePost(String postId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.deletePost(postId);
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

  // 게시글 복원
  Future<bool> restorePost(String postId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final success = await _firestoreService.restorePost(postId);
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

  // 조회수 증가
  Future<void> incrementViews(String postId) async {
    try {
      await _firestoreService.incrementViews(postId);
      // 현재 게시글도 업데이트
      if (_currentPost?.id == postId) {
        await loadPost(postId);
      }
    } catch (e) {
      print('Error incrementing views: $e');
    }
  }

  // 오류 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // 현재 게시글 초기화
  void clearCurrentPost() {
    _currentPost = null;
    notifyListeners();
  }
}

