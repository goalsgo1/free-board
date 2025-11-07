import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'privacy_policy_screen.dart';
import 'components_guide_screen.dart';
import 'ui_preview_screen.dart';
import 'database_structure_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true; // true: 로그인, false: 회원가입
  bool _obscurePassword = true;

  // 로그인/회원가입 공통 필드
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();

  // FocusNode for Tab navigation
  final _displayNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    _displayNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (_isLogin) {
        // 로그인
        final success = await authProvider.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? '로그인에 실패했습니다. 이메일과 비밀번호를 확인해주세요.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // 회원가입
        if (_displayNameController.text.trim().isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('이름을 입력해주세요.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        final success = await authProvider.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          displayName: _displayNameController.text.trim(),
        );

        if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? '회원가입에 실패했습니다.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('회원가입이 완료되었습니다.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }
  }

  /// 스크린샷용 샘플 데이터 자동 입력
  void _fillSampleData() {
    if (!_isLogin) {
      // 회원가입 모드일 때만
      _displayNameController.text = '테스트 사용자';
      _emailController.text = 'test@example.com';
      _passwordController.text = 'password123';
    } else {
      // 로그인 모드일 때
      _emailController.text = 'test@example.com';
      _passwordController.text = 'password123';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? '로그인' : '회원가입'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // 디버그 모드에서만 샘플 데이터 입력 버튼 표시
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.auto_fix_high),
              tooltip: '샘플 데이터 입력 (개발용)',
              onPressed: _fillSampleData,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 타이틀
              Text(
                _isLogin ? '기억의 정원' : '회원가입',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin
                    ? '로그인하여 기억의 정원을 이용하세요'
                    : '새 계정을 만들어 시작하세요',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // 회원가입 시에만 표시되는 이름 필드
              if (!_isLogin) ...[
                TextFormField(
                  controller: _displayNameController,
                  focusNode: _displayNameFocusNode,
                  decoration: const InputDecoration(
                    labelText: '이름',
                    hintText: '이름을 입력하세요',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    _emailFocusNode.requestFocus();
                  },
                  validator: (value) {
                    if (!_isLogin && (value == null || value.trim().isEmpty)) {
                      return '이름을 입력해주세요';
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
              ],
              // 이메일 필드
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  hintText: 'example@email.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _passwordFocusNode.requestFocus();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '이메일을 입력해주세요';
                  }
                  if (!value.contains('@')) {
                    return '올바른 이메일 형식이 아닙니다';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 비밀번호 필드
              TextFormField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력하세요',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  // Enter 키를 누르면 폼 제출
                  _submit();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 최소 6자 이상이어야 합니다';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // 로그인/회원가입 버튼
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return ElevatedButton(
                    onPressed: authProvider.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _isLogin ? '로그인' : '회원가입',
                            style: const TextStyle(fontSize: 16),
                          ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // 로그인/회원가입 전환 버튼
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return TextButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () {
                            setState(() {
                              _isLogin = !_isLogin;
                              _formKey.currentState?.reset();
                            });
                          },
                    child: Text(
                      _isLogin
                          ? '계정이 없으신가요? 회원가입'
                          : '이미 계정이 있으신가요? 로그인',
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // 개인정보처리방침 링크
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                    child: Text(
                      '개인정보처리방침',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              // 디버그 모드에서만 공통 컴포넌트 가이드 버튼 표시
              if (kDebugMode) ...[
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComponentsGuideScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.widgets),
                  label: const Text('공통 컴포넌트 가이드'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ],
              // UI 프리뷰 버튼 (항상 표시)
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UIPreviewScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.visibility),
                label: const Text('UI 프리뷰'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue[700],
                  side: BorderSide(color: Colors.blue[300]!),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              // 데이터베이스 구조 버튼 (항상 표시)
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DatabaseStructureScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.storage),
                label: const Text('데이터베이스 구조'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green[700],
                  side: BorderSide(color: Colors.green[300]!),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

