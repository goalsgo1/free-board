import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 현재 사용자 가져오기
  User? get currentUser => _auth.currentUser;

  // 인증 상태 스트림
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 회원가입 (이메일/비밀번호)
  Future<UserCredential?> signUpWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // 사용자 표시 이름 업데이트
      await credential.user?.updateDisplayName(displayName);
      await credential.user?.reload();
      
      return credential;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  // 로그인 (이메일/비밀번호)
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 현재 사용자 ID 가져오기
  String? get currentUserId => _auth.currentUser?.uid;

  // 현재 사용자 이메일 가져오기
  String? get currentUserEmail => _auth.currentUser?.email;

  // 현재 사용자 표시 이름 가져오기
  String get currentUserDisplayName {
    final user = _auth.currentUser;
    return user?.displayName ?? user?.email?.split('@')[0] ?? '익명';
  }
}

