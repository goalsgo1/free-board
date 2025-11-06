import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider() {
    _initAuth();
  }

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentUserId => _currentUser?.uid;
  
  bool get isAuthenticated => _currentUser != null;

  // 인증 상태 초기화
  void _initAuth() {
    _authService.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  // 회원가입
  Future<bool> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signUpWithEmail(
        email,
        password,
        displayName,
      );

      _currentUser = credential.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = '회원가입 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 로그인
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signInWithEmail(email, password);

      _currentUser = credential.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = '로그인 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Firebase 에러 코드를 사용자 친화적인 메시지로 변환
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
      case 'wrong-password':
        return '이메일 또는 비밀번호가 올바르지 않습니다.';
      case 'user-not-found':
        return '등록되지 않은 이메일입니다.';
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'weak-password':
        return '비밀번호가 너무 약합니다. 6자 이상 입력해주세요.';
      case 'invalid-email':
        return '올바른 이메일 형식이 아닙니다.';
      case 'user-disabled':
        return '비활성화된 계정입니다.';
      case 'too-many-requests':
        return '너무 많은 시도가 있었습니다. 잠시 후 다시 시도해주세요.';
      case 'operation-not-allowed':
        return '이메일/비밀번호 로그인이 활성화되지 않았습니다. Firebase Console에서 설정을 확인해주세요.';
      case 'network-request-failed':
        return '네트워크 연결을 확인해주세요.';
      default:
        return '인증 오류가 발생했습니다: ${e.message ?? e.code}';
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.signOut();
      _currentUser = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // 오류 메시지 초기화
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

