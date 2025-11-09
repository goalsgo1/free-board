import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:free_board/providers/auth_provider.dart';
import 'package:free_board/screens/privacy_policy_screen.dart';
import 'package:free_board/screens/components_guide_screen.dart';
import 'package:free_board/screens/ui_preview_screen.dart';
import 'package:free_board/screens/database_structure_screen.dart';
import 'package:free_board/widgets/components/app_buttons.dart';
import 'package:free_board/widgets/components/app_card.dart';
import 'package:free_board/widgets/components/app_inputs.dart';
import 'package:free_board/widgets/components/app_palette.dart';

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
        } else if (success && mounted) {
          final message = authProvider.isEmailVerified
              ? '로그인되었습니다.'
              : '로그인되었습니다. 이메일 인증을 완료하면 모든 기능을 이용할 수 있어요.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor:
                  authProvider.isEmailVerified ? Colors.green : Colors.orange,
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
              content: Text('회원가입이 완료되었습니다. 이메일 인증 메일을 확인해주세요.'),
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

  Future<void> _showPasswordResetDialog() async {
    final emailController =
        TextEditingController(text: _emailController.text.trim());
    final enteredEmail = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('비밀번호 재설정'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: '이메일',
              hintText: 'example@email.com',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, emailController.text.trim()),
              child: const Text('재설정 메일 보내기'),
            ),
          ],
        );
      },
    );
    emailController.dispose();

    if (!mounted || enteredEmail == null || enteredEmail.isEmpty) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success =
        await authProvider.sendPasswordResetEmail(enteredEmail.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '비밀번호 재설정 이메일을 전송했습니다.'
              : authProvider.errorMessage ??
                  '비밀번호 재설정 이메일 전송에 실패했습니다.',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _handleResendVerification() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.currentUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일 인증 메일을 보내려면 먼저 로그인해주세요.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final success = await authProvider.sendEmailVerification();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '이메일 인증 메일을 전송했습니다.'
              : authProvider.errorMessage ??
                  '이메일 인증 메일 전송에 실패했습니다.',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _handleSocialLogin(String providerName) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final message = await authProvider.signInWithSocial(providerName);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blueGrey[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.softCream,
      appBar: AppBar(
        title: Text(_isLogin ? '로그인' : '회원가입'),
        backgroundColor: AppPalette.warmBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.auto_fix_high),
              tooltip: '샘플 데이터 입력 (개발용)',
              onPressed: _fillSampleData,
            ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSurfaceCard(
                  title: _isLogin ? '기억의 정원 로그인' : '새 계정 만들기',
                  subtitle: _isLogin
                      ? '로그인하여 기억의 정원을 이용하세요.'
                      : '소중한 추억을 간직할 새 계정을 생성하세요.',
                  icon: _isLogin ? Icons.lock_open_rounded : Icons.person_add_alt_1,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!_isLogin) ...[
                          AppTextField(
                            controller: _displayNameController,
                            focusNode: _displayNameFocusNode,
                            label: '이름',
                            hint: '이름을 입력하세요',
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(Icons.person_outline),
                            validator: (value) {
                              if (!_isLogin && (value == null || value.trim().isEmpty)) {
                                return '이름을 입력해주세요';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                          ),
                          const SizedBox(height: 16),
                        ],
                        AppTextField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          label: '이메일',
                          hint: 'example@email.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '이메일을 입력해주세요';
                            }
                            if (!value.contains('@')) {
                              return '올바른 이메일 형식이 아닙니다';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          label: '비밀번호',
                          hint: '비밀번호를 입력하세요',
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppPalette.warmBrown,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '비밀번호를 입력해주세요';
                            }
                            if (value.length < 6) {
                              return '비밀번호는 최소 6자 이상이어야 합니다';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) => _submit(),
                        ),
                        const SizedBox(height: 24),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return AppPrimaryButton(
                              label: _isLogin ? '로그인' : '회원가입',
                              icon: _isLogin ? Icons.login_rounded : Icons.person_add_alt_1,
                              onPressed: authProvider.isLoading ? null : _submit,
                              isLoading: authProvider.isLoading,
                              accentColor: AppPalette.warmBrown,
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        if (_isLogin)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _showPasswordResetDialog,
                              style: TextButton.styleFrom(
                                foregroundColor: AppPalette.warmBrown,
                              ),
                              child: const Text('비밀번호를 잊으셨나요?'),
                            ),
                          ),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return TextButton(
                              onPressed: authProvider.isLoading ? null : _handleResendVerification,
                              style: TextButton.styleFrom(
                                foregroundColor: AppPalette.warmBrown,
                              ),
                              child: const Text('이메일 인증 메일 다시 보내기'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            '소셜 계정으로 계속하기',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppPalette.warmBrown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<AuthProvider>(
                          builder: (context, authProvider, child) {
                            return Column(
                              children: [
                                AppOutlinedButton(
                                  label: 'Google로 계속하기',
                                  leadingIcon: Icons.g_mobiledata,
                                  badgeText: '준비 중',
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : () => _handleSocialLogin('Google'),
                                ),
                                const SizedBox(height: 8),
                                AppOutlinedButton(
                                  label: 'Apple로 계속하기',
                                  leadingIcon: Icons.apple,
                                  badgeText: '준비 중',
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : () => _handleSocialLogin('Apple'),
                                ),
                                const SizedBox(height: 8),
                                AppOutlinedButton(
                                  label: '전화번호로 계속하기',
                                  leadingIcon: Icons.phone,
                                  badgeText: '준비 중',
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : () => _handleSocialLogin('전화번호 로그인'),
                                ),
                                const SizedBox(height: 8),
                                AppOutlinedButton(
                                  label: '게스트로 둘러보기',
                                  leadingIcon: Icons.person_outline,
                                  badgeText: '준비 중',
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : () => _handleSocialLogin('익명 로그인'),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AppHelperText(
                          icon: Icons.info_outline,
                          text: _isLogin
                              ? '로그인 후 이메일 인증이 완료되지 않은 계정은 주요 기능이 제한됩니다.'
                              : '회원가입 직후 이메일 인증 메일이 전송되며, 인증 완료 전까지 일부 기능이 제한됩니다.',
                        ),
                        const SizedBox(height: 16),
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
                              style: TextButton.styleFrom(
                                foregroundColor: AppPalette.deepBlue,
                                textStyle: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              child: Text(
                                _isLogin
                                    ? '계정이 없으신가요? 회원가입'
                                    : '이미 계정이 있으신가요? 로그인',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppPalette.warmBrown,
                      textStyle: const TextStyle(decoration: TextDecoration.underline),
                    ),
                    child: const Text('개인정보처리방침'),
                  ),
                ),
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
                      foregroundColor: AppPalette.caption,
                      side: const BorderSide(color: AppPalette.warmBeige),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
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
                    foregroundColor: AppPalette.deepBlue,
                    side: const BorderSide(color: Color(0xFF90CAF9)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
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
                    foregroundColor: Colors.green.shade700,
                    side: const BorderSide(color: Color(0xFFA5D6A7)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

