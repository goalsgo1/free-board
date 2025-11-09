import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_board/services/auth_service.dart';

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
  bool get isEmailVerified => _currentUser?.emailVerified ?? false;
  
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
      await _authService.sendEmailVerification();
      await _authService.reloadCurrentUser();
      _currentUser = _authService.currentUser;
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
      await _authService.reloadCurrentUser();
      _currentUser = _authService.currentUser;
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

  Future<bool> signInAnonymously() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signInAnonymously();
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
      _errorMessage = '게스트 로그인 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<PhoneVerificationResult?> startPhoneSignIn(String phoneNumber) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final result = await _authService.verifyPhoneNumber(phoneNumber);

      if (result.credential != null) {
        final userCredential =
            await _authService.signInWithPhoneCredential(result.credential!);
        _currentUser = userCredential.user;
        _isLoading = false;
        notifyListeners();
        return PhoneVerificationResult(userCredential: userCredential);
      }

      if (result.verificationId != null) {
        _isLoading = false;
        notifyListeners();
        return PhoneVerificationResult(verificationId: result.verificationId);
      }

      _errorMessage = '휴대폰 인증을 완료할 수 없습니다. 다시 시도해주세요.';
      _isLoading = false;
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return null;
    } catch (e) {
      _errorMessage = '휴대폰 인증 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> confirmSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential =
          await _authService.signInWithPhoneCredential(credential);
      _currentUser = userCredential.user;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = '인증 코드 확인 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signInWithGoogle();
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
      _errorMessage = 'Google 로그인 중 오류가 발생했습니다: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final credential = await _authService.signInWithApple();
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
      _errorMessage = 'Apple 로그인 중 오류가 발생했습니다: ${e.toString()}';
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
      case 'account-exists-with-different-credential':
        return '이미 다른 로그인 방식으로 가입된 이메일입니다. 기존 로그인 방법으로 로그인해주세요.';
      case 'credential-already-in-use':
        return '이미 사용 중인 로그인 자격 증명입니다.';
      case 'sign_in-canceled':
        return 'Google 로그인을 취소했습니다.';
      case 'google-sign-in-error':
        return 'Google 로그인 중 오류가 발생했습니다.';
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

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _errorMessage = null;
      await _authService.sendPasswordResetEmail(email);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = '비밀번호 재설정 중 오류가 발생했습니다: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendEmailVerification() async {
    try {
      _errorMessage = null;
      await _authService.sendEmailVerification();
      await _authService.reloadCurrentUser();
      _currentUser = _authService.currentUser;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = '이메일 인증 메일 전송 중 오류가 발생했습니다: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<void> refreshCurrentUser() async {
    await _authService.reloadCurrentUser();
    _currentUser = _authService.currentUser;
    notifyListeners();
  }

  Future<String> signInWithSocial(String providerName) async {
    return '$providerName 소셜 로그인은 준비 중입니다.';
  }
}

class PhoneVerificationResult {
  PhoneVerificationResult({this.verificationId, this.userCredential});

  final String? verificationId;
  final UserCredential? userCredential;

  bool get isAutoVerified => userCredential != null;
}

